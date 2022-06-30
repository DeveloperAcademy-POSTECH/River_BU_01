//
//  SearchWordsView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI
import ActivityIndicatorView

struct SearchWordsView: View {
    @StateObject var countViewModel = CountViewModel()
    @State var isShowWordsList = false
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @State private var isloading = false
    
    var body: some View {
        NavigationView{
            VStack{
                if isloading {
                    ActivityIndicatorView(isVisible: $isloading, type: .scalingDots())
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                } else {
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
                    .padding(.top, 20)
                }
                NavigationLink("", destination: EnglishWordListView(viewModel: countViewModel), isActive: $isShowWordsList)
            }
        }
    }
    
    func awaitloadData() async{
        do{
            isloading = true
            try await countViewModel.loadData()
            isloading = false
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
