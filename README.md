# opbeans-swift

An opbeans-based app for the iOS Agent. This project is intended to be used with [opbeans-node](https://github.com/elastic/opbeans-node) (default port **3000**).

## Requirements

| Requirement | Notes |
|-------------|--------|
| **macOS** | Needed to build and run the iOS target. |
| **Xcode** | Install from the Mac App Store or [Apple Developer](https://developer.apple.com/xcode/). Use a version compatible with this project’s Swift toolchain. |
| **iOS Simulator** | At least one simulator runtime must be installed. In Xcode: **Settings → Platforms** (or **Xcode → Settings → Components** in older versions) and download an **iOS Simulator** for the OS version you want. Without a runtime, the app cannot run in Simulator. |
| **opbeans-node** | The app expects the HTTP API on port **3000** by default (see configuration below). See the [opbeans-node repository](https://github.com/elastic/opbeans-node) for Node.js, PostgreSQL, Redis, env vars, `npm run db-setup`, and `npm start`. |
| **APM Server** (optional) | For traces/metrics to be sent to Elastic APM, configure `Shared/Resources/agent-conf.json` with your APM Server URL (and optional auth). |

## Running with opbeans-node

### 1. Start the backend

Follow **[opbeans-node](https://github.com/elastic/opbeans-node)** to install dependencies, configure PostgreSQL and Redis, run `npm run db-setup`, then `npm start`. By default the API listens on **port 3000**.

### 2. Point the iOS app at the API

Default backend URL is **`http://localhost:3000`** in `Shared/Resources/apiData.json`. Change `url` (and `auth` if required) if your opbeans-node uses another host or port.

On the **iOS Simulator**, `localhost` refers to your Mac, so `http://localhost:3000` matches opbeans-node running on the same machine.

### 3. Configure the Elastic APM agent (optional)

`Shared/opbeans-swift-App.swift` loads **`Shared/Resources/agent-conf.json`** at startup (`url` for the APM Server, optional `token`). Point `url` at wherever your APM Server is reachable (for example a local or cloud deployment).

### 4. Build and run in Xcode

1. Open **`opbeans-swift.xcodeproj`** in Xcode.
2. Select the **`opbeans-swift (iOS)`** scheme.
3. Choose an **iOS Simulator** as the run destination (e.g. iPhone 16).
4. Run (**⌘R**).

Confirm the API responds (e.g. open `http://localhost:3000` in a browser) before debugging connection issues in the app.

## Related docs

- **[GETTING-STARTED.md](./GETTING-STARTED.md)** — Prerequisites and setup notes.
- **[scripts/README.md](./scripts/README.md)** — Command-line load generator and `xcodebuild` destinations.

### Data generation

[//]: # (use `./script/generate-data.py` to prep with a random selection of attributes from the files in `./scripts/data` applied to the Resources object.)

[//]: # ()
[//]: # (`generate-data.py` accepts parameters for app installation destination and collector / opbeans settings. List destinations with `xcodebuild -showdestinations`. More details: `python3 ./script/generate-data.py -h`.)
