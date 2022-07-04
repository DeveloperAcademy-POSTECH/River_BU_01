//
//  EnglishWordListView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

struct Words : Decodable{
  let words : [String]
}
// swift의 function은 synchronous..?

struct EnglishWordListView: View {
  @ObservedObject var viewModel: CountViewModel
  @State private var isloading = true
  
  var body: some View {
    VStack{
      if isloading {
        Text("loading..")
        Spacer()
      }else{
        Text("단어 갯수를 선택하세요")
          .font(.title3)
        HStack(alignment:.center){
          AlertCountView(viewModel: viewModel)
          CountButtonsView(viewModel: viewModel)
          Button(action: {
            Task{
              await awaitloadData()
            }
          }) {
            Capsule(style: .circular)
              .fill(
                Color(UIColor.systemGray5)
              )
              .frame(width: 110, height: 50)
              .overlay(
                Text("Again !")
                  .foregroundColor(.black)
              )
          }
        }
        .padding(.bottom, 30)
          List(viewModel.words, id : \.self){ word in
          Text(word)
        }
        .listStyle(.plain)
      }
    }
    .padding(.top, 30)
    .navigationTitle("단어 list (\(viewModel.countedWord)개)")
    // Task : Adds an asynchronous task to perform when this view appears.
    .task {
      await awaitloadData()
    }
  }
  
  func awaitloadData() async{
    do{
      isloading = true
        try await viewModel.loadData()
      isloading = false
    }catch{
      print(error)
    }
  }
}

struct EnglishWordListView_Previews: PreviewProvider {
  
  static var previews: some View {
    EnglishWordListView(viewModel : CountViewModel())
  }
}
