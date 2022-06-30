//
//  HistoryWordsView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

struct HistoryWordsView: View {
    let listIndex: Int
    let wordList: [String]
    var body: some View {
        VStack{
            List{
                ForEach(0..<wordList.count, id: \.self) { index in
                    Text("\(wordList[index])")
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("List \(listIndex+1)")
    }
}

struct HistoryWordsView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryWordsView(listIndex: 1, wordList: ["hi","river"])
    }
}
