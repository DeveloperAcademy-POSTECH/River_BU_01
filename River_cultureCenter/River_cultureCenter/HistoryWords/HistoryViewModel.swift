//
//  HistoryViewModel.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/06/30.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var wordList: [[String]]
    init(){
        self.wordList = []
    }
}
