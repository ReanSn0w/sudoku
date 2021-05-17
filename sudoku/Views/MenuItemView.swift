//
//  MenuItemView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct NavigationMenuItemView<Destination>: View where Destination: View {
    var destination: Destination
    var title: String
    
    init(_ title: String, @ViewBuilder destination: () -> Destination) {
        self.destination = destination()
        self.title = title
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.title)
        }
    }
}

struct ButtonMenuItemView: View {
    var action: () -> Void
    var title: String
    
    init(_ title: String, action: @escaping () -> Void) {
        self.action = action
        self.title = title
    }
    
    var body: some View {
        Button(action: { self.action() }) {
            Text(title)
                .font(.title)
        }
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationMenuItemView("Название") {
                Text("Название")
            }
        }
    }
}
