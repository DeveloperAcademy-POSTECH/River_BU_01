//
//  SearchWordsView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

struct SearchWordsView: View {
    @StateObject var countViewModel = CountViewModel()
    @State var isShowWordsList = false
    @EnvironmentObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        NavigationView{
            VStack{
                SelectingWordsCountView(viewModel: countViewModel)
                Button(action: {
                    Task {
                            await awaitloadData()
                        }
                }) {
                    Capsule(style: .circular)
                        .fill(
                            Color(UIColor.systemGray5)
                        )
                        .frame(width: 110, height: 50)
                        .overlay(
                            Text("영단어 찾기")
                                .foregroundColor(.black)
                        )
                }
                NavigationLink("", destination: EnglishWordListView(viewModel: countViewModel), isActive: $isShowWordsList)
            }
        }
    }
    
    func awaitloadData() async{
        do{
            try await countViewModel.loadData()
            isShowWordsList = true
        }catch{
            print(error)
        }
        historyViewModel.wordList.append(countViewModel.words)
    }
}

struct SearchWordsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchWordsView()
    }
}
