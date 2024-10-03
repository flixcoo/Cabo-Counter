import SwiftUI

struct GameView: View{
    @State var game: Game //Übergebenes Spiel
    @State var round: Int = 1 //
    @State private var selectedPlayerID: Int? = nil
    
    var body: some View{
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
            
            Button("Runde zuende"){
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
    }
}

#Preview {
    GameView(game:Game())
}
