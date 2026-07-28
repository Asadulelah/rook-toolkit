# Your browser — setup and troubleshooting

Built by Asadulelah.

## Connect it (once)

1. Open **Brave** or **Chrome**
2. Go to `chrome://inspect/#remote-debugging`
3. Tick **Allow remote debugging for this browser instance**
4. Click **Allow** on the popup (it sometimes appears behind the window)

Test:

```bash
browser-harness <<< 'print(page_info())'
```

## Common problems

| Symptom | Fix |
|---|---|
| `CDP WS handshake failed` | The tick did not stick. Redo the steps above, watch for the popup. |
| `daemon didn't come up` | `browser-harness --stop`, wait 2s, retry. |
| Commands time out | The tab is backgrounded. Bring the window to the front. |
| Wrong tab | `ensure_real_tab()` |
| Nothing works, deadline looming | Fall back to Playwright MCP. It drives its own browser — everything works except the logged-in parts. |

## How it works

It attaches to your already-running browser over the DevTools protocol. It does **not**
launch its own, which is exactly why your logins work.

Clicks are dispatched at the compositor level, so they pass through iframes, shadow DOM and
cross-origin frames without special handling. Screenshot, read the pixel, click the
coordinate, screenshot again.

## Safety

- Never types credentials from a screenshot. Hits a login wall, it stops and tells you.
- Never sends, posts, comments, connects or messages without your explicit go.
- Goes slowly on Instagram and LinkedIn. Aggressive automation from a real logged-in account risks that account.
