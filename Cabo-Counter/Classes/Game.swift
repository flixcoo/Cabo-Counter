import Foundation

class Game : Identifiable, Hashable, ObservableObject {
    let formatter = DateFormatter() // Formatting of
    
    private var _date: String
    var date: String {
        get { _date }
        set { _date = newValue }
    }
        
    private var _time: String
    var time: String {
        get { _time }
        set { _time = newValue }
    }
    
    private var _name: String = ""
    var name: String {
        get { _name }
        set { _name = newValue }
    }
    
    private var _id: String
    var id: String {
        get { _id }
        set { _id = newValue }
    }
    
    @Published private var _playerAmount: Int = 0
    var playerAmount: Int {
        get { _playerAmount }
    }
        
    @Published private var _winner: String = "Peter"
    var winner: String {
        get { _winner }
        set { _winner = newValue }
    }
    
    @Published var playerArray = [Player]() // Spieler werden hier als `@Published` gespeichert.

    init(){
        formatter.dateFormat = "yyyy-MM-dd"
        _date = formatter.string(from: Date())
                
        formatter.dateFormat = "HH-mm-ss"
        _time = formatter.string(from: Date())
        
        _id = _date + "_" + _time + "_" + String(Int.random(in: 1..<100))
        
        print("New Game created\nid: \(id)\nDate: \(date)\nTime: \(time)\n")
    }
    
    func createPlayer(playerName: String) -> Player {
        let player = Player(id: _playerAmount, name: playerName)
        return player
    }
    
    func addPlayerToGame(playerName: String){
        let player = createPlayer(playerName: playerName)
        playerArray.append(player)
        _playerAmount = playerArray.count
        print("Added Player to Game!\nName: \(player.name)\nID: \(player.id)\n")
    }
    
    // Funktion zum Hinzufügen der Punkte
    func addPoints(toPlayerWithID playerID: Int, points: Int) {
        if let player = playerArray.first(where: { $0.id == playerID }) {
            player.incrementScore(by: points) // Punkte hinzufügen
            print("Added \(points) points to \(player.name). Total score: \(player.score)")
        } else {
            print("Player not found.")
        }
    }
    
    func getDateInNormalFormat() -> String{
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter.string(from:Date())
    }
    
    // Hashable implementation
    static func ==(lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)  // Use the unique `id` for hashing
    }
}
