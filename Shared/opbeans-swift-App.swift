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
    init() {
        var config = AgentConfiguration()
        config.collectorHost = "localhost"
        config.collectorPort = 8200
        config.collectorTLS = false
//        config.secretToken = ""
    
        let envvars = ProcessInfo.processInfo.environment
            
        if let address = envvars["OTEL_COLLECTOR_ADDRESS"], !address.isEmpty  {
            config.collectorHost = address
        }
        
        if let port = envvars["OTEL_COLLECTOR_PORT"], !port.isEmpty {
            if let parsedPort = Int(port) {
                config.collectorPort = parsedPort
            }
        }
    
        if let tls = envvars["OTEL_COLLECTOR_TLS"], !tls.isEmpty {
            if let parsedTls = Bool(tls) {
                config.collectorTLS = parsedTls
            }
        }

        if let token = envvars["ELASTIC_SECRET_TOKEN"], !token.isEmpty {
            config.secretToken = token
        }

        Agent.start(with: config)
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
