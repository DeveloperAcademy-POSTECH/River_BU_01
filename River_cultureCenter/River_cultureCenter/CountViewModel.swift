//
//  CountViewModel.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

class CountViewModel : ObservableObject {
    @Published var countedWord: Int
    @Published var words: [String]
    
    init(){
        countedWord = 0
        words = []
    }
    
    enum fetchError: Error {
        case InvalidURL
        case InvalidData
    }
    
    func isNumberBiggerThan1() -> Bool {
        if self.countedWord > 1 {
            return true
        } else {
            return false
        }
    }
    
    func isNumberSmallerThan15() -> Bool {
        if self.countedWord < 15 {
            return true
        } else {
            return false
        }
    }
    
    func loadData() async throws {
        // 1) creare the url that I want to read
        guard let url  = URL(string: "https://random-word-api.herokuapp.com/word?number=\(self.countedWord)")
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
                self.words = decodedResponse
            }else{
                throw fetchError.InvalidData
            }
        }catch{
            throw fetchError.InvalidData
        }
    }
    
    func upCountedWord(){
        self.countedWord += 1
    }
    
    func downCountedWord(){
        self.countedWord -= 1
    }
}

