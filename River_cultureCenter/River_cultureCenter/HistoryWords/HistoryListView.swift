//
//  HistoryListView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var historyViewModel: HistoryViewModel
    var body: some View {
        if(historyViewModel.wordList.count == 0){
            Text("검색하신 영어단어가 없습니다 !")
        }else{
            NavigationView{
                List{
                    ForEach(0..<historyViewModel.wordList.count, id: \.self) { index in
                        let wordList = historyViewModel.wordList[index]
                        NavigationLink("List \(index+1) : \(historyViewModel.wordList[index].count)개의 단어",
                                       destination: HistoryWordsView(listIndex: index, wordList: wordList)
                        )
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Words History")
            }
        }
    }
}

struct HistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryListView()
    }
}
