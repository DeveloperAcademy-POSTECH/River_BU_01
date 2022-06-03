//
//  CountModel.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

class CountModel : ObservableObject{
    @Published var countedWord : Int
    @Published var isAlert : Bool
    
    func upCountedWord(){
        self.countedWord += 1
    }
    
    func downCountedWord(){
        self.countedWord -= 1
    }
    
    init(){
        countedWord = 1
        isAlert = false
    }
}

