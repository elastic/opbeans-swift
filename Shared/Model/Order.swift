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

struct ProductLine : Hashable, Codable {
    let id : Int
    let amount : Int
}

struct Order : Hashable, Codable {
    let customer_id : Int
    let lines : [ProductLine]
}

struct OrderLine : Hashable, Codable {
    let id : Int
    let customer_id : Int
    let created_at : String
    let customer_name : String
}

struct LineItem: Hashable, Codable {
    let amount : Int
    let id : Int
    let sku : String
    let name : String
    let description : String
    let type_id : Int
    let stock : Int
    let cost : Int
    let selling_price : Int
    
    var image_url : URL? {
         buildImageUrl(sku: sku)
    }
}

struct FullOrder : Hashable, Codable {
    let id : Int
    let customer_id: Int
    let created_at : String
    let lines : [LineItem]
}
