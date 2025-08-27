//
//  ProductItemView.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import SwiftUI

struct ProductItemView: View {
    @StateObject var viewModel = ProductListViewModel()
    @StateObject var cartVM = CartViewModel()
        
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        var body: some View {
            NavigationView {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.products) { product in
                                    NavigationLink {
                                        ProductDetailView(product: product, cartVM: cartVM)
                                    } label: {
                                        ProductCardView(product: product, cartVM: cartVM)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Store")
                .toolbar {
                    NavigationLink(destination: CartView(cartVM: cartVM)) {
                        HStack {
                            Image(systemName: "cart")
                            Text("\(cartVM.cartItems.count)")
                        }
                    }
                }
            }
            .task {
                await viewModel.loadProducts()
            }
        }
    }

struct ProductCardView: View {
        let product: Product
        @ObservedObject var cartVM: CartViewModel
        
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: product.image!)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 100)
                
                Text(product.title!)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(product.price!, specifier: "%.2f")")
                    .foregroundColor(.green)
                
                Button {
                    cartVM.toggleCart(item: product)
                } label: {
                    Image(systemName: cartVM.isInCart(item: product) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
}

#Preview {
    ProductItemView()
}
