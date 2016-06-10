<%@ page language="java" contentType="text/html; charset=windows-1255"
	pageEncoding="windows-1255"%>
<%@ page import="blackjack.Deck"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1255">
<link rel="stylesheet" type="text/css" href="css/style.css">

<title>Black Jack - concluding</title>
</head>

<body>
	<h2 align="center">The winner is....</h2>
	<%
		Deck ddeck = null;

		Object sessionDeck = session.getAttribute("Deck");
		if (sessionDeck != null)
			ddeck = (Deck) sessionDeck;
		else
			response.sendRedirect("play.jsp");

		ArrayList<Integer> deck = ddeck.getDeck();
		ArrayList<Integer> pl = ddeck.getPlayerHand();
		int plr = ddeck.eval(pl);
		if (plr != 0 && plr != 22)
			ddeck.dealerPlays(); // if busted or Black Jack for player, no need for the delaer to play
		int win = ddeck.theWinnerIs();
		String winColor[] = { "green", "red", "blue" };
		String points = "";
		if (plr == 0) {
			points = "color:red;\">Busted ";
		} else {
			if (plr == 22)
				points = "color:black;\"> Black Jack ";
			else
				points = "color:" + winColor[win] + ";\">" + plr + " points ";
		}
		out.println("<div id=\"player\">");
		String msg = "<p style=\"position:absolute;right:20px;font-size:200%;vertical-align:middle;align-content:center;font-size:200%;"
				+ points;
		if (win == 0)
			msg = msg + "Due - Push";
		if (win == 1)
			msg = msg + "Looser";
		if (win == 2)
			msg = msg + "Winner";

		out.println(msg + "</p><ul>");
		for (int i = 0; i < pl.size(); i++) {
			out.println("<li><img alt=\"ERROR\" src=\"images/" + ddeck.getName(pl.get(i))
					+ "\" width=120 height=174 border=3></li>");
		}
		out.println("</ul></div>");

		out.println("<h2 align=\"center\">Dealer's hand</h2>");
		ArrayList<Integer> dl = ddeck.getDealerHand();
		int dlr = ddeck.eval(dl);
		if (dlr == 0) {
			points = "color:red;\">Busted ";
		} else {
			if (dlr == 22)
				points = "color:black;\"> Black Jack ";
			else {
				int mWin = win;
				if (win == 1) {
					mWin = 2;
				} else {
					if (win == 2)
						mWin = 1;
				}
				points = "color:" + winColor[mWin] + ";\">" + dlr + " points ";
			}
		}
		out.println("<div id=\"dealer\">");
		msg = "<p style=\"position:absolute;right:20px;font-size:200%;vertical-align:middle;align-content:center;font-size:200%;"
				+ points;
		if (win == 0)
			msg = msg + "Due - Push";
		if (win == 2)
			msg = msg + "Looser";
		if (win == 1)
			msg = msg + "Winner";

		out.println(msg + "</p>");
		out.println("<ul>");

		for (int i = 0; i < dl.size(); i++) {
			out.println("<li><img alt=\"ERROR\" src=\"images/" + ddeck.getName(dl.get(i))
					+ "\" width=120 height=174 border=3></li>");
		}
		out.println("</ul>");
		out.println("<div id=\"commands\">");
		out.println("<ul style=\"position:absolute;right:20px;list-style:none;padding:1px\">");
		out.println("<li><a style=\"margin:3px;\" href=\"play.jsp\">New Game</a></li>");
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