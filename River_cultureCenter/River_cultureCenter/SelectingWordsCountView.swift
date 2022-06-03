//
//  SelectingWordsCountView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

/// 영단어 숫자를 올리고 내리는 View
struct CountButtonsView: View{
    @ObservedObject var countModel : CountModel
    
    var body: some View {
        HStack{
            Button(action: {
                if countModel.countedWord > 1 {
                    countModel.downCountedWord()
                    countModel.isAlert = false
                }else{
                    countModel.isAlert = true
                }
            }) {
                Image(systemName: "minus.circle")
            }.foregroundColor(.black)
            Text("\(countModel.countedWord)")
            Image(systemName: "plus.circle")
                .onTapGesture {
                    if countModel.countedWord < 15 {
                        countModel.upCountedWord()
                        countModel.isAlert = false
                    }else{
                        countModel.isAlert = true
                    }
                }
        }
        .font(.title3)
    }
}

/// 영단어 숫자가 범위를 벗어날 시에 사용자에게 벗어났음을 경고하는 뷰
struct AlertCountView: View{
    @ObservedObject var countModel : CountModel
    
    var body: some View {
        VStack{
            if countModel.countedWord == 1 && countModel.isAlert {
                Text("최소 1개까지 검색 가능합니다.")
                    .padding(.bottom)
                    .padding(.top, 5)
            }else if countModel.countedWord == 15 && countModel.isAlert {
                Text("최대 15개까지 검색 가능합니다.")
                    .padding(.bottom)
                    .padding(.top, 5)
            }
        }
        .frame( height: 20)
        .opacity(0.3)
    }
}

/// 단어 갯수를 설정하는 View
struct SelectingWordsCountView: View {
    @StateObject var countModel = CountModel()
    @State var isShowWordsList = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("단어 갯수를 선택하세요")
                    .font(.title2)
                AlertCountView(countModel: countModel)
                CountButtonsView(countModel: countModel)
                
                Button(action: {
                    isShowWordsList = true
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
                .padding(.top, 30)
                
                NavigationLink("", destination: EnglishWordListView(countModel : countModel),isActive: $isShowWordsList)
            }
        }
    }
}

struct SelectingWordsCountView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectingWordsCountView()
    }
}
