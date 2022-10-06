//
//  DetailView.swift
//  NewsExplore
//
//  Created by Danya Kukhar on 03.10.2022.
//

import SwiftUI

struct DetailView: View {
    
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }
            
            Text(article.title)
                .fontWeight(.bold)
                .font(.title)
                .padding(.leading)
                .padding(.bottom)
            Text(article.author ?? "")
                .font(.subheadline)
                .padding(.leading)
            Text(article.description)
                .font(.title2)
                .padding(.leading)
                .padding(.top)
            
            Spacer()
            
            HStack(spacing: 150) {
                Text(article.source.name.capitalized)
                    .padding(.leading)
                    .foregroundColor(.secondary)
                    
                Text(dateConvert(dateString: article.publishedAt ?? ""))
                    .padding(.trailing)
                    .foregroundColor(.secondary)
                
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: Article(source: Source(id: "the-verge", name: "The Verge"), author: "Jennifer Pattison Tuohy", title: "Apple announces a new Apple Watch SE", description: "Apple revealed its newest budget-friendly cellular smartwatch today. The Apple Watch SE is the second generation of the Apple Watch SE, a model that’s popular with families thanks to Apple’s Family Setup.", urlToImage: "https://cdn.vox-cdn.com/thumbor/Ex3xCDQkaRWe0vSdsuAjTG8mj7s=/0x144:2000x1191/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/24002561/lcimg_69fdc845_931b_4cfb_ba63_bbe04f91c30f.jpeg", publishedAt: "2022-09-07T17:26:49Z"))
    }
}
