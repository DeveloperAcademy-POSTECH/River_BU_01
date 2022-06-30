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
        AlertCountView(viewModel: viewModel)
        CountButtonsView(viewModel: viewModel)
    }
}

struct SelectingWordsCountView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectingWordsCountView(viewModel: CountViewModel())
    }
}
