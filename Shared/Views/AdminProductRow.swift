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

struct AdminProductRow: View {
    var product : Product
    var body : some View {
        HStack {
            AsyncImage(url:product.image_url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 5) {
                Text(product.name)
                    .bold()
                Text(product.type_name)
                    .italic()
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            Text(String(product.stock))
            
        }
    }
}


