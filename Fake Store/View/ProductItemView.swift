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
    
    let screenWidth = UIScreen.main.bounds.width
        
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
                            
                            ZStack{
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                
                                HStack(spacing: 0) {
                                    Text("Delivery is ")
                                        .font(.headline)
                                    Text("50%")
                                        .padding(.horizontal, 4)
                                        .background(Color.white)
                                        .cornerRadius(7)
                                        .foregroundStyle(Color.black)
                                    Text(" Cheaper")
                                        .font(.headline)
                                    
                                    Spacer()
                        
                                    Image(systemName: "motorcycle.fill")
                                        .renderingMode(.original)
                                        
                                }
                                .padding(6)
                                
                            }
                            .frame(width: screenWidth*0.85)
                            .cornerRadius(12)
                            .padding(.top, 20)
                            
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
                .navigationTitle("Apt 5B, Springfield, CA")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image("discountIcon")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(.circle)
                            
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: CartView(cartVM: cartVM)) {
                            HStack {
                                Image(systemName: "cart")
                                Text("\(cartVM.cartItems.count)")
                            }
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
            VStack (spacing: 10){
                ZStack(alignment: .topTrailing){
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .padding()
                    
                    Button {
                        cartVM.toggleCart(item: product)
                    } label: {
                        Image(systemName: cartVM.isInCart(item: product) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                
                Text(product.title)
                    .frame(width: 140)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .foregroundColor(.green)
                
            }
            .padding()
            .frame(width: 160)
            .background(Color(.systemGray6))
            .cornerRadius(12)

        }
}

#Preview {
    ProductItemView()
}
