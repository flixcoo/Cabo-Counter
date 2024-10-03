import SwiftUI

private var game = Game()
private var i: Int = 0

struct MainMenu: View {
    @State var gameArray = [Game]()
    var body: some View {
        NavigationView {
            HStack {
                if(gameArray.isEmpty){
                    VStack{
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                        Text("Bisher keine Spiele")
                            .padding()
                            .font(.system(size: 20))
                    }
                } else{
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
            }
            .navigationTitle("Cabo-Counter") // Titel der Navigation Bar
            .navigationBarItems(
                trailing:
                NavigationLink(destination: CreateGameView()) {  // Verweis auf die Ziel-View
                    Image(systemName: "plus")  // Bild oder Text für den Button
                }
            )
        }
    }
}

#Preview {
    MainMenu()
}


