var testCards = Deck.allCards

testCards.shuffle()

print("Shuffled card deck:")
print("")
for elem in testCards {
	print(elem)
}