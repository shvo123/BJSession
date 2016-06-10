<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<%@ page import="blackjack.Deck"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<link rel="stylesheet" type="text/css" href="css/style.css">

<title>Black Jack - Start</title>
</head>

<body>
	<h2 align="center">Welcome to my Black Jack table</h2>
	<%
		Deck ddeck = null;

		Object sessionDeck = session.getAttribute("Deck");
		if (sessionDeck != null)
			ddeck = (Deck) sessionDeck;
		else {
			ddeck = new Deck();
			session.setAttribute("Deck", ddeck);
		}

		ddeck.init();
		ArrayList<Integer> deck = ddeck.getDeck();
		if (deck.size() <= 0)
			ddeck.init();
		else {
			if (deck.size() < 52) // there are cards
			{
				if (ddeck.getPlayerHand().size() > 0)
					ddeck.cardsBack(ddeck.getPlayerHand());
				if (ddeck.getDealerHand().size() > 0)
					ddeck.cardsBack(ddeck.getDealerHand());
				ddeck.Shuffle();
			}
		}
		// Player got 2 cards XXXXXXXXXXXXXXXX
		ddeck.playerHit();
		ddeck.playerHit();
		session.setAttribute("Deck", ddeck); // hand change save it

		ArrayList<Integer> pl = ddeck.getPlayerHand();
		out.println("<div id=\"player\">");
		int statusp = ddeck.eval(pl);

		out.println("<ul>");
		for (int i = 0; i < pl.size(); i++) {
			out.println("<li><img alt=\"ERROR\" src=\"images/" + ddeck.getName(pl.get(i))
					+ "\" width=120 height=174 border=3></li>");
		}
		out.println("</ul></div>");

		out.println("<h2 align=\"center\">Dealer's hand</h2><ul>");
		// Dealer got 2 cards XXXXXXXXXXXXXXXX
		ddeck.dealerHit();
		ddeck.dealerHit();
		session.setAttribute("Deck", ddeck);

		ArrayList<Integer> dl = ddeck.getDealerHand();
		int status = ddeck.eval(dl);
		if (statusp == 22) // Black Jack of player, conclude game
			response.sendRedirect("stand.jsp");
		for (int i = 0; i < dl.size(); i++) {
			if (i < (dl.size() - 1) || status == 22)
				out.println("<li><img alt=\"ERROR\" src=\"images/" + ddeck.getName(dl.get(i))
						+ "\" width=120 height=174 border=3></li>");
			else
				out.println("<li><img alt=\"ERROR\" src=\"images/Back_1.bmp\" width=120 height=174 border=3></li>");

		}

		out.println("</ul>");
		out.println("<div id=\"commands\">");
		out.println("<ul style=\"position:absolute;right:20px;list-style:none;padding:1px\">");
		out.println("<li><a style=\"margin:3px;\" href=\"card.jsp\">Card</a></li>");
		out.println("<li><a style=\"margin:3px;\" href=\"stand.jsp\">Stand</a></li>");
		out.println("<li><a style=\"margin:3px;\" href=\"http://example.com\">Exit</a></li>");
		out.println("</ul>");
		out.println("<ul id=\"status\" style=\"position:absolute;left:20px;list-style:none;padding:1px;\">");
		out.println("<li style=\"margin:3px;\">Wins: " + ddeck.getWins() + "</li>");
		out.println("<li style=\"margin:3px;\">Loses: " + ddeck.getLoses() + "</li>");
		out.println("<li style=\"margin:3px;\">Dues: " + ddeck.getDues() + "</li>");
		out.println("</ul></div>");
	%>

</body>
</html>