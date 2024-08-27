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
                            .padding([.top, .leading, .bottom])
                        
                        setupIngredientView()
                    }
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
    
    func setupIngredientView() -> some View {
        ForEach(viewModel.getIngredientsWithMeasures(), id: \.0) { ingredient, measure in
            HStack(alignment: .top) {
                /// Ingredients
                VStack(alignment: .leading) {
                    Text(ingredient)
                        .font(.subheadline)
                }
                
                Spacer()
                
                /// Measure
                VStack(alignment: .leading) {
                    Text(measure)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DessertRecipeDetailsView(showErrorMessage: false, mealId: .constant(""))
}
