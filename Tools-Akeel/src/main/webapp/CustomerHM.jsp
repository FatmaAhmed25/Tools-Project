<!DOCTYPE html>
<html>
  <head>
    <title>Homepage</title>
    <link rel="stylesheet" href="CustomerHM.css">
  </head>
  <body>
    <div class="container">
      <div>
        <h1>Welcome, <%= request.getParameter("username") %>!</h1>
        <p>What would you like to do?</p>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/customerHomePage.jsp?username='+username">Create Order</button>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/Editadditem.jsp?username='+username">Add Item</button>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/editremoveitem.jsp?username='+username">Remove Item</button>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/cancelorder.jsp?username='+username">Cancel Order</button>
      </div>
    </div>
    <script>
      // Get the query parameters from the URL
       const queryString = window.location.search;
       const urlParams = new URLSearchParams(queryString);
       const username = urlParams.get('username');
       console.log(username)

    </script>
  </body>
</html>