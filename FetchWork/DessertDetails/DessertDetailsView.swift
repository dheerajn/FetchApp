//
//  DessertDetailsView.swift
//  FetchWork
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

struct DessertDetailsView: View {
    @State var viewModel: DessertDetailsViewModel
    
    init(viewModel: DessertDetailsViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            switch viewModel.dessertAPICall {
            case .inProgress:
                ProgressView("Fetching meal info")
                
            case .ready:
                dessertDetailsView

            case .error:
                Text("Error fetching Meal details")
            }
        }
        .onAppear {
            viewModel.fetchMealDetails()
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var dessertDetailsView: some View {
        VStack(alignment: .leading) {
            TitleView(title: viewModel.dessertDetailsInfo?.mealName ?? "No meal Name")
            CaptionView(caption: viewModel.dessertDetailsInfo?.instructions ?? "No mean instructions")
            
            Divider()

            TitleView(title: "Ingredients")
            
            List(viewModel.dessertDetailsInfo!.allIngredients, id: \.self) { element in
                Text(element)
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

#Preview {
    DessertDetailsView(viewModel: DessertDetailsViewModel(mealId: "53049"))
}
