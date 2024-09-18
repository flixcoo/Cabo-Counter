//
//  ContentView.swift
//  Cabo-Counter
//
//  Created by Felix Kirchner on 18.09.24.
//

import SwiftUI

var gameArray = [Game]()
private var game = Game(name: "Testspiel")


struct ContentView: View {
    func addGameToArray(game:Game){
        gameArray.append(game)
    }
    var body: some View {
        NavigationView {
            HStack {
                List(gameArray){
                    game in Text(game.name)
                }
            }
            .navigationTitle("Cabo-Counter") // Titel der Navigation Bar
            .navigationBarItems(
                trailing:  // Buttons rechts in der Navigation Bar
                Button(
                    action: {
                        let game = Game(name: "Testspiel")
                        addGameToArray(game: game)
                    }
                ){
                    Image(systemName: "plus")
                })
        }
    }
}
#Preview {
    ContentView()
}
