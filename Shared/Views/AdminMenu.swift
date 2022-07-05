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

struct AdminMenu : View {
    @EnvironmentObject var modelData : ModelData
    
    var body : some View {
        VStack(alignment: .leading) {
            VStack {
                Divider()
                Text("User")
                    .font(.headline)
                Divider()
                NavigationLink {
                    MyOrdersList().environmentObject(modelData)
                } label: {
                    HStack {
                        Image(systemName: "cart")
                        //                    .foregroundColor(.gray)
                            .imageScale(.large)
                        Spacer()
                        
                        Text("My Orders")
                        //                    .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
            }
            .padding(.top, 100)
            .padding(.bottom,15)
            
            Divider()
            VStack {
                Text("Admin")
                    .font(.headline)
                Divider()
                NavigationLink {
                    AllCustomersList()
                        .environmentObject(modelData)
                    
                } label: {
                    HStack {
                        Image(systemName: "person.3")
                        //                    .foregroundColor(.gray)
                            .imageScale(.large)
                        Spacer()
                        Text("Customers")
                        //                    .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 15)
                    .padding(.bottom,15)
                }
                Divider()
                
                NavigationLink {
                    AllOrdersList()
                        .environmentObject(modelData)
                } label: {
                    HStack {
                        Image(systemName: "cart")
                        //                    .foregroundColor(.gray)
                            .imageScale(.large)
                        Spacer()
                        
                        Text("All Orders")
                        //                    .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    
                }
                Divider()
                
                NavigationLink {
                    AllProductsList()
                        .environmentObject(modelData)
                    
                } label: {
                    HStack {
                        Image(systemName: "cup.and.saucer")
                        //                    .foregroundColor(.gray)
                            .imageScale(.large)
                        Spacer()
                        
                        Text("Products")
                        //                    .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                }
            }
            Divider()
            Spacer()
            Divider()
            UserView()
                .environmentObject(modelData)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AdminMenu_Preview: PreviewProvider {
    static var previews : some View {
        AdminMenu().environmentObject(ModelData())
    }
}
