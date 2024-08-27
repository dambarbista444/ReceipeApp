//
//  ReceipeDetailsView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import SwiftUI

struct DessertRecipeDetailsView: View {
    @Environment(\.presentationMode) var presendMode
    
    @StateObject var viewModel = DessertRecipeDetailsViewModel()
    
    @State var showErrorMessage = false
    
    @Binding var mealId: String
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        GeometryReader { geometry in
                            if let imageURL = viewModel.imageUrl(for: viewModel.mealImage) {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipped()
                                        .roundedCorner(30, corners: [.topLeft, .topRight])
                                } placeholder: {
                                    Color.gray
                                        .frame(height: 350)
                                }
                            }
                        }
                        .padding(.bottom)
                        .frame(height: 350)
                        
                        HStack {
                            Text(viewModel.mealName)
                                .fontWeight(.bold)
                            Spacer()
                            Text("⭐️ 4.5")
                        }
                        .padding()
                        
                        Text("\(LocalizedString.instructionsText) 📖")
                            .fontWeight(.bold)
                            .padding([.top, .leading])
                        
                        Text(viewModel.instructions)
                            .font(.subheadline)
                            .padding()
                        
                        Text("\(LocalizedString.ingredientsText) 🥣")
                            .fontWeight(.bold)
                            .padding([.top, .leading])
                        
                        setupIngredientView()
                    }
                    .task {
                        await viewModel.getDessertList()
                        showErrorMessage = viewModel.showErrorMessage
                    }
                    .alert(LocalizedString.serviceErrorMessage, isPresented: $showErrorMessage) {
                        Button(LocalizedString.okText, role: .cancel, action: { })
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                presendMode.wrappedValue.dismiss()
                            }, label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30) // use in constant for height
                                        .foregroundColor(.gray)
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black)
                                }
                            })
                        }
                    }
                    .navigationTitle(viewModel.mealName)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .onAppear {
                viewModel.mealId = mealId
            }
        }
    }
}

extension DessertRecipeDetailsView {
    func setupIngredientView() -> some View {
        HStack(alignment: .top){
            /// Ingredients
            VStack(alignment: .leading) {
                Group {
                    Text(viewModel.ingredient1)
                    Text(viewModel.ingredient2)
                    Text(viewModel.ingredient3)
                    Text(viewModel.ingredient4)
                    Text(viewModel.ingredient5)
                    Text(viewModel.ingredient6)
                    Text(viewModel.ingredient7)
                    Text(viewModel.ingredient8)
                    Text(viewModel.ingredient9)
                    Text(viewModel.ingredient10)
                    Text(viewModel.ingredient11)
                    Text(viewModel.ingredient12)
                    Text(viewModel.ingredient13)
                    Text(viewModel.ingredient14)
                    Text(viewModel.ingredient15)
                    Text(viewModel.ingredient16)
                    Text(viewModel.ingredient17)
                    Text(viewModel.ingredient18)
                    Text(viewModel.ingredient19)
                    Text(viewModel.ingredient20)
                }
                .font(.subheadline)
            }
            
            Spacer()
            
            /// Measure
            VStack(alignment: .leading) {
                Group {
                    Text(viewModel.measure1)
                    Text(viewModel.measure2)
                    Text(viewModel.measure3)
                    Text(viewModel.measure4)
                    Text(viewModel.measure5)
                    Text(viewModel.measure6)
                    Text(viewModel.measure7)
                    Text(viewModel.measure8)
                    Text(viewModel.measure9)
                    Text(viewModel.measure10)
                    Text(viewModel.measure11)
                    Text(viewModel.measure12)
                    Text(viewModel.measure13)
                    Text(viewModel.measure14)
                    Text(viewModel.measure15)
                    Text(viewModel.measure16)
                    Text(viewModel.measure17)
                    Text(viewModel.measure18)
                    Text(viewModel.measure19)
                    Text(viewModel.measure20)
                }
                .font(.subheadline)
            }
        }
        .padding()
    }
}

#Preview {
    DessertRecipeDetailsView(showErrorMessage: false, mealId: .constant(""))
}
