//
//  ContentView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 04.05.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainMenuScene()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
