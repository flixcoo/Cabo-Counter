//
//  ContentView.swift
//  Cabo-Counter
//
//  Created by Felix Kirchner on 18.09.24.
//

import SwiftUI

private var game = Game()
private var i: Int = 0

struct ContentView: View {
    @State var gameArray = [Game]()
    var body: some View {
        NavigationView {
            HStack {
                List(gameArray){
                    game in Button(action: {
                        print("Spiel ausgewählt: \(game.name) \(i)")
                    }) {
                        VStack{
                            Text(game.getDateInNormalFormat()).fontWeight(.bold)
                            ZStack{
                                HStack{
                                    Text(game.name).padding([.leading])
                                    Spacer()
                                }
                                
                                HStack{
                                    Image(systemName: "crown.fill")
                                    Text(game.winner)
                                }
                                
                                HStack{
                                    Spacer()
                                    Text(String(game.playerAmount))
                                    Image(systemName: "person.3.fill").padding([.trailing])
                                }
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cabo-Counter") // Titel der Navigation Bar
            .navigationBarItems(
                trailing:
                NavigationLink(destination: NewGameView()) {  // Verweis auf die Ziel-View
                    Image(systemName: "plus")  // Bild oder Text für den Button
                }
            )
        }
    }
}

#Preview {
    ContentView()
}


