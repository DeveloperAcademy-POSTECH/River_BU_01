//
//  SearchButtonView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/07/04.
//

import SwiftUI


struct SearchButtonView: View {
    @ObservedObject var countViewModel : CountViewModel
    @Binding var isloading : Bool
    @Binding var isShowWordsList : Bool
    @EnvironmentObject var historyViewModel: HistoryViewModel
    
    init(countViewModel: CountViewModel, isloading: Binding<Bool>, isShowWordsList: Binding<Bool> = .constant(false)){
        self.countViewModel = countViewModel
        self._isloading = isloading
        self._isShowWordsList = isShowWordsList
    }
    
    var body: some View {
        if countViewModel.isCountValid == .valid {
            Button(action: {
                Task{
                    await self.loadData()
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
    }
    
    func loadData() async {
        do{
            isloading = true
            try await countViewModel.loadWordsAPI()
            isloading = false
            isShowWordsList = true
            historyViewModel.appendWordsList(words: countViewModel.words)
        }catch{
            print(error)
        }
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView(countViewModel: CountViewModel(), isloading: .constant(false), isShowWordsList: .constant(false))
    }
}
