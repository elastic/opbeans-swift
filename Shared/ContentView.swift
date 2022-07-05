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
import OpenTelemetrySdk
import OpenTelemetryApi
import iOSAgent

struct ContentView: View {
    @EnvironmentObject var modelData : ModelData
    @State var showMenu = false
    var body : some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView()
                        .environmentObject(modelData)
                        .disabled(self.showMenu ? true : false)
                        .toolbar {
                            ToolbarItemGroup(placement:.navigationBarLeading) {
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Label("",systemImage: "line.3.horizontal")
                                }
                            }
                        }
                }
                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                
                if self.showMenu {
                    AdminMenu()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                        .environmentObject(modelData)
                }
            }        .navigationBarTitleDisplayMode(self.showMenu ? .inline : .automatic )

        }
        .gesture(drag)

    }
}


struct MainView : View {
    @State var showMenu = false
    
    @EnvironmentObject var modelData : ModelData
    
    func fetch() {
        modelData.loadProducts()
        modelData.loadCustomer()
    }
    
    var body: some View {
        VStack {
            List(modelData.products, id: \.id ) { product in
                NavigationLink {
                    ProductDetail(product: product)
                        .environmentObject(modelData)
                } label: {
                    ProductRow(product: product)
                }
            }
        }
        .navigationTitle("Opbeans Coffee")
        .font(.title2)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    CartDetails()
                        .environmentObject(modelData)
                } label: {
                    Label("",systemImage: modelData.cart.isEmpty ? "cart" : "cart.fill")
                }
                
            }
            
            
            
        }.onAppear(perform: fetch)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
