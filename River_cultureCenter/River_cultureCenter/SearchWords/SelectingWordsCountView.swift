//
//  SelectingWordsCountView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

/// 단어 갯수를 설정하는 View
struct SelectingWordsCountView: View {
    @ObservedObject var viewModel: CountViewModel
    
    var body: some View {
        Text("단어 갯수를 선택하세요")
            .font(.title2)
        AlertCountView()
        CountButtonsView()
    }
    
    @ViewBuilder
    func CountButtonsView() -> some View {
        HStack{
            Button(action: {
                    viewModel.downCountedWord()
            }) {
                Image(systemName: "minus.circle")
            }.foregroundColor(viewModel.isCountValid == .valid ? .black : .gray)
            Text("\(viewModel.countedWord)")
            Button(action: {
                    viewModel.upCountedWord()
            }) {
                Image(systemName: "plus.circle")
            }.foregroundColor(viewModel.isCountValid == .valid ? .black : .gray)
        }
        .font(.title3)
    }
    
    @ViewBuilder
    func AlertCountView() -> some View {
            VStack{
                if viewModel.isCountValid == .under {
                    Text("1개 이상으로 검색이 가능합니다.")
                        .padding(.bottom)
                        .padding(.top, 5)
                }else if viewModel.isCountValid == .over {
                    Text("15개 이하로 검색 가능합니다.")
                        .padding(.bottom)
                        .padding(.top, 5)
                }
            }
            .foregroundColor(.red)
            .frame( height: 20)
            .opacity(0.3)
    }
}

struct SelectingWordsCountView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectingWordsCountView(viewModel: CountViewModel())
    }
}
