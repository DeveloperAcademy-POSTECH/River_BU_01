//
//  AlertCountView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

/// 영단어 숫자가 범위를 벗어날 시에 사용자에게 벗어났음을 경고하는 뷰
struct AlertCountView: View{
    @ObservedObject var viewModel : CountViewModel
    
    var body: some View {
        VStack{
            if viewModel.countedWord == 1 {
                Text("1개 이상으로 검색이 가능합니다.")
                    .padding(.bottom)
                    .padding(.top, 5)
            }else if viewModel.countedWord == 15 {
                Text("15개 이하로 검색 가능합니다.")
                    .padding(.bottom)
                    .padding(.top, 5)
            }
        }
        .frame( height: 20)
        .opacity(0.3)
    }
}

struct AlertCountView_Previews: PreviewProvider {
    static var previews: some View {
        AlertCountView(viewModel: CountViewModel())
    }
}
