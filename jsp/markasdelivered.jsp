<!DOCTYPE html>
<html>
<head>
  <title>Mark Order as Delivered</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>
<body>
    
    <h1>Mark Order as Delivered</h1>
    
    <form id="order-form">
        <label for="order-id">Order ID:</label>
        <input type="text" id="order-id" name="order-id"><br><br>

        <label for="runner-id">Runner ID:</label>
        <input type="text" id="runner-id" name="runner-id"><br><br>

        <button type="submit">Mark as Delivered</button>
    </form>

    <script>
      document.getElementById("order-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const orderId = document.getElementById("order-id").value;
        const runnerId = document.getElementById("runner-id").value;

	    const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        
     
        // Get the username and password values from the query parameters
        const username = urlParams.get('username');
       //const username='yousef';
     //const password='1234';
	  const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/RUNNER';
       const responsePassword=await fetch(getPasswordURL, {
         method: 'GET',
         headers: {
           'Content-Type': 'application/json'},});
        const password = await responsePassword.text();

        const url = 'http://localhost:8080/Tools-Akeel/api/runner/markOrderAsDelivered/'+orderId+'/'+runnerId;

        try {
          const response = await fetch(url, {
            method: 'PUT',
            headers: {
             'Content-Type': 'application/json',
		 'Authorization': 'Basic ' + btoa(username + ':' + password)
		
              }
          });

          if (response.ok) {
            alert("Order marked asdelivered successfully!");
          } else {
            alert("Failed to mark order as delivered.");
          }

        } catch (error) {
          console.error(error);
          alert("An error occurred while marking the order as delivered.");
        }
      });
    </script>
    
</body>
</html>