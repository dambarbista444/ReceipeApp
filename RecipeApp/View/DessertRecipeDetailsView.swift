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
    
    @Binding var mealId: String
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView {
                        Text(LocalizedString.loadingText)
                    }
                case .success:
                    setupDessertDetailsView()
                case .failure:
                    Text(LocalizedString.serviceErrorMessage)
                }
            }
            .task {
                await viewModel.getDessertDetails()
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
            .onAppear {
                viewModel.mealId = mealId
            }
            .navigationTitle(viewModel.mealName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func setupDessertDetailsView() -> some View {
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
                    .padding([.top, .leading, .bottom])
                
                setupIngredientView()
            }
        }
    }
    
    private func setupIngredientView() -> some View {
        ForEach(viewModel.ingredients, id: \.name) { ingredient in
            HStack(alignment: .top) {
                /// Ingredients
                VStack(alignment: .leading) {
                    Text(ingredient.name)
                        .font(.subheadline)
                }
                
                Spacer()
                
                /// Measure
                VStack(alignment: .leading) {
                    Text(ingredient.measure)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DessertRecipeDetailsView(mealId: .constant(""))
}
