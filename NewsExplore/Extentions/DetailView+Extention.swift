//
//  DataFormatter .swift
//  NewsExplore
//
//  Created by Danya Kukhar on 06.10.2022.
//

import Foundation

extension DetailView {
    func dateConvert(dateString: String) -> (String) {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let anotherFormatter = DateFormatter()
        anotherFormatter.dateFormat = "d MMMM, yyyy"
        guard let date = dataFormatter.date(from: dateString) else {
            return "Unable to convert to type Date" }
        let stringFromDate = anotherFormatter.string(from: date)
        return stringFromDate
    }
}

