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

struct CustomerRow: View {
    var customer : Customer
    var body: some View {
        VStack {
            HStack {
                Text(customer.full_name)
                Spacer()
                Text(customer.company_name)
            }
            HStack{
                Text(customer.email)
                Spacer()
                Text("\(customer.city), \(customer.country)")
            }.foregroundColor(.gray)
                .font(.caption)
        }
    }
}



struct CustomerRow_Previews: PreviewProvider {
    static var previews: some View {
        let customer = Customer(id: 1234, full_name: "Bryce Buchanan", company_name: "Elastic", email: "bryce@elastic.co", address: "110 N Stafford Street", postal_code: "97122", city: "Portland", country: "USA")
        CustomerRow(customer: customer).environmentObject(ModelData())
    }
}
