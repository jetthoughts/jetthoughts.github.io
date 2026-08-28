---
type: Playbook
title: Shell in-place-edit gotchas
description: Traps specific to editing tracked files from the shell (perl/sed one-liners) that a normal Read/Edit tool would not hit — starting with silent UTF-8 corruption from a bare \x{...} escape in perl -e.
tags: [tooling, shell, encoding, perl]
timestamp: 2026-08-28T14:34:59Z
generated:
  by: claude/opus-5
  at: 2026-08-28T14:34:59Z
---

# Overview

Agents sometimes drop to `perl -e` / `sed -i` one-liners for a bulk find/replace
across a tracked file instead of using a structured edit tool. That path has
failure modes a structured editor doesn't: it writes raw bytes with no encoding
awareness.

# perl -0pi -e with a bare \x{...} escape corrupts UTF-8 (2026-08-28)

`perl -0pi -e 's/.../\x{00A7}/' <file>` on a UTF-8 file writes a **lone 0xA7
byte**, not the UTF-8 two-byte sequence for §. Perl runs in byte semantics
without `-C`/`-CSD`, so any `\x{...}` escape above 0x7F breaks the encoding of
the *entire file* from that point on — not just the inserted character.

**The failure is silent and misleading.** `file <path>` reports "Non-ISO
extended-ASCII text" instead of erroring, and `grep` treats the file as binary
and returns **NOTHING** — not zero matches, no output at all. A heading you
just wrote appears not to exist, which reads as "my edit didn't take" rather
than "the file is corrupt", and invites a second wrong fix on top of the first.

**Detection tell**: `grep -c <pattern> <file>` returning empty (no line at
all) instead of printing `0` means the file stopped being valid text — check
encoding before re-editing.

**Verify**: `iconv -f UTF-8 -t UTF-8 <file> >/dev/null` — errors on the first
bad byte if the file is broken, silent if clean.

**Repair**: count the stray bytes first so the fix matches exactly what broke
(`grep -c $'\xa7' <file>` won't work once the file reads as binary — use
`LC_ALL=C grep -c $'\xa7' <file>`), then
`perl -pi -e 's/(?<!\xC2)\xA7/\xC2\xA7/g' <file>` to promote each lone 0xA7 to
the valid two-byte UTF-8 sequence (`\xC2\xA7`) without doubling ones already
correct.

**Rule**: never put a non-ASCII character in a perl `-e` replacement via
`\x{...}`. Type the literal UTF-8 character in the shell string instead — it
passes through the shell as raw bytes unchanged, which is what the file
already uses. This generalizes past perl: any one-liner editor invoked
without an explicit UTF-8 mode is a byte-semantics tool touching a text-
semantics file.

# Citations

[1] Session 2026-08-28, `blog/upgrade-ai-code-review-trust` — a tracked file
    was corrupted and repaired using the procedure above.
