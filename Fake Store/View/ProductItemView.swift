//
//  ProductItemView.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

let categories: [Category] = [
    Category(name: "Phones", image: "iphone"),
    Category(name: "Consoles", image: "gamecontroller"),
    Category(name: "Laptops", image: "laptopcomputer"),
    Category(name: "Cameras", image: "camera"),
    Category(name: "Audio", image: "headphones"),
    Category(name: "Books", image: "book"),
    Category(name: "Fitness", image: "figure.indoor.cycle"),
    Category(name: "Medicines", image: "pill")
]

struct ProductItemView: View {
    @StateObject var viewModel = ProductListViewModel()
    @StateObject var cartVM = CartViewModel()
    
    let screenWidth = UIScreen.main.bounds.width
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error) Check your internet connection. Try again later.")
                        .font(.headline)
                        .frame(width: screenWidth * 0.9)
                        .foregroundColor(Color.red.opacity(0.9))
                } else {
                    ScrollView {
                        
                        // 🔎 Search bar
                        VStack(spacing: 5) {
                            HStack {
                                TextField("Search", text: $searchText)
                                    .padding()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            }
                            .frame(width: screenWidth * 0.85)
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(12)
                            .padding(.top, 10)
                            
                            
                            ZStack(alignment: .bottom) {
                                HStack(spacing: 4) {
                                    Text("Delivery is")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("50%")
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                    
                                    Text("Cheaper")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                .padding(10)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(
                                        colors: [Color.green.opacity(0.7), Color.cyan.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(12)
                                
                                Image(systemName: "flame.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .offset(x: screenWidth * 0.32)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.cyan, Color.green.opacity(0.6), Color.white],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .shadow(color: .cyan.opacity(0.4), radius: 6, x: 0, y: 2)
                            }
                            .frame(width: screenWidth * 0.85)
                        }
                        
                        
                        // Displaying Categories
                        VStack {
                            HStack {
                                Text("Categories")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Text("See all")
                                        .font(.caption)
                                    Image(systemName: "chevron.right.circle.fill")
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }
                            }
                            .padding(4)
                            .frame(width: screenWidth * 0.89)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(categories) { category in
                                        VStack(spacing: 8) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.gray.opacity(0.15))
                                                    .frame(width: 60, height: 60)
                                                
                                                Image(systemName: category.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.black)
                                            }
                                            Text(category.name)
                                                .font(.footnote)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
//                        .border(Color.black)
                        
                        // Products grid
                        VStack {
                            HStack {
                                Text("Flash Sale")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("02:59:12")
                                    .padding(4)
                                    .background(
                                        LinearGradient(colors: [Color.green.opacity(0.4), Color.green.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                                            .cornerRadius(8)
                                    )
                                    
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Text("See all")
                                        .font(.caption)
                                    Image(systemName: "chevron.right.circle.fill")
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }
                            }
                            .padding(4)
                            .frame(width: screenWidth * 0.89)
//                            .border(Color.black)
                            
                            
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
//                        .border(Color.black)
                        
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
                        .clipShape(Circle())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CartView(cartVM: cartVM)) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.title3)
                            if cartVM.cartItems.count > 0 {
                                Text("\(cartVM.cartItems.count)")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -10)
                            }
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
