// Copyright © 2022 Elasticsearch BV
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

import SwiftUI
import ElasticApm
import OpenTelemetryApi
import OpenTelemetrySdk

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let decoder = JSONDecoder()
        do {
            let configJson = try Data(contentsOf:URL(fileURLWithPath: Bundle.main.path(forResource: "agent-conf", ofType: "json")!))
            let agentConfig = try decoder.decode(AgentConfig.self, from: configJson)
            let builder = AgentConfigBuilder()
            if let url = URL(string: agentConfig.url ) {
                _ = builder.withServerUrl(url)
            }
            if let token = agentConfig.token, !token.isEmpty {
                _ = builder.withSecretToken(token)
            }
            
            let config = builder
              .build()
          ElasticApmAgent.start(with: config)
          
          
        } catch {
            print(error)
        }
        return true
    }
}

@main
struct ios_integration_testingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var modelData = ModelData()
    init() {
    
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
