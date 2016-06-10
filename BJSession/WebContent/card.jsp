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

<title>Black Jack - playing...</title>
</head>

<body>
	<h2 align="center">Playing....</h2>
	<%
		Deck ddeck = null;

		Object sessionDeck = session.getAttribute("Deck");
		if (sessionDeck != null)
			ddeck = (Deck) sessionDeck;
		else
			response.sendRedirect("play.jsp");

		ArrayList<Integer> deck = ddeck.getDeck();
		ddeck.playerHit();
		// after changing hand time to update the Session 
		session.setAttribute("Deck", ddeck);
		ArrayList<Integer> pl = ddeck.getPlayerHand();
		
		
		int status = ddeck.eval(pl);
		if (status == 0) // busted
		{
			response.sendRedirect("stand.jsp");
		}
		out.println("<ul>");
		for (int i = 0; i < pl.size(); i++) {
			out.println("<li><img alt=\"ERROR\" src=\"images/" + ddeck.getName(pl.get(i))
					+ "\" width=120 height=174 border=3></li>");
		}

		out.println("</ul>");
		out.println("<h2 align=\"center\">Dealer's hand</h2><ul>");
		ArrayList<Integer> dl = ddeck.getDealerHand();
		for (int i = 0; i < dl.size(); i++) {
			if (i < (dl.size() - 1))
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