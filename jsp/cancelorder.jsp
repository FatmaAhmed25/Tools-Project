<!DOCTYPE html>
<html>
<head>
  <title>Cancel Order</title>
  <link rel="stylesheet" href="cancelorder.css">
</head>
<body>
    
    <h1>Cancel Order</h1>
    <form id="cancel-order-form">
      <label for="order-id">Order ID:</label>
      <input type="text" id="order-id" name="order-id"><br><br>
        
      <label for="restaurant-id">Restaurant ID:</label>
      <input type="number" id="restaurant-id" name="restaurant-id"><br><br>
    
      <br><br>
      <button type="submit">Cancel order</button>
    </form>
    
    <script>
      document.getElementById("cancel-order-form").addEventListener("submit", async function(event) {
        event.preventDefault();
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);

        // Get the username and password values from the query parameters
        const username = urlParams.get('username');
        console.log(username)
        const orderId = document.getElementById("order-id").value;
        const restaurantId = document.getElementById("restaurant-id").value;
        
        const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/CUSTOMER';
        const responsePassword=await fetch(getPasswordURL, {
         method: 'GET',
         headers: {
            'Content-Type': 'application/json'},});
        const password = await responsePassword.text(); 

        const url = 'http://localhost:8080/Tools-Akeel/api/customer/cancelOrder/' + orderId + '/' + restaurantId;

        try {
          const response = await fetch(url, {
            method: 'POST',
            headers: {
              'Authorization': 'Basic ' + btoa(username + ':' + password            )
            }
          });

          if(response.ok) {
            const message = await response.text();
            alert(message)
            console.log(message);
          } else {
            console.log(`Error canceling order: ${response.status}`);
          }
        } catch (error) {
          console.log(`Error canceling order: ${error}`);
        }
      });
    </script>
</body>
</html>