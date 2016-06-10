package blackjack;

public class program {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("running");
		Deck deck = new Deck();
		deck.init();
		for (int i = 0; i < 200; i++) {
			deck.playerHit();
			deck.playerHit();
			System.out.println(i + ") player " + deck.eval(deck.getPlayerHand()) +
					" " + deck.listCards(deck.getPlayerHand()));
			deck.dealerHit();
			deck.dealerHit();
			deck.dealerPlays();
			System.out.println(i + ") dealer " + deck.eval(deck.getDealerHand()) +
					" " + deck.listCards(deck.getDealerHand()));

			int win = deck.theWinnerIs();
			if (win == 0)
				System.out.println("No Winner");
			if (win == 1)
				System.out.println("Dealer wins");
			if (win == 2)
				System.out.println("Player wins");
			if (deck.eval(deck.getDealerHand()) == 22)
				break;
			if (deck.eval(deck.getPlayerHand()) == 22)
				break;
			deck.cardsBack(deck.getPlayerHand());
			deck.cardsBack(deck.getDealerHand());
			deck.Shuffle();
			
		}
		System.out.println("Wins: "+deck.getWins());
		System.out.println("Loses: "+deck.getLoses());
		System.out.println("Dues: "+deck.getDues());
	}
}