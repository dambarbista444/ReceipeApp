//
//  DiscoverLandingView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/26/24.
//

import SwiftUI

struct RecipeLandingView: View {
    @State var searchText = ""
    
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
                            .padding(.leading, 5)
                        
                        TextField("Search meal", text: $searchText)
                            .frame(height: 30)
                        
                        if shouldShowClearButton {
                            Button(action: {
                                searchText = ""
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.black)
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
