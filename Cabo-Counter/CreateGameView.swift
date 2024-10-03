import SwiftUI

struct CreateGameView: View {
    @State private var playerNames: [String] = [] // Leeres Array für Spielernamen
    @State private var game = Game() // Dein Game-Objekt
    @State private var isGameCreated = false // Flag, um die Navigation zu steuern

    var body: some View {
        NavigationStack{
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
                            .padding()
                        }
                    }
                    
                    // Button zum Erstellen des Spiels mit den eingegebenen Namen
                    Button(action: {
                        self.createGame() // Spiel erstellen mit Spielernamen
                        isGameCreated = true // Setze das Flag auf true, um zur GameView zu navigieren
                   }) {
                    Text("Spiel erstellen")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .opacity(isGameReady() ? 0.5 : 1.0)
                   }
                   .disabled(isGameReady())
                    
                    NavigationLink(
                        destination: GameView(game: game),
                        isActive: $isGameCreated){
                            EmptyView()
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
    
    func isGameReady() -> Bool {
        if(playerNames.count >= 2 &&
           !playerNames[0].isEmpty &&
           !playerNames[1].isEmpty &&
           !game.name.isEmpty){
            return false
        }
        return true
    }
}

#Preview {
    CreateGameView()
}
