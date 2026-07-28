---
name: leads
description: Builds a verified lead list — scrape a source, filter to the ICP, find the founder's email, verify every address, and hand back a send-ready sheet. Use for any lead-gen or list-building job. Trigger phrases — "get me leads", "build a list", "scrape", "find businesses in", "who should we contact", "verify these emails", "/leads".
author: Asadulelah
system: Rook Toolkit
---

# /leads — scrape, filter, verify

> 🔴 **The rule this skill exists to enforce: no list leaves here unverified.**
>
> A batch of 40 went out with no verification in the pipeline and produced **3 hard
> bounces, 7.5%** — on warmed inboxes that take weeks to rebuild. Anything above ~2%
> starts damaging sender reputation. The pipeline simply had no verification step and
> nobody noticed until the bounces landed.
>
> **This skill will not output a send-ready list until every address has been verified.**

Load `_system/sales/outreach-method.md` and `strategy/Target Niches.md` from the brain.

---

## The chain

```
1. SOURCE    scrape, or use a list you already have
2. FILTER    cut to the real ICP before spending anything on enrichment
3. FIND      the founder's email, not info@
4. VERIFY    every address. non-negotiable.
5. SHEET     send-ready, with the personalisation variable already filled
```

**Filter before you enrich.** Enrichment and verification cost credits; the ICP filter is
free. Running 500 unfiltered rows through enrichment burns the month's credit on businesses
that were never going to buy.

---

## 1. Source

| What you want | Actor |
|---|---|
| Local businesses by area + category | `compass/crawler-google-places` |
| Instagram profiles / followers / commenters | `apify/instagram-scraper` |
| Instagram profile detail | `apify/instagram-profile-scraper` |
| Facebook pages | `apify/facebook-pages-scraper` |
| Google search results | `apify/google-search-scraper` |

```bash
apify call compass/crawler-google-places --input '{
  "searchStringsArray": ["property management Dallas"],
  "maxCrawledPlacesPerSearch": 100,
  "language": "en"
}' --output-dataset > /tmp/raw.json
```

**For the comment-mining method, use `/browse` instead.** That method depends on reading
who engages with substance, which is a judgment call, not a scrape.

---

## 2. Filter to the ICP

From `strategy/Target Niches.md` and the outreach method:

- Roughly **$700K-$1M+**, founder-led, founder-reachable
- Visible operational pain — a tool they complain about, manual work, growth they cannot staff
- Can afford **$6-30k** as a decision, not an impossibility
- **Best client, not most clients.** One client is a large build and there is one developer.

Cut hard here. A 500-row list filtered to 60 real fits is a better input than 500 rows.

---

## 3. Find the email

Pattern-derive from the domain (`first@`, `first.last@`, `firstlast@`), then **verify** —
derived patterns are exactly what bounced last time. Never send to a derived address that
has not been checked.

Prefer the founder over `info@` / `contact@`. A generic inbox is a gatekeeper, and the
method depends on reaching the person directly.

---

## 4. 🔴 Verify — the gate

```bash
apify call account56/email-verifier --input '{
  "emails": ["a@x.com","b@y.com"]
}' --output-dataset > /tmp/verified.json
```

Keep only `valid`. **Drop `risky` and `unknown` as well as `invalid`** — a risky address is
how you get a bounce, and the bounce is what costs the domain.

```
[ ] every address verified
[ ] risky + unknown dropped, not "sent anyway"
[ ] bounce projection under 2%
[ ] sending from a fresh outreach domain, not the main one
[ ] domain warmed
[ ] SPF / DKIM / DMARC configured
```

**If any box is unchecked, say so and stop.** A blocked batch costs a day. A burned domain
costs a month.

---

## 5. The sheet

```
LIST — <niche>                                    <date>
Sourced <N> → ICP filter <N> → found <N> → VERIFIED <N>
Projected bounce: <N>%

| Company | Person | Role | Email | Signal | Variable |
```

**Signal** = the specific thing that makes them a fit.
**Variable** = the personalisation token the message inserts. This is the field the whole
reply rate hangs on, so it has to be real and specific, not "your industry".

Hand off to `/outreach` to build the batch.

---

## Money

🔴 **Free tier only unless told otherwise.** Apify gives ~$5/month of credit, which is
plenty at this volume because the ICP filter runs before anything paid.

**Before any run that will consume meaningful credit, say what it will cost and wait for a go.**
Never burn credits on a speculative scrape. If a job needs more than the free tier, that is
the operator's decision, not an assumption.

**Use your own Apify account.** Never anyone else's token.
