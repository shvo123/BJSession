package blackjack;

import java.util.ArrayList;
import java.util.Collections;

public class Deck {
	final static String signs[] = { "clubs", "diamonds", "hearts", "spades" };
	final static String vals[] = { "ace_of_", "2_of_", "3_of_", "4_of_", "5_of_", "6_of_", "7_of_", "8_of_", "9_of_",
			"10_of_", "jack_of_", "queen_of_", "king_of_" };

	public String getName(int id) {
		int val = getVal(id);
		int Shape = getShape(id);
		return vals[val - 1] + signs[Shape - 1] + ".png";
	}

	private ArrayList<Integer> deck = new ArrayList<Integer>();
	private ArrayList<Integer> dealerHand = new ArrayList<Integer>();
	private ArrayList<Integer> playerHand = new ArrayList<Integer>();
	private int wins = 0;
	private int loses = 0;
	private int dues = 0;

	public Deck() {
	}

	public void init() {
		if (deck.size() <= 0) {
			for (int i = 1; i <= 52; i++) {
				deck.add(i);
			}
		} else {
			if (playerHand.size() > 0)
				cardsBack(playerHand);
			if (dealerHand.size() > 0)
				cardsBack(dealerHand);
		}
		Shuffle();

	}

	public int getWins() {
		return wins;
	}

	public int getLoses() {
		return loses;
	}

	public int getDues() {
		return dues;
	}

	public ArrayList<Integer> getDeck() {
		return deck;
	}

	public void playerHit() {
		int card = deck.get(deck.size() - 1);
		deck.remove(deck.size() - 1);
		playerHand.add(card);
		return;
	}

	public void dealerHit() {
		int card = deck.get(deck.size() - 1);
		deck.remove(deck.size() - 1);
		dealerHand.add(card);
		return;
	}

	public void dealerPlays() {
		while (eval(dealerHand) != 0 && eval(dealerHand) < 17)
			dealerHit();

		return;
	}

	public ArrayList<Integer> getPlayerHand() {
		return playerHand;
	}

	public ArrayList<Integer> getDealerHand() {
		return dealerHand;
	}

	public static String[] getSigns() {
		return signs;
	}

	public static String[] getVals() {
		return vals;
	}

	public void cardsBack(ArrayList<Integer> hand) {
		ArrayList<Integer> pCards = hand;

		for (int i = 0; i < pCards.size(); i++) {
			deck.add(pCards.get(i));
		}
		pCards.clear();
	}

	public void Shuffle() {
		Collections.shuffle(deck);
	}

	public int eval(ArrayList<Integer> hand) {
		int sum = 0;
		int aces = 0;

		for (int cr : hand) {
			int val = getVal(cr);
			int rval;

			switch (val) {
			case 1:
				rval = 0;
				aces++;
				break;
			case 11:
			case 12:
			case 13:
				rval = 10;
				break;
			default:
				rval = val;
			}
			sum += rval;
		}
		if ((sum + aces) > 21)
			return 0; // busted
		if (hand.size() == 2 && aces == 1 && (getVal(hand.get(0)) == 11 || getVal(hand.get(1)) == 11))
			return 22;// natural BlackJack
		if (aces == 0)
			return sum;
		// find best combination
		int best = sum + aces;
		for (int i = 0; i < aces && best != 21; i++) {
			if ((best + 9) > 21)
				return best;
			best += 9;
		}
		return best;
	}

	public int theWinnerIs() {
		int dl = eval(dealerHand);
		int pl = eval(playerHand);
		if (dl == 0)
		{
			wins++;
			return 2; // dealer busted
		}
		if (pl == 0)
		{
			loses++;
			return 1; // player busted
		}
		if (dl == pl)
		{
			dues++;
			return 0;
		}
		if (dl > pl)
		{
			loses++;
			return 1;
		}
		wins++;
		return 2;
	}

	public int getVal(int id) {
		return ((id - 1) / 4) + 1;
	}

	public int getShape(int id) {
		return ((id - 1) % 4) + 1;
	}

	public String listCards(ArrayList<Integer> hand) {
		String result = "";
		for (int i = 0; i < hand.size(); i++) {
			result = result + getName(hand.get(i));
			if (i < (hand.size() - 1))
				result = result + ", ";
		}
		return result;
	}
}
