import Foundation

class Deck : NSObject
{
    static let allSpades	: [Card] = Value.allValues.map({Card(Color:Color.spades, Value:$0)})
    static let allDiamonds	: [Card] = Value.allValues.map({Card(Color:Color.diamonds, Value:$0)})
    static let allHearts	: [Card] = Value.allValues.map({Card(Color:Color.hearts, Value:$0)})
    static let allClubs		: [Card] = Value.allValues.map({Card(Color:Color.clubs, Value:$0)})
    
    static let allCards		: [Card] = allSpades + allDiamonds + allHearts + allClubs

    var cards: [Card] = allCards
	var discards: [Card] = []
	var outs: [Card] = []

	init(mixed: Bool){
		self.cards = Deck.allCards
		if mixed == false {
			self.cards.shuffle()
		}
	}

	override public var description: String {
		return (self.cards.description)
	}

    func draw() -> Card? {
        var first : Card?
        first = self.cards.first
        self.outs.append(first!)
        self.cards.remove(at:0)
        return first
    }
    
    func fold(c: Card) {
        var index = 0
        for elem in self.outs {
            if c == elem {
                self.discards.append(elem)
                self.outs.remove(at:index)
            }
            index = index + 1
        }
    }
}

extension Array {
	mutating func shuffle() {
		var index = 0
		for i in  0..<self.count {
			index = Int(arc4random_uniform(UInt32(self.count)))
			if i != index {
				self.swapAt(i, index)
			}
		}
	}
}