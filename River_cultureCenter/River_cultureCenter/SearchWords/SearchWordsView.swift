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
    @State var isloading = false
    
    var body: some View {
        NavigationView{
            VStack{
                if isloading {
                    ActivityIndicatorView(isVisible: $isloading, type: .scalingDots())
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                } else {
                    SelectingWordsCountView(viewModel: countViewModel)
                    SearchButtonView(countViewModel: countViewModel, isloading: $isloading, isShowWordsList: $isShowWordsList)
                }
                NavigationLink("", destination: EnglishWordListView(viewModel: countViewModel), isActive: $isShowWordsList)
            }
            .navigationTitle("Search Words")
        }
    }
}

struct SearchWordsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchWordsView()
    }
}
