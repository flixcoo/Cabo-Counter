class Player : Identifiable {
    private var _id: Int
    var id: Int{
        get{ return _id }
        set{ _id = newValue }
    }
    func getID ()-> Int{
        return _id
    }
    
    private var _name: String
    var name: String{
        get{ return _name }
        set{ _name = newValue }
    }
    
    private var _score: Int
    var score: Int{
        get{ return _score }
        set{ _score = newValue }
    }
    
    func incrementScore(by amount: Int) {
        self.score += amount
    }
    
    init(id: Int, name: String) {
        self._id = id
        self._name = name
        self._score = 0;
    }
}
