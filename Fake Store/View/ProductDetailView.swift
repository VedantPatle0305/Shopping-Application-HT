//
//  ProductDetailView.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var cartVM: CartViewModel
    
    let screenheight = UIScreen.main.bounds.height
    let screenwidth = UIScreen.main.bounds.width
    
    @State private var expandedDescription = false
    @State private var truncated = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .topTrailing){
                    
                    HStack{
//                        Image(systemName: "chevron.left")
//                            .frame(width: 50, height: 50)
//                            .background(
//                                Color(.systemGray5)
//                                    .cornerRadius(100)
//                            )
//                        
//                        Spacer()
//                        
//                        Button {
//                            cartVM.toggleCart(item: product)
//                        } label: {
//                            Image(systemName: cartVM.isInCart(item: product) ? "heart.fill" : "heart")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundColor(.red)
//                        }
//                        .padding()
//                        .frame(width: 50, height: 50)
//                        .background(
//                            Color(.systemGray5)
//                                .cornerRadius(100)
//                        )
                        
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 50, height: 50)
                            .background(
                                Color(.systemGray5)
                                    .cornerRadius(100)
                            )
                    }
                    
                    
                    AsyncImage(url: URL(string: product.image)) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: screenwidth*0.9,height: screenheight*0.35)
                }
                
                
                Text(product.title)
                    .frame(width: screenwidth*0.9, alignment: .leading)
                    .font(.title2)
                    .bold()
                    .lineLimit(2)


                HStack{
                    HStack(alignment: .center, spacing: 5){
                        Text("⭐️ \(product.rating.rate, specifier: "%.1f")")
                            .foregroundColor(.orange)
                        Text("\(product.rating.count) reviews")
                            .font(.caption)
                    }
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                    HStack(alignment: .center, spacing: 5){
                        Image(systemName: "hand.thumbsup.fill")
                            .foregroundColor(Color.blue)
                        Text("94%")
                            .font(.subheadline)
                    }
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    
                    Spacer()
                }
                .frame(width: screenwidth*0.9)
                .padding(3)
                
                HStack(alignment: .center){
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("from $5 per month")
                        .font(.caption)
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .padding(.trailing, 5)

                }
                .padding(8)
                .frame(width: screenwidth*0.9)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)

                
                
                
                VStack(alignment: .leading, spacing: 4) {
                        Text(product.description)
                            .frame(width: screenwidth * 0.9, alignment: .leading)
                            .font(.body)
                            .lineLimit(expandedDescription ? nil : 3)
                            .background(
                                // hidden full text for truncation check
                                    Text(product.description)
                                        .font(.body)
                                        .lineLimit(nil)
                                        .background(
                                            GeometryReader { geo in
                                                Color.clear.onAppear {
                                                    let fullHeight = geo.size.height
                                        let lineHeight = UIFont.preferredFont(forTextStyle: .body).lineHeight
                                        let limitedHeight = lineHeight * 3
                                                            
                                        if fullHeight > limitedHeight {
                                            truncated = true
                                        }
                                    }
                                }
                            )
                            .hidden()
                    )
                                    
                    if truncated {
                        Button(action: {
                            withAnimation {
                                expandedDescription.toggle()
                            }
                        }) {
                            Text(expandedDescription ? "Read Less" : "Read More")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .fontWeight(.heavy)
                        }
                        .frame(width: screenwidth * 0.9, alignment: .trailing)
                    }
                }
                
                
                Button {
                    cartVM.toggleCart(item: product)
                } label: {
                    Label(cartVM.isInCart(item: product) ? "Remove from Cart" : "Add to Cart",
                          systemImage: "cart")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(8)
                }
                .padding(8)
                .frame(width: screenwidth * 0.9)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                Text("Delivery on 3rd May")
                    .font(.subheadline)
                    .fontWeight(.light)
                
            }
            .padding()
            .navigationTitle("Product Detail")
            .toolbar {
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
}

#Preview {
    let mockProduct = Product(
        id: 15,
        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
        price: 19.99,
        description: "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
        image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_t.png",
        rating: Rating(rate: 4.5, count: 120)
    )
    
    return ProductDetailView(product: mockProduct, cartVM: CartViewModel())
}
