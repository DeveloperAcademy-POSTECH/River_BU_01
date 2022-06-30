//
//  CountButtonView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

/// 영단어 숫자를 올리고 내리는 View
struct CountButtonsView: View{
    @ObservedObject var viewModel : CountViewModel
    
    var body: some View {
        HStack{
            Button(action: {
                if viewModel.isNumberBiggerThan1() {
                    viewModel.downCountedWord()
                }
            }) {
                Image(systemName: "minus.circle")
            }.foregroundColor(.black)
            Text("\(viewModel.countedWord)")
            Button(action: {
                if viewModel.isNumberSmallerThan15(){
                    viewModel.upCountedWord()
                }
            }) {
                Image(systemName: "plus.circle")
            }.foregroundColor(.black)
        }
        .font(.title3)
    }
}

struct CountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CountButtonsView(viewModel: CountViewModel())
    }
}
