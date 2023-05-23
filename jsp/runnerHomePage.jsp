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
        <button onclick="location.href='getorder.jsp'">Get Order</button>
       
      </div>
    </div>
  </body>
</html>
