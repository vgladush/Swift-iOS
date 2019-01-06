import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    init(Color color: Color, Value value: Value) {
        self.color = color
        self.value = value
        super.init()
    }

    override var description: String {
        return "\(self.value) of \(self.color)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return (self.color == object.color && self.value == object.value)
        }
        return (false)
    }
}

func ==(frst: Card, scnd: Card) -> Bool {
    return (frst.color == scnd.color && frst.value == scnd.value)
}