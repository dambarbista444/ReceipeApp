//
//  DiscoverLandingView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/26/24.
//

import SwiftUI

struct RecipeLandingView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    RecipeCategoriesView()
                        .padding()
                }
                .navigationTitle(LocalizedString.discoverTitleText)
            }
        }
    }
}

#Preview {
    RecipeLandingView()
}
