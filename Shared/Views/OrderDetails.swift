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

struct OrderDetails : View {
    let orderId : Int
    @EnvironmentObject var modelData : ModelData
    @State var fullOrder : FullOrder?
    
    var body : some View {
        VStack {
            if let order = fullOrder {
                List(order.lines, id: \.id) { lineItem in
                    LineItemRow(lineItem: lineItem)
                }.navigationTitle("Order #\(String(orderId))")
                    
                HStack {
                    Text("Total:")
                        .bold()
                        .font(.title3)
                        .padding(.leading, 10)
                    Spacer()
                    Text("§\(String(order.lines.map{$0.selling_price}.reduce(0, +)))")
                        .italic()
                        .font(.title3)
                        .padding(.trailing, 10)
                }.padding(.bottom, 10)
            } else {
                HStack{
                    Text("Order #\(String(orderId)) not found.")
                }.navigationTitle("Order #\(String(orderId))")
            }
        }
        .onAppear {
            Task {
                do {
                    let order = await modelData.fetchFullOrder(forOrder: orderId)
                    DispatchQueue.main.async {
                        self.fullOrder = order
                    }
                }
            }
        }
    }
}
