#!/usr/bin/env python3
"""
Fathom share-link transcript grabber.  |  Rook Toolkit  |  built by Asadulelah
Usage: python3 grab.py <fathom-share-url> [output.txt]

Works for any public fathom.video/share/<token> link with NO login:
Fathom's own "Copy Transcript" button hits an internal endpoint
(/calls/<id>/copy_transcript?token=<token>) that a public share link authorizes.
We read the share page, lift that endpoint out of the page source, call it,
and clean the returned HTML into readable `@ts - Speaker - text`.
"""
import sys, re, json, html, urllib.request

UA = ("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/120 Safari/537.36")

def fetch(url, headers=None, timeout=45):
    req = urllib.request.Request(url, headers=headers or {"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read().decode("utf-8", "ignore")

def main():
    if len(sys.argv) < 2:
        print("usage: grab.py <fathom-share-url> [out.txt]"); sys.exit(2)
    share = sys.argv[1].strip()
    out = sys.argv[2] if len(sys.argv) > 2 else None

    page = fetch(share)
    # Fathom HTML-encodes the endpoint; unescape first, then find copy_transcript URL.
    page_u = html.unescape(page)
    m = re.search(r'https://fathom\.video/calls/(\d+)/copy_transcript\?token=([A-Za-z0-9_-]+)', page_u)
    if not m:
        # fall back: build it from the share token + any call id on the page
        tok = re.search(r'/share/([A-Za-z0-9_-]+)', share)
        cid = re.search(r'/calls/(\d+)', page_u)
        if not (tok and cid):
            print("ERROR: could not locate transcript endpoint in page", file=sys.stderr); sys.exit(1)
        endpoint = f"https://fathom.video/calls/{cid.group(1)}/copy_transcript?token={tok.group(1)}"
    else:
        endpoint = m.group(0)

    raw = fetch(endpoint, headers={
        "User-Agent": UA,
        "Accept": "application/json, text/plain, */*",
        "X-Requested-With": "XMLHttpRequest",
        "Referer": share,
    })
    try:
        h = json.loads(raw).get("html", raw)
    except json.JSONDecodeError:
        h = raw

    h = html.unescape(h)
    h = re.sub(r'<br\s*/?>', '\n', h)
    h = re.sub(r'</p>', '\n', h)
    h = re.sub(r'<h1>(.*?)</h1>', r'# \1\n', h, flags=re.S)
    h = re.sub(r'<a [^>]*>(.*?)</a>', r'\1', h, flags=re.S)   # keep @timestamp text
    h = re.sub(r'<[^>]+>', '', h)                             # strip remaining tags
    h = re.sub(r'\n{3,}', '\n\n', h).strip()

    if out:
        open(out, "w", encoding="utf-8").write(h)
        title = (re.search(r'#\s*(.+)', h) or [None, "transcript"])[1]
        print(f"OK | {h.count(chr(10))} lines | {len(h)} chars | title: {title}\nsaved: {out}")
    else:
        print(h)

if __name__ == "__main__":
    main()
