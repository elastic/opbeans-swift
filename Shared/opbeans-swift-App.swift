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
import iOSAgent
@main
struct ios_integration_testingApp: App {
    @StateObject private var modelData = ModelData()
    var agentConfig : AgentConfig = load("agent-conf.json")
    init() {
        
        let builder = AgentConfigBuilder()
        if let url = URL(string: agentConfig.url ) {
            _ = builder.withURL(url)
        }
        if let token = agentConfig.token, !token.isEmpty {
            _ = builder.withSecretToken(token)
        }
        
        var config = builder.build()


        Agent.start(with: config)
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
