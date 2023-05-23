<!DOCTYPE html>
<html>
  <head>
    <title>Homepage</title>
    <link rel="stylesheet" href="CustomerHM.css">
  </head>
  <body>
    <h1>Welcome, <%= request.getParameter("username") %>!</h1>
    <p>What would you like to do?</p>
    <button onclick="location.href='customerHomePage.jsp'">Create Order</button>
    <button onclick="location.href='Editadditem.jsp'">Add Item </button>
    <button onclick="location.href='hi.jsp'">Remove Item</button>
  </body>
</html>