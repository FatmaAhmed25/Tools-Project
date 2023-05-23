<!DOCTYPE html>
<html>
  <head>
    <title>Homepage</title>
    <link rel="stylesheet" href="customerhm.css">
  </head>
  <body>
    <div class="container">
      <div>
        <h1>Welcome, <%= request.getParameter("username") %>!</h1>
        <p>What would you like to do?</p>
        <button onclick="location.href='customerHomePage.jsp'">Create Order</button>
        <button onclick="location.href='Editadditem.jsp'">Add Item</button>
        <button onclick="location.href='editremoveitem.jsp'">Remove Item</button>
        <button onclick="location.href='cancelorder.jsp'">Cancel Order</button>
      </div>
    </div>
  </body>
</html>