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
    @State var copiedWordList: [String] = []
    @EnvironmentObject var historyViewModel: HistoryViewModel
    @State var isAlert = false

    var body: some View {
        VStack{
            HStack{
                Text("수정이 완료되었습니다!")
                    .foregroundColor(isAlert ? .blue : .white)
                Spacer()
                Button {
                    historyViewModel.fixWords(index: listIndex, words: copiedWordList)
                    isAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.isAlert = false
                    }
                } label: {
                    Text("수정완료")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .foregroundColor(.black)
                        .background(
                            Capsule()
                                .foregroundColor(Color(UIColor.systemGray5))
                        )
                }
            }
            .padding(.horizontal, 25)
            List{
                ForEach(0..<copiedWordList.count, id: \.self) { index in
                    TextField("word", text: $copiedWordList[index])
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("List \(listIndex+1)")
        .onAppear{
            self.copiedWordList = wordList
        }
    }
}

struct HistoryWordsView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryWordsView(listIndex: 1, wordList: .constant(["hi","river"]))
    }
}
