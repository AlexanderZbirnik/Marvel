//
//  ContentView.swift
//  Marvel
//
//  Created by Alexander Zbirnik on 24.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "magazine.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hi, Marvel!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
