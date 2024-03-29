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
import ElasticApm

struct CartDetails: View {
    @EnvironmentObject var modelData : ModelData
    @State var loading = false
    @State var showingNotice = false
    @State var resultText = "Success"
    func checkout() {
        loading = true
        Task {
            do {
                let r = try await sendCheckout(userId: modelData.user?.id ?? 1, items: modelData.cart) as! HTTPURLResponse
                loading = false
                if r.statusCode == 200 {
                    modelData.cart.removeAll()
                    resultText = "Success"
                } else {
                    resultText = "Failed"
                }
                showingNotice = true
            }
            catch {
                print("failed to checkout.")
                loading = false
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.center) {
                if modelData.cart.isEmpty {
                    List {
                        EmptyCartRow()
                    }.navigationTitle("Cart")
                } else {
                    List(modelData.cart, id: \.product.id ) { cart in
                        CartRow(product: cart.product, count: cart.count)
                    } .disabled(loading)
                        .navigationTitle("Cart")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Checkout",action: checkout)
                                    .buttonStyle(.borderless)
                            }
                        }.disabled(loading)
                }
                VStack {
                    FloatingNotice(showingNotice: $showingNotice, text: self.resultText).animation(.easeInOut, value: showingNotice)
                        .opacity(self.showingNotice ? 1 : 0)
                }
                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.loading ? 1 : 0)
                Spacer()
                
            }
        }
    }
}

struct CartDetails_Previews: PreviewProvider {
    static var previews: some View {
        CartDetails().environmentObject(ModelData())
    }
}


struct FloatingNotice: View {
    @Binding var showingNotice: Bool
    var text : String
    var body: some View {
        VStack (alignment: .center, spacing: 8) {
            Image(systemName: text == "Error" ? "xmark" :"checkmark")
                .foregroundColor(.white)
                .font(.system(size: 48, weight: .regular))
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
            Text(text)
                .foregroundColor(.white)
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.gray.opacity(0.75))
        .cornerRadius(5)
        .transition(.scale)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    self.showingNotice = false
                }
            })
        })
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    Text("checking out...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}
