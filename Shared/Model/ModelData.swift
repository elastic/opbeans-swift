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

enum ModelDataError : Error {
    case invalidURL
}


var opbeansAddr = ProcessInfo.processInfo.environment["ELASTIC_OPBEANS_ADDRESS"]
var opbeansAuth = ProcessInfo.processInfo.environment["ELASTIC_OPBEANS_AUTH"]

var api : API = load("apiData.json")

class ModelData : ObservableObject {

    
    @Published var cart = [CartItem]()
    @Published var products = [Product]()
    @Published var customers = [Customer]()
    @Published var orders = [OrderLine]()
    @Published var user : Customer?

    
    func loadProducts() {
        guard products.isEmpty else { return }
        Task {
            do {
                let products = await fetchProducts()
                DispatchQueue.main.async {
                    self.products = products
                }
            }
        }
    }
    
    func loadOrders(_ force : Bool = false) {
        guard orders.isEmpty || force else {return}
        Task {
            do {
                //there's not a way to get orders based on userid so we have to get alllll the orders using a large limit (default limit is only 1000 orders)
                let orders = try await JSONDecoder().decode([OrderLine].self, from: getAPIData(path: "api/orders?limit=10000"))
                DispatchQueue.main.async {
                    self.orders = orders
                }
            } catch {
                DispatchQueue.main.async {

                self.orders = [OrderLine]()
                }
            }
        }
    }
    
    func loadCustomer() {
        guard customers.isEmpty else {return}
        Task {
            do {
                let customers = try await JSONDecoder().decode([Customer].self, from: getAPIData(path: "api/customers"))
                DispatchQueue.main.async {
                    self.customers = customers
                    self.user = self.customers[(Int(arc4random()) % self.customers.count)]
                }
            } catch {
                DispatchQueue.main.async {
                self.customers = [Customer]()
                }
            }
        }
    }
    func fetchFullOrder(forOrder order: Int) async -> FullOrder? {
        do {
            return try await JSONDecoder().decode(FullOrder.self,from: getAPIData(path: "api/orders/\(order)"))
        } catch {
            return nil
        }
    }
    private func fetchProducts() async -> [Product] {
        do {
            do {
               let _ = try await httpError404()
            } catch {
                // noop
            }
            do {
                let _ = try await httpError500()
            } catch {
                // noop
            }
            return try await JSONDecoder().decode([Product].self, from: getAPIData(path: "api/products"))
        } catch {
            return [Product]()
        }
    }
}
func load<T: Decodable>(_ filename: String) -> T {
    let data : Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \n \(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
        
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func buildCheckoutURL() throws -> URL {
    return try buildUrl(path: "api/orders")
}

func buildImageUrl(sku: String) -> URL? {
    
    return URL(string:"\(api.url)/images/products/\(sku).jpg")
}

func buildUrl(path: String) throws -> URL {
    
    guard let url = URL(string: "\(api.url)/\(path)") else {
        throw ModelDataError.invalidURL
    }
    return url
}

func httpError500() async throws  -> Data {
    guard let url = URL(string: "https://httpstat.us/500") else {
        throw ModelDataError.invalidURL
    }
    
    let request = URLRequest(url: url)
    return try await withCheckedThrowingContinuation { continuation in
        URLSession.shared.dataTask(with: request) {data, _, error in
            if let e = error {
                continuation.resume(throwing: e)
            } else {
                continuation.resume(returning: data!)
            }
        }.resume()
    }
}

func httpError404() async throws -> Data {
    guard let url = URL(string: "https://httpstat.us/404") else {
        throw ModelDataError.invalidURL
    }
    let request = URLRequest(url: url)
    return try await withCheckedThrowingContinuation { continuation in
        URLSession.shared.dataTask(with: request) {data, _, error in
            if let e = error {
                continuation.resume(throwing: e)
            } else {
                continuation.resume(returning: data!)
            }
        }.resume()
    }
}
func getAPIData(path: String) async throws -> Data {
    var request = try URLRequest( url:buildUrl(path: path))
    
    if let auth = api.auth {
            request.addValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
    }
    
    return try await withCheckedThrowingContinuation { continuation in
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let e = error {
                continuation.resume(throwing: e)
            } else {
                continuation.resume(returning: data!)
            }
        }.resume()
    }
}

func sendCheckout(userId: Int, items: [CartItem]) async throws -> URLResponse {
    var request = try URLRequest(url: buildCheckoutURL())
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    var lines = [ProductLine]()
    for item in items {
        lines.append(ProductLine(id: item.product.id, amount:item.count))
    }
    let json = try JSONEncoder().encode(Order(customer_id: userId, lines: lines))
    request.httpBody = json
    print(String(decoding:json, as: UTF8.self))
    if let auth = api.auth {
        request.addValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
    }
        
   return try await withCheckedThrowingContinuation { continuation in
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let e = error {
                continuation.resume(throwing:e)
            } else {
                continuation.resume(returning: response!)
            }
        }.resume()
    }
}


