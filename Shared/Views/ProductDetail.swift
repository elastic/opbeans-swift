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

import Foundation
import SwiftUI


struct CircleImage: View {
    var image_url: URL?
    
    var body: some View {
        AsyncImage(url: image_url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.white, lineWidth: 4)
        }
        .aspectRatio(contentMode: .fit)
        .shadow(radius: 7)
        
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, sku: "OP-DRC-C1", name: "Brazil Verde, Italian Roast", stock: 80, type_name: "Dark Roast Coffee")
        
        CircleImage(image_url: product.image_url)
    }
}

struct ProductDetail : View {
    var product : Product
    @EnvironmentObject var modelData : ModelData
    func toggleCart() {
        if var item = modelData.cart.first(where: { item in
            item.product == product
        }) {
            modelData.cart.removeAll { item in
                item.product == product
            }
        } else {
            modelData.cart.append(CartItem(product: product, count: 1))
        }
    }

    
    var body : some View {
        ScrollView {
            RadialGradient(colors: [Color.green.opacity(0.2), Color.blue.opacity(0.5)],
                           center: .bottomTrailing,
                           startRadius: 0,
                           endRadius: 370)
                .ignoresSafeArea(edges: .top)
                .frame(height: 250)

            CircleImage(image_url: product.image_url)
                .frame(height:250)
                .offset(y: -150)
                .padding(.bottom, -150)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading){
                        Text(product.name)
                            .font(.title)
                        Text(product.type_name)
                            .font(.subheadline)
                    }
//                    Spacer()
//                    Button(action: addCart) {
//                        Label("", systemImage: "cart.badge.plus")
//                            .scaleEffect(1.5, anchor: .center)
//                    }
                    
                }
    
                Divider()

                Text("   This coffee has a well-earned reputation for quality resulting from their delivery of clean, consistent, and high scoring coffees year after year. For this limited processed offering, the coffee cherries first have the skin and pulp removed on the same day they are picked. With the sticky mucilage layer still intact, they are then slowly solar dried for about 30 days.\n\n      This processing style contributes to a delicate, complex, and tropical fruit-forward cup - look for juicy notes of mango, lychee, and rum.")
            }
            .padding()
        }
        .ignoresSafeArea(edges:.top)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:toggleCart) {
                    Label("",systemImage: (modelData.cart.contains(where: { item in
                        item.product == product
                    })) ? "cart.badge.minus.fill" : "cart.badge.plus")
                }
            }
        }.reportName("Product Detail - view appearing")
    }
}


struct ProductDetail_Preview: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, sku: "OP-DRC-C1", name: "Brazil Verde, Italian Roast", stock: 80, type_name: "Dark Roast Coffee")
        return ProductDetail(product: product).environmentObject(ModelData())
    }
}
