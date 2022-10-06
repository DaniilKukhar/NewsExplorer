//
//  NetworkingService.swift
//  NewsExplore
//
//  Created by Danya Kukhar on 03.10.2022.
//

import SwiftUI

class NetworkingService {

    enum RequestType {
        case loadDataFromText
        case loadDataSortBy
        case loadDataFromTo(from: Date?, to: Date?)
    }
    
    func loadData(searchText: String, sortBy: String?, from: Date?, to: Date?, requestType: RequestType, complition: @escaping (NewsResponse?) -> ()) async {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var url: URL?
        
        switch requestType {
        case .loadDataFromText:
            url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=c5df66a1c2af4308a72b7019635153bc")
        case .loadDataSortBy:
            guard let sortBy = sortBy else { return }
            url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&sortBy=\(sortBy)&apiKey=c5df66a1c2af4308a72b7019635153bc")
        case .loadDataFromTo:
            guard let dateFrom = from, let dateTo = to else { return }
            let stringDateFrom = dateFormatter.string(from: dateFrom)
            let stringDateTo = dateFormatter.string(from: dateTo)
            url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&from=\(stringDateFrom)&to=\(stringDateTo)&apiKey=c5df66a1c2af4308a72b7019635153bc")
        }
        
        guard let url = url else { return }
        
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                complition(decodeResponse)
            }
        } catch {
            print("Invalid data")
            complition(nil)
        }
    }
}
