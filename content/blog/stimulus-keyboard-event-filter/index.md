---
dev_to_id: 1698810
dev_to_url: https://dev.to/jetthoughts/stimulus-keyboard-event-filter-4370
title: Stimulus Keyboard Event Filter
description: What it was In the last update of Stimulus v3.2.2, the ability to filter the event by PageDown and...
created_at: '2023-12-15T11:11:52Z'
edited_at: '2024-11-25T15:39:41Z'
draft: false
tags: []
canonical_url: https://jetthoughts.com/blog/stimulus-keyboard-event-filter/
cover_image: 
slug: stimulus-keyboard-event-filter
---
**What it was**
In the last update of Stimulus `v3.2.2`, the ability to filter the event by `PageDown` and `PageUp` keys was added. 

Before that, in `v3.2.1`, it looked like this:

```html
<div data-action="keyup->myController#myfunction"></div>
```
and some like this...
```js
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    // Add a keydown event listener when the controller is connected to the DOM
    document.addEventListener("keydown", this.handleKeyDown);
  }

  disconnect() {
    // Remove the keydown event listener when the controller is disconnected
    document.removeEventListener("keydown", this.handleKeyDown);
  }

  handleKeyDown(event) {
    // Access the pressed key from the event
    const pressedKey = event.key;

    // Do something with the pressed key
    console.log(`Pressed key: ${pressedKey}`);
  }
}
```
**What the new**
For now, you can call `page_up`/`page_down` in action, like:
```html
<div data-action="keydown.page_up->myController#myfunction"></div>
```

It appears that the update introduces a more declarative syntax for handling key events in Stimulus. Instead of manually adding and removing event listeners in the controller, you can now specify the key and event type directly in the HTML using the data-action attribute.

For example, in the updated version, the element is set to trigger the myfunction method in myController specifically on a keydown event for the Page Up key. This makes the code cleaner and more readable, emphasizing the intent directly in the HTML markup.