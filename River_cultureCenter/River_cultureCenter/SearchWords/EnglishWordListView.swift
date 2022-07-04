//
//  EnglishWordListView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI
import ActivityIndicatorView

struct Words : Decodable{
    let words : [String]
}

struct EnglishWordListView: View {
    @ObservedObject var viewModel: CountViewModel
    @State var isloading = false
    @EnvironmentObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        VStack{
            if isloading {
                loadingView()
            }else{
                searchWordsAgainView()
            }
        }
        .padding(.top, 30)
        .navigationTitle("단어 list (\(viewModel.countedWord)개)")
    }
    @ViewBuilder
        func loadingView() -> some View   {
            ActivityIndicatorView(isVisible: $isloading, type: .scalingDots())
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            Spacer()
        }
    
    @ViewBuilder
    func searchWordsAgainView() -> some View {
            VStack{
                SelectingWordsCountView(viewModel: viewModel)
                SearchButtonView(countViewModel: viewModel, isloading: $isloading)
            }
            .padding(.bottom, 30)
            List(viewModel.words, id : \.self){ word in
                Text(word)
            }
            .listStyle(.plain)
    }
}

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
        Button {
            Task {
                await self.loadData()
            }
        } label: {
            Text("단어 검색")
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .foregroundColor(Color.gray.opacity(0.4))
                )
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

struct EnglishWordListView_Previews: PreviewProvider {
    static var previews: some View {
        EnglishWordListView(viewModel : CountViewModel())
    }
}
