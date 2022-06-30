//
//  EnglishWordListView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

struct Words : Decodable{
    let words : [String]
}

struct EnglishWordListView: View {
    @ObservedObject var viewModel: CountViewModel
    @State private var isloading = false
    @EnvironmentObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        VStack{
            if isloading {
                Text("loading..")
                Spacer()
            }else{
                VStack{
                    SelectingWordsCountView(viewModel: viewModel)
                    Button(action: {
                        Task{
                            await awaitloadData()
                        }
                    }){
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
                }
                .padding(.bottom, 30)
                List(viewModel.words, id : \.self){ word in
                    Text(word)
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, 30)
        .navigationTitle("단어 list (\(viewModel.countedWord)개)")
    }
    
    func awaitloadData() async{
        do{
            isloading = true
            try await viewModel.loadData()
            isloading = false
        }catch{
            print(error)
        }
        historyViewModel.wordList.append(viewModel.words)
    }
}

struct EnglishWordListView_Previews: PreviewProvider {
    static var previews: some View {
        EnglishWordListView(viewModel : CountViewModel())
    }
}
