//
//  SearchButtonView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/07/04.
//

import SwiftUI

struct SearchButtonView: View {
    @ObservedObject var countviewModel: CountViewModel
    @Binding var isloading: Bool
    @Binding var isShowWordsList: Bool
    @EnvironmentObject var historyViewModel: HistoryViewModel
    
    init(countViewModel: CountViewModel, isloading: Binding<Bool>, isShowWordsList: Binding<Bool> = .constant(false)){
        self.countviewModel = countViewModel
        self._isloading = isloading
        self._isShowWordsList = isShowWordsList
    }
    
    var body: some View {
        if countviewModel.isCountValid == CountViewModel.CountValidation.valid {
            Button {
                Task {
                    await self.loadData()
                }
            } label: {
                Text("단어 검색")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .foregroundColor(Color.blue.opacity(0.2))
                    )
            }
        }
    }
    
    func loadData() async {
        do {
            isloading = true
            try await countviewModel.loadWordsAPI()
            isloading = false
            isShowWordsList = true
        } catch {
            print(error)
        }
        historyViewModel.appendWordsList(words: countviewModel.words)
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView(countViewModel: CountViewModel(), isloading: .constant(false))
    }
}
