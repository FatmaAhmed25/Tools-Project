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

        const orderId = document.getElementById("order-id").value;
        const restaurantId = document.getElementById("restaurant-id").value;
        const username='Sarah';
        const password='1234';

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