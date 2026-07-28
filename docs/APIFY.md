# Apify — scraping and email verification

Built by Asadulelah.

## Setup

1. Free account at **apify.com**
2. `apify login`
3. Token is under Settings → Integrations → API token

**Free tier: ~$5 credit/month.** Enough, because the ICP filter runs before anything paid.

## The actors that matter

| Job | Actor |
|---|---|
| 🔴 **Verify emails** | `account56/email-verifier` |
| Local businesses | `compass/crawler-google-places` |
| Instagram profiles / commenters | `apify/instagram-scraper` |
| Instagram profile detail | `apify/instagram-profile-scraper` |
| Facebook pages | `apify/facebook-pages-scraper` |
| Google search | `apify/google-search-scraper` |

## The rule

🔴 **Every address gets verified before any batch goes out. No exceptions.**

Keep only `valid`. Drop `risky` and `unknown` as well as `invalid` — a risky address is how
you get a bounce, and the bounce is what costs you the domain.

Target bounce rate under 2%. The unverified batch that went out once hit 7.5%.

## Money

Rook says what a run will cost before spending, and stops rather than assuming. Filter the
list to the real ICP *first* — enrichment on rows that were never going to buy is how a
month's credit disappears.

Use your own account. Never anyone else's token.
