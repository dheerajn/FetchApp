//
//  ContentView.swift
//  Fetch
//
//  Created by Dheeraj Neelam on 7/22/24.
//

import SwiftUI

struct DessertsView: View {
    private enum InspectionId {
        static let dessertsView = "DESSERTS_VIEW"
    }

    @StateObject var viewModel = DessertsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.status {
                case .error:
                    Text("Error fetching Dessets")

                case .inProgress:
                    ProgressView()

                case .ready:
                    dessertsDetailsView
                        .accessibilityIdentifier("")
                }
            }
            .task {
                await viewModel.fetchDesserts()
            }
            .navigationTitle("Desserts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var dessertsDetailsView: some View {
        List(viewModel.desserts) { currentMeal in
            NavigationLink {
                DessertDetailsView(viewModel: DessertDetailsViewModel(mealId: currentMeal.idMeal))
            } label: {
                HStack {
                    AsyncImageloader(url: URL(string: currentMeal.strMealThumb)!) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "fork.knife")
                    }

                    VStack(alignment: .leading) {
                        Text(currentMeal.strMeal)
                            .font(.title3)
                        
                        Text(currentMeal.idMeal)
                            .font(.callout)
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Meal name: \(currentMeal.strMeal)")
                .accessibilityHint("Meal identifier: \(currentMeal.idMeal)")
                .accessibilityIdentifier(InspectionId.dessertsView)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0) )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding()

    }
}

#Preview {
    DessertsView()
}
