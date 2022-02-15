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

struct OrderDetail: View {
    var order : OrderLine
    var date : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX" //2022-02-15T18:41:22.106Z
        let date = formatter.date(from: order.created_at) ?? Date()
        formatter.dateFormat = "hh:mm a | dd MMM, yy"
        return formatter.string(from: date)
    }
    var body: some View {
        HStack {
            Text(order.customer_name)
            Spacer()
            VStack(alignment: .trailing){
                Text("#\(String(order.id))")

                Text(self.date)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
}

struct OrderDetail_Previews: PreviewProvider {
    static var previews: some View {
        var order = OrderLine(id: 12345, customer_id: 12334543, created_at: "2022-02-15T18:41:22.106Z", customer_name: "Bryce Buchanan")
        OrderDetail(order: order)
    }
}
