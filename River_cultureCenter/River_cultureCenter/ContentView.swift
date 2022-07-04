//
//  ContentView.swift
//  River_cultureCenter
//
//  Created by 이가은 on 2022/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchWordsView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("search words")
                }
            HistoryListView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("history words")
                }
        }
        .environmentObject(HistoryViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
