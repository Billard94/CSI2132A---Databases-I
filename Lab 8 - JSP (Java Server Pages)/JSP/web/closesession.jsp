<%-- Alexandre Billard
6812210
Lab 8  --%>

<% session = request.getSession(false);

   session.invalidate();
   response.sendRedirect("index.jsp");
%>
