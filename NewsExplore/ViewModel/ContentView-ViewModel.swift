//
//  ContentView-ViewModel.swift
//  NewsExplore
//
//  Created by Danya Kukhar on 06.10.2022.
//

import Foundation


extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published public var searchText: String = ""
        @Published private (set) var articles: [Article] = []
        @Published public var dateFrom = Date()
        @Published public var dateTo = Date()
        @Published public var sortBy = ""
        @Published private var networkingService = NetworkingService()
        
        
        func addArticles(requestType: NetworkingService.RequestType) async {
            
            switch requestType {
            case .loadDataFromText:
                await networkingService.loadData(searchText: searchText, sortBy: nil, from: nil, to: nil, requestType: .loadDataFromText, complition: { [weak self] response in
                    guard let response = response else { return }
                    Task {
                        self?.articles = response.articles
                    }
                })
            case .loadDataSortBy:
                await networkingService.loadData(searchText: searchText, sortBy: sortBy, from: nil, to: nil, requestType: .loadDataSortBy, complition: { [weak self] response in
                    guard let response = response else { return }
                    Task {
                        self?.articles = response.articles
                    }
                })
            case .loadDataFromTo(let from, let to):
                await networkingService.loadData(searchText: searchText, sortBy: nil, from: from, to: to, requestType: .loadDataFromTo(from: nil, to: nil), complition: { [weak self] response in
                    guard let response = response else { return }
                    Task {
                        self?.articles = response.articles
                    }
                })
            }
        }
        
    }
}

