//
//  DiscoverLandingView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/26/24.
//

import SwiftUI

struct RecipeLandingView: View {
    @State var searchText = ""
    
    @FocusState var isFocused: Bool
    
    private var shouldShowClearButton: Bool {
        return !searchText.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray)
                                .foregroundColor(.white)
                        }
                        .frame(height: 40)
                        .padding()
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        TextField("Search meal", text: $searchText)
                            .focused($isFocused)
                            .frame(height: 30)
                        
                        if shouldShowClearButton {
                            Button(action: {
                                searchText = ""
                                isFocused = false
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .padding(.all, 4)
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .clipShape(Circle())
                                    
                            })
                            .padding(.trailing, 10)
                        }
                    }
                    .padding()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        RecipeCategoriesView(searchText: searchText)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle(LocalizedString.discoverTitleText)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecipeLandingView()
}
