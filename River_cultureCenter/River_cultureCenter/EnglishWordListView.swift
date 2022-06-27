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
  @State private var words = [String]()
  @ObservedObject var countModel : CountModel
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
          AlertCountView(countModel: countModel)
          CountButtonsView(countModel: countModel)
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
        List(words, id : \.self){ word in
          Text(word)
        }
        .listStyle(.plain)
      }
    }
    .padding(.top, 30)
    .navigationTitle("단어 list (\(countModel.countedWord)개)")
    // Task : Adds an asynchronous task to perform when this view appears.
    .task {
      await awaitloadData()
    }
  }
  
  func awaitloadData() async{
    do{
      isloading = true
      try await loadData()
      isloading = false
    }catch{
      print(error)
    }
  }
  
  
   enum fetchError : Error{
     case InvalidURL
     case InvalidData
   }
  
  func loadData() async throws{
    // 1) creare the url that I want to read
    guard let url  = URL(string: "https://random-word-api.herokuapp.com/word?number=\(countModel.countedWord)")
    else{
      throw fetchError.InvalidURL
    }
    
    // 2) fetch data for a url
    do {
      // data랑 describe된 data -> 튜플
      // .shared 짧은 url response용 간이 녀석인 거 같음
      let (data, _) = try await URLSession.shared.data(from: url)
      
      // 3) decode the result of that data into our response struct we designed
      // JSONDecoder: JSON -> 실사용 instance(codable 해야 함)
      if let decodedResponse = try? JSONDecoder().decode([String].self, from : data){
        words = decodedResponse
      }else{
        throw fetchError.InvalidData
      }
    }catch{
      throw fetchError.InvalidData
    }
  }
}

struct EnglishWordListView_Previews: PreviewProvider {
  
  static var previews: some View {
    EnglishWordListView(countModel : CountModel())
  }
}
