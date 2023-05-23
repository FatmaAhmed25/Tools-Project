<!DOCTYPE html>
<html>
<head>
  <title>Reject Order</title>
  <link rel="stylesheet" href="rejectorder.css">
</head>
<body>
    
    <h1>Reject Order</h1>
    <form id="reject-order-form">
      <label for="order-id">Order ID:</label>
      <input type="text" id="order-id" name="order-id"><br><br>
        
      <label for="runner-id">Runner ID:</label>
      <input type="number" id="runner-id" name="runner-id"><br><br>
      
      <br><br>
      <button type="submit">Reject order</button>
    </form>
    
    <script>
      document.getElementById("reject-order-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const orderId = document.getElementById("order-id").value;
        const params = new URLSearchParams(window.location.search);
        const runnerId = params.get("runnerId");
        document.getElementById("runner-id").value = runnerId;
        //const username='yousef';
        //const password='1234';
        const username = urlParams.get('username');
       //const username='yousef';
     //const password='1234';
	  const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/RUNNER';
       const responsePassword=await fetch(getPasswordURL, {
         method: 'GET',
         headers: {
           'Content-Type': 'application/json'},});
        const password = await responsePassword.text();

        const url = 'http://localhost:8080/Tools-Akeel/api/runner/rejectOrder/'+orderId+'/'+runnerId;

        try {
          const response = await fetch(url, {
            method: 'PUT',
            headers: {
              'Authorization': 'Basic ' + btoa(username + ':' + password)
            }
          });

          if(response.ok) {
            console.log(`Order ${orderId} rejected by runner ${runnerId}`);
            window.location.href = "orderrejected.jsp";
          } else {
            console.log(`Error rejecting order: ${response.status}`);
          }
        } catch (error) {
          console.log(`Error rejecting order: ${error}`);
        }
      });
    
    
    </script>
</body>
</html>