import SwiftUI

struct GameView: View {
    @State var game: Game // Übergebenes Spiel
    @State var round: Int = 1 // Rundennummer
    @State private var selectedPlayerID: Int? = nil // Aktuell ausgewählter Spieler
    
    // Pop-Up für Punkteingabe
    @State private var showingPointsInput = false
    @State private var playerPoints: [Int: Int] = [:] // Spieler-ID und die eingegebenen Punkte
    
    var body: some View {
        VStack {
            Text("Runde \(round)")
            Text("Wer hat CABO gesagt?")
            
            // Liste der Spieler mit ihren Punkteständen
            List(game.playerArray) { player in
                HStack {
                    Text(player.name)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Punkte: \(player.score)")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(self.selectedPlayerID == player.id ? Color.green.opacity(0.4) : Color.clear) // Markierung des ausgewählten Eintrags
                .cornerRadius(8)
                .onTapGesture {
                    // Wenn der Spieler ausgewählt wird, setzen wir die `selectedPlayerID`
                    if selectedPlayerID == player.id {
                        selectedPlayerID = nil // Wenn der Spieler erneut angeklickt wird, wird die Markierung entfernt
                    } else {
                        selectedPlayerID = player.id
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Button("Runde zuende") {
                showingPointsInput = true
            }
            .padding()
            .background(selectedPlayerID == nil ? Color.gray : Color.blue) // Grau, wenn deaktiviert, Blau wenn aktiviert
            .foregroundColor(.white)
            .cornerRadius(8)
            .opacity(selectedPlayerID == nil ? 0.5 : 1.0) // Wenn deaktiviert, halbtransparent
            .disabled(selectedPlayerID == nil) // Button deaktivieren, wenn kein Spieler ausgewählt ist
        }
        .padding()
        .navigationTitle("Spielansicht")
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingPointsInput) {
            PointsInputView(
                players: game.playerArray,
                playerPoints: $playerPoints,
                onSave: {
                    // Speichert die Punkte, die für die Spieler eingegeben wurden
                    for (playerID, points) in playerPoints {
                        game.addPoints(toPlayerWithID: playerID, points: points)
                    }
                    // Pop-Up schließen
                    showingPointsInput = false
                }
            )
        }
    }
}

#Preview {
    GameView(game:Game())
}
