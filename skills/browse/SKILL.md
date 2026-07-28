---
name: browse
description: Drives Musahib's own logged-in browser. Use for anything on the live web — researching a prospect's site and socials, mining creator comment sections for leads, checking LinkedIn or Instagram, reading a page behind a login, screenshotting a build. Trigger phrases — "look at their site", "check his linkedin", "go find", "pull up", "who's commenting on", "screenshot", "/browse".
author: Asadulelah
system: Rook Toolkit
---

# /browse — his browser, driven

> **What this unlocks: the lead-mining method stops being manual.**
>
> The method is comment-mine the creators the ICP follows, open the profiles of people
> commenting with substance, pull the fit signals. Roughly 45 qualified leads a week,
> sourced entirely by hand. With this tool, the opening and reading is driven and the
> judgment stays his.

It connects to **his own browser**, so every login he already has works — LinkedIn,
Instagram, Facebook, Fathom, client portals. Nothing is scraped from the outside and nothing
needs credentials.

---

## Shape of a call

```bash
browser-harness <<'PY'
new_tab("https://www.instagram.com/p/<post>/")
wait_for_load()
print(page_info())
PY
```

- **First navigation is `new_tab(url)`, never `goto_url(url)`** — goto hijacks whatever tab he is actually working in.
- Always use the heredoc form for anything multi-line.
- After navigating, `wait_for_load()`.

---

## How to actually work

**Screenshot first, then decide.** `capture_screenshot()` is the fastest way to understand a
page, find a target, and confirm an action worked. Read the pixel, click the coordinate,
screenshot again to verify.

```bash
browser-harness <<'PY'
capture_screenshot()
click_at_xy(640, 412)
capture_screenshot()
PY
```

Coordinate clicks go through iframes, shadow DOM and cross-origin without any extra work,
because hit-testing happens in the browser process. Suppress the instinct to hunt for a
selector first.

**Drop to the DOM only when coordinates are the wrong tool** — extracting many rows, reading
hidden fields, pulling structured data. Then `js(...)`.

**Bulk static pages:** `http_get(url)` with a thread pool. No browser needed.

**Stale tab:** `ensure_real_tab()`.

---

## Comment mining, concretely

```bash
browser-harness <<'PY'
new_tab("<creator post url>")
wait_for_load()
# scroll the comment thread, then pull commenter handles + their comment text
print(js("""
[...document.querySelectorAll('article ul li')].slice(0,60).map(n=>n.innerText).join('\\n---\\n')
"""))
PY
```

Then open the promising profiles and pull the fit signals: business size, whether they are
founder-led, what they are visibly complaining about.

**Keep the comment.** It is the opening line of the message, and it is the whole reason the
reply rate is what it is.

---

## 🔴 Rules

- **Never type credentials from a screenshot.** If a page redirects to a login, stop and tell him.
- **Never send, post, comment, connect, or message** without his explicit go. Reading and gathering are free. Acting is his call, every time.
- **This is his real browser and his real accounts.** A wrong click here has consequences a scraper never would. Screenshot before and after anything that changes state.
- **Rate-limit yourself on social platforms.** Aggressive automated browsing on Instagram or LinkedIn from a real logged-in account risks that account. Slow, human-paced, small batches.

---

## When it will not connect

The browser needs remote debugging enabled once. If the harness cannot attach, the message
tells you what to tick. Full detail in `docs/BROWSER.md`.

**If it still will not connect, fall back to Playwright MCP** — it drives its own browser
and can do everything except the logged-in parts.
