import SwiftUI

struct PointsInputView: View {
    var players: [Player]
    @Binding var playerPoints: [Int: Int]
    var onSave: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Punkte für die Spieler eingeben:")
                    .font(.headline)
                    .padding()
                
                List(players) { player in
                    HStack {
                        Text(player.name)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // Eingabefeld für die Punkte des Spielers
                        TextField("Punkte", value: Binding(
                            get: { playerPoints[player.id] ?? 0 }, // Zeigt den aktuellen Wert oder 0, wenn kein Wert vorhanden ist
                            set: { newValue in
                                playerPoints[player.id] = newValue // Speichert den neuen Wert in playerPoints
                            }
                        ), format: .number)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    }
                }
                
                // Button zum Speichern der eingegebenen Punkte
                Button("Punkte speichern") {
                    onSave() // Call the onSave closure to handle the point saving
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.top, 10)
            }
            .padding()
            .navigationTitle("Punkte Eingeben")
            .navigationBarItems(trailing: Button("Abbrechen") {
                // Pop-up schließen ohne die Punkte zu speichern
                playerPoints = [:]
            })
        }
    }
}
