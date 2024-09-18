import Foundation

class Game : Identifiable{
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
    
    private var _name: String
    var name: String {
        get { _name }
        set { _name = newValue }
    }
    
    private var _id: String
    var id: String {
        get { _id }
        set { _id = newValue }
    }
        
    var playerArray = [Player]()
    var playerCount: Int = 0
    var winner: String?
    
    
    init(name : String){
        formatter.dateFormat = "yyyy-MM-dd"
        _date = formatter.string(from: Date())
                
        formatter.dateFormat = "HH-mm-ss"
        _time = formatter.string(from: Date())
        
        _id = _date + "_" + _time + "_" + String(Int.random(in: 1..<100))
        _name = name
        
        
        print("New Game \(name) created\nid: \(id)\nDate: \(date)\nTime: \(time)\n")
    }
    
    func createPlayer(name: String) -> Player{
        return Player(id: playerCount, name: name)
    }
    
    func addPlayerToGame(playerName: String){
        let player = createPlayer(name: playerName)
        playerArray.append(player)
        playerCount = playerArray.count
        print("Added Player to Game!\nName: \(player.name)\nID: \(player.id)\n")
    }
}
