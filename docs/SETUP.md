# Setup — A to Z

Two things need you personally. Everything else the installer did already.
Total time, about five minutes.

---

## 1. Connect your browser (2 minutes)

This is the one that unlocks the most. It lets Rook use **your** browser, already logged
into everything, instead of a blank one that can see nothing.

**Do this once:**

1. Open **Brave** or **Chrome** (whichever you actually use).
2. Go to `chrome://inspect/#remote-debugging`
3. Tick **Allow remote debugging for this browser instance**
4. A popup appears. Click **Allow**.

**Test it:**

```bash
browser-harness <<< 'print(page_info())'
```

If it prints the page you have open, you're done.

**If it says it can't connect:** the tick did not stick, or the popup was missed. Redo
step 2 and watch for the popup. It sometimes appears behind the window.

### What this now lets Rook do

- Look at a prospect's actual site and socials before a call, instead of guessing
- Open the comment sections you mine for leads and pull who is engaging, with their comment
- Read anything behind a login you already have
- Screenshot a page so you can both look at the same thing

### What it will never do

It **reads and gathers**. It does not send, post, comment, connect, or message without you
saying go, every time. It is your real account, and it treats it that way.

---

## 2. Free Apify account (3 minutes)

Apify is scraping plus, more importantly, **email verification**.

1. Sign up free at **apify.com**
2. In your terminal:

```bash
apify login
```

3. Paste the token it asks for. You'll find it under Settings → Integrations → API token.

**Free tier is about $5 of credit a month.** That is plenty, because the ICP filter runs
*before* anything paid, so credit only gets spent on businesses that are actually a fit.

### The one that matters

```
/leads property management Dallas
```

Scrapes the source, cuts it to the real ICP, finds the founder's email rather than `info@`,
**verifies every address**, and hands back a send-ready sheet with the personalisation
variable already filled.

🔴 **Rook will not hand you a send-ready list until every address is verified.** That is
deliberate. A batch of 40 went out unverified once and produced 3 hard bounces at 7.5%, on
warmed inboxes that take weeks to rebuild. Anything above 2% starts damaging your sender
reputation. That will not happen again.

---

## 3. Fathom transcripts (already done)

Nothing to set up. Drop a `fathom.video/share/...` link and it works.

```
/transcript https://fathom.video/share/xxxxx
```

You get the call debriefed back to you in chat, then filed, with every commitment pulled out
with an owner and a date, both directions.

**Use it on every call.** It is twelve minutes of your time saved and it is the single
biggest difference between a deal that closes and one that goes quiet.

---

## What changed in your existing commands

| Command | Before | Now |
|---|---|---|
| `/prep` | Worked from what was already filed | Can go and look at their site and socials first |
| `/debrief` | You pasted the transcript | Paste the link |
| `/outreach` | Told you to verify | Verifies, itself, and refuses to skip it |
| `/research` | Reasoned from what it knew | Actually goes and reads |

---

## If something breaks

Just say so. "Browser isn't connecting" is a fine prompt — Rook can read its own setup and
tell you what's wrong.

Anything genuinely broken goes to Asad with a written-up description of the failure, rather
than you having to explain it.

---

## Cost, plainly

**Everything here is free.** Apify's free tier covers this volume comfortably. Rook will tell
you what a job costs before it spends anything, and will stop and ask rather than assume.

Nothing here uses anyone else's account. Your browser, your Apify, your machine.

---

*Rook Toolkit — built by **Asad**, 2026-07-28.*
