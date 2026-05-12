# Prerequisites

- **Xcode** — Install from the Mac App Store or [Apple Developer](https://developer.apple.com/xcode/). Add your GitHub account under **Xcode → Settings → Accounts** if you need private deps.
- **[opbeans-node](https://github.com/elastic/opbeans-node)** — Backend API (default port `3000`). Install Node.js and follow that repo for PostgreSQL, Redis, env vars, `npm run db-setup`, and `npm start`.
- **opbeans-swift** — `git clone https://github.com/elastic/opbeans-swift`

# Setup

## opbeans-node

Clone and run the backend per the [opbeans-node README](https://github.com/elastic/opbeans-node/blob/main/README.md). Ensure the HTTP API is reachable at the host and port you will put in `apiData.json` (default `http://localhost:3000`).

## opbeans-swift

Open `opbeans-swift.xcodeproj` in Xcode.

By default the app reads **`Shared/Resources/apiData.json`** for the opbeans API (`localhost:3000`) and **`Shared/Resources/agent-conf.json`** for the APM Server URL. Adjust those files (and `opbeans-swift-App.swift` only if you change how config is loaded) to match your environment.

Run **opbeans-swift** on a chosen **iOS Simulator** or **iOS Device**.

# Troubleshooting

### Coffee data does not load in the app

Verify `http://localhost:3000` (or your configured URL) works in a browser and matches `Shared/Resources/apiData.json`.

### Traces do not appear in Kibana / APM UI

Verify your APM Server URL in `Shared/Resources/agent-conf.json` is correct and reachable from the Simulator’s network (for a physical device, use the Mac’s LAN IP or a public endpoint, not `localhost` on the device).
