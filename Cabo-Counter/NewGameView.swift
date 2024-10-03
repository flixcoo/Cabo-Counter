import SwiftUI

struct NewGameView: View {
    @State private var playerNames: [String] = [] // Leeres Array für Spielernamen
    @State private var game = Game() // Dein Game-Objekt

    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .center){
                    TextField("Name des Spiels", text: $game.name)
                    Text("Spieler").font(.largeTitle).padding()
                    
                    // Dynamische Textfelder für Spieler
                    ForEach(playerNames.indices, id: \.self) { index in
                        HStack {
                            // Textfeld für den Spielernamen
                            TextField("Spielername", text: Binding(
                                get: { self.playerNames[index] },
                                set: { self.playerNames[index] = $0 }
                            ))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            
                            // Minus-Button zum Entfernen des Spielers
                            Button(action: {
                                self.removePlayer(at: index) // Spieler entfernen
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                            .padding(.leading, 8)
                        }
                    }
                    
                    // Button zum Hinzufügen eines weiteren Spielers
                    Button(action: {
                        // Füge einen neuen leeren Namen hinzu
                        self.addNewPlayer()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Spieler hinzufügen")
                        }
                    }
                    
                    // Button zum Erstellen des Spiels mit den eingegebenen Namen
                    Button(action: {
                        self.createGame() // Spiel erstellen mit Spielernamen
                        
                    }) {
                        Text("Spiel erstellen")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .frame(maxHeight: .infinity,alignment: .top)
            }
            .navigationTitle("Neues Spiel")
        }
    }
    
    func createGame() {
        for name in playerNames where !name.isEmpty {
            game.addPlayerToGame(playerName: name)
        }
        print("Spiel erstellt mit \(game.playerAmount) Spielern.")
    }

    // Funktion zum Hinzufügen eines neuen Spielers
    func addNewPlayer() {
        DispatchQueue.main.async {
            self.playerNames.append("") // Füge einen neuen leeren Namen hinzu
        }
    }

    // Funktion zum Entfernen eines Spielers
    func removePlayer(at index: Int) {
        DispatchQueue.main.async {
            self.playerNames.remove(at: index) // Entferne den Spieler an der gegebenen Position
        }
    }
}

#Preview {
    NewGameView()
}
