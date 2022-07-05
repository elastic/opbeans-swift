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
struct MyOrdersList: View {
    @EnvironmentObject var modelData : ModelData
    
    var body: some View {
        VStack {
            List(modelData.orders.filter({ order in
              return order.customer_id == modelData.user?.id ?? -1
            }), id: \.id) { order in
                NavigationLink {
                    OrderDetails(orderId: order.id).environmentObject(modelData)
                } label: {
                    MyOrderRow(order: order)
                }
                
            }
        }.onAppear  {
            modelData.loadOrders(true)
        }.navigationTitle("My Orders")
    }
        
}

struct MyOrdersList_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersList().environmentObject(ModelData())
    }
}
