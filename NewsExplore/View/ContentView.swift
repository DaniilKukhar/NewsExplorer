//
//  ContentView.swift
//  NewsExplore
//
//  Created by Danya Kukhar on 03.10.2022.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $viewModel.searchText)
                    .padding(.leading)
                    .padding(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        Task {
                            await viewModel.addArticles(requestType: .loadDataFromText)
                        }
                    }
                HStack(spacing: 5) {
                    DatePicker(selection: $viewModel.dateFrom, in: ...Date(), displayedComponents: .date, label: {
                        Image(systemName: "calendar.circle")
                    })
                    .padding(.leading)
                    .onChange(of: viewModel.dateFrom) { newValue in
                        Task {
                            await viewModel.addArticles(requestType: .loadDataFromTo(from: newValue, to: viewModel.dateTo))
                            
                        }
                    }
                    
                    
                    DatePicker(selection: $viewModel.dateTo, in: ...Date(), displayedComponents: .date, label: {
                        Image(systemName: "calendar.circle.fill")
                    })
                    .padding(.trailing)
                    .onChange(of: viewModel.dateTo) { newValue in
                        Task {
                            await viewModel.addArticles(requestType: .loadDataFromTo(from: viewModel.dateTo, to: newValue))
                        }
                    }
                }
                
                List(viewModel.articles, id: \.self) { article in
                    VStack(alignment:.leading, spacing: 3) {
                        NavigationLink("", destination: DetailView(article: article))
                        Text(article.title)
                            .fontWeight(.bold)
                            .font(.headline)
                        Text(article.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .padding()
                }
                .listStyle(.plain)
                .navigationTitle("News")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("Relevancy") {
                                viewModel.sortBy = "relevancy"
                                Task {
                                    await viewModel.addArticles(requestType: .loadDataSortBy)
                                }
                            }
                            Button("Popularity") {
                                viewModel.sortBy = "popularity"
                                Task {
                                    await viewModel.addArticles(requestType: .loadDataSortBy)
                                }
                            }
                            Button("Published At") {
                                viewModel.sortBy = "publishedAt"
                                Task {
                                    await viewModel.addArticles(requestType: .loadDataSortBy)
                                }
                            }
                            
                        } label: {
                            Text("Sort by")
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
