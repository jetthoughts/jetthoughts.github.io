#!/usr/bin/env node
/**
 * Critical CSS inlining via Beasties
 * Process Hugo's public/ output to extract and inline above-the-fold critical CSS
 */

import Beasties from 'beasties';
import fs from 'node:fs';
import path from 'node:path';

const target = process.argv[2];

if (!target) {
  console.error('usage: inline-critical.mjs <public-dir>');
  process.exit(1);
}

if (!fs.existsSync(target)) {
  console.error(`Error: directory not found: ${target}`);
  process.exit(1);
}

const beasties = new Beasties({
  path: target,
  publicPath: '/',
  external: true,            // process external stylesheets
  remote: false,             // don't download remote; we convert URLs to relative
  pruneSource: false,        // DO NOT modify source CSS files
  reduceInlineStyles: true,
  mergeStylesheets: false,   // keep the deferred bundle separate
  preload: 'swap',           // <link rel="preload" as="style" onload="this.rel='stylesheet'">
  noscriptFallback: true,    // add <noscript> fallback for swap strategy
  inlineFonts: false,        // fonts already preloaded via headers
  logLevel: 'info',
});

/**
 * Temporarily convert absolute CSS URLs to relative for Beasties processing.
 * Hugo outputs absolute URLs (e.g., https://jetthoughts.com/css/... or http://localhost:1313/css/...)
 * Beasties needs relative paths to find the files locally.
 *
 * This extraction stores the original domain so we can restore it later.
 */
let originalDomain = null;

function makeUrlsRelative(html) {
  // Capture the domain from the first absolute URL found
  const domainMatch = html.match(/href="(https?:\/\/[^/]+)(\/[^"]*\.css)/);
  if (domainMatch) {
    originalDomain = domainMatch[1]; // e.g., https://jetthoughts.com or http://localhost:1313
  }
  // Replace any absolute URL pattern with relative path
  return html.replace(/href="https?:\/\/[^/]+\//g, 'href="/');
}

/**
 * Restore absolute URLs after Beasties processing.
 */
function makeUrlsAbsolute(html) {
  if (!originalDomain) {
    console.warn('Warning: originalDomain not set, URLs remain relative');
    return html;
  }
  // Convert relative paths back to absolute
  return html.replace(/href="\/(?!\/)/g, `href="${originalDomain}/`);
}

/**
 * Recursively walk directory tree and process all .html files
 */
async function walk(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      await walk(fullPath);
    } else if (entry.name.endsWith('.html')) {
      try {
        let html = fs.readFileSync(fullPath, 'utf8');
        // Convert absolute URLs to relative for Beasties
        html = makeUrlsRelative(html);
        // Process with Beasties
        const processed = await beasties.process(html);
        // Restore absolute URLs
        const final = makeUrlsAbsolute(processed);
        if (final !== fs.readFileSync(fullPath, 'utf8')) {
          fs.writeFileSync(fullPath, final, 'utf8');
        }
      } catch (err) {
        console.error(`Error processing ${fullPath}:`, err.message);
        process.exit(1);
      }
    }
  }
}

await walk(target).catch(err => {
  console.error('Fatal error:', err.message);
  process.exit(1);
});

console.log('Critical CSS inlining complete.');
