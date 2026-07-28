# Rook Toolkit ♜

**Built by Asadulelah.** The hands for Rook.

A markdown second brain can read, write, reason, and remember. On its own it cannot touch the live web, pull a call recording, or
build a lead list. **This is what gives it hands.**

Install this second, after the brain.

> Designed for a sales-and-growth operator: someone whose day is calls, lists, follow-ups
> and decks, not code. Everything here is free and runs locally.

---

## What you get

| Tool | What it means in practice |
|---|---|
| **Fathom transcripts** | Drop a recording link. The call gets pulled, debriefed back to you, filed, every commitment extracted with a date. No login, no copy-paste. |
| **Your browser, driven** | It uses *your* Chrome or Brave, already logged in. Research a prospect's site and socials, mine creator comment sections for leads, read anything behind a login, take screenshots. |
| **Apify** | Scrape Google Maps, Instagram, Facebook, Google. And verify every email before you send, which is the thing that would have stopped the 7.5% bounce. |
| **Playwright** | A backup browser for screenshots and checking a page renders, when the main one will not connect. |

---

## Three new commands

| | |
|---|---|
| `/transcript <fathom link>` | Pull the call, debrief it, file it |
| `/browse` | Drive your own logged-in browser |
| `/leads <niche>` | Scrape, filter to the ICP, find emails, verify, hand back a sheet |

And your existing commands get better: `/prep` can actually go look at the prospect,
`/debrief` takes a link instead of a paste, `/outreach` can verify its own list.

---

## Install

```bash
git clone https://github.com/Asadulelah/rook-toolkit.git
cd rook-toolkit
./install.sh
```

Then read [docs/SETUP.md](docs/SETUP.md) for the two things that need you: connecting your
browser, and making a free Apify account.

---

## What's deliberately not here

Not everything from the original setup is in this kit, on purpose. Left out: the
multi-session orchestrator, the codebase-memory server, the UI component servers, the video
tooling. Those are for building software, and building software is not your lane. They would
add setup, add failure modes, and do nothing for a call, a list, or a deck.

**Nothing here uses anyone else's credentials.** Your browser, your Apify account, your
machine. Nothing is shared and nothing phones home.

---

## Cost

**All free.** Apify's free tier is about $5 of credit a month, which is more than enough
because the list gets filtered before anything paid runs. Rook will tell you what a job
costs before spending anything, and will stop rather than assume.

---

*Rook Toolkit — designed and built by **Asadulelah**, 2026-07-28. See [LICENSE.md](LICENSE.md).*
