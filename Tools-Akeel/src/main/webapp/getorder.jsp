<!DOCTYPE html>
<html>
<head>
  <title>Get Orders</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>
<body>

  <h1>Get Orders</h1>
  <form id="order-form">
    <label for="runner-id">Runner ID:</label>
    <input type="text" id="runner-id" name="runner-id"><br><br>

    <button type="submit">Get orders</button>
  </form>

  <div id="orders"></div>
  <button id="button1">Accept Order</button>
  <button id="button2">Reject Order</button>

  <script>
    const ordersDiv = document.getElementById("orders");

    document.getElementById("order-form").addEventListener("submit", async function(event) {
      event.preventDefault();

      const runnerId = document.getElementById("runner-id").value;
      const username='yousef';
      const password='1234';

      const url = 'http://localhost:8080/Tools-Akeel/api/runner/getOrders/'+runnerId;

      try {
        const response = await fetch(url, {
          method: 'GET',
          headers: {
            'Authorization': 'Basic ' + btoa(username +':' + password)
          }
        });

        if(response.ok) {
          const orders = await response.text();
          console.log(orders);
          ordersDiv.innerHTML = "";

          if (orders && orders.trim() !== '') {
            ordersDiv.innerHTML = orders;
          } else {
            ordersDiv.innerHTML = "No orders found";
          }
        } else {
          ordersDiv.innerHTML = "Error retrieving orders";
        }
      } catch(error) {
        console.error(error);
        ordersDiv.innerHTML = "Error retrieving orders";
      }
    });

    const button1 = document.getElementById("button1");
    button1.addEventListener("click", function() {
    const runnerId = document.getElementById("runner-id").value;
    const url = 'acceptorder.jsp?runnerId='+runnerId;
    window.location.href = url;
});

    const button2 = document.getElementById("button2");
    button2.addEventListener("click", function() {
    const runnerId = document.getElementById("runner-id").value;
    const url = 'rejectorder.jsp?runnerId='+runnerId;
    window.location.href = url;
    });
  </script>
</body>
</html>





