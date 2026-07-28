---
name: transcript
description: Pulls the full transcript from any Fathom share link with no login, then debriefs and files it. Use whenever a fathom.video/share link appears, or when asked to pull, transcribe, or write up a call. Trigger phrases — any "fathom.video/share/" URL, "pull this call", "get the transcript", "here's the recording", "write up this meeting", "/transcript".
author: Asadulelah
system: Rook Toolkit
---

# /transcript — the call, pulled and filed

> **The highest-leverage tool in the kit**, because most operators record
> everything and almost none of it ever gets written down. A call that isn't written down
> stops existing about four days later.

**No login needed.** Fathom's own "Copy Transcript" button hits an internal endpoint that a
public share link already authorises. The script reads the share page, lifts that endpoint,
calls it, and cleans the result.

---

## Run it

```bash
python3 tools/fathom/grab.py "<fathom share url>" /tmp/call.txt
```

Output is clean: a `# Title` line, then `@timestamp - Speaker - text` throughout.

**If it errors:** the link is probably private rather than shared, or Fathom changed their
markup. Ask for the public share link, or for the transcript pasted directly. Do not guess
at the content.

---

## Then do the actual job

🔴 **Pulling the transcript is the cheap half. Do not stop there.**

Hand off straight into `/debrief` in the main brain, which means:

1. **Debrief him first, in chat** — what happened, the dynamics, who said what, the real read, and the decision now on the table. Lead with the conversation.
2. **File it** — `journal/YYYY-MM-DD <Title>.md`, distilled, never a raw dump.
3. **Update the people and the client page** — synthesis rewritten at the top, timeline appended at the bottom.
4. **Pull every commitment** with an owner and a date, both directions.
5. **Set the deal status honestly** per the deal ladder. A warm call is not a close.
6. **Save the raw** to `raw/YYYY-MM-DD <Title> - Fathom Transcript.txt` so the source survives.

---

## 🔴 Transcripts lie

Fathom is auto-transcribed and it is wrong often enough to matter:

- The first line is frequently mangled
- Speaker attribution flips
- Names and numbers get invented outright

**Extract the gist and the decisions. Never file a transcript line as a verbatim quote**
unless it is unambiguous and load-bearing. A garbled word does not become a person, a
company, or a price. When a critical section is unclear, ask rather than fill it in.

This matters more here than anywhere: a hallucinated client quote, filed confidently, gets
repeated back to that client eventually.
