<!DOCTYPE html>
<style>
   .container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
}

#order-form button[type="submit"] {
  background-color: #af4ca7;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  margin-top: 30px;
  cursor: pointer;
}

#order-form button[type="submit"]:hover {
  background-color: #a15fb8;
}

h1 {
  text-align: center;
  margin-bottom: 30px;
}

p {
  text-align: center;
  margin-bottom: 50px;
}

button {
  background-color: #db96e7;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  margin-right: 10px;
  cursor: pointer;
}

button:hover {
  background-color: #320528;
}

button:focus {
  outline: none;
}

button:last-child {
  margin-right: 0;

}
    </style>
<html>
<head>
  <title>Get Orders</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>

<body>
  <div class="container">
    
    <div class="container">
      <div>
        <h1>Welcome, <%= request.getParameter("username") %>!</h1>
        <p>What would you like to do?</p>
        
      </div>
      <div id="report"></div>
      <form id="order-form">
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/jsp/mealName.jsp?username='+username">Edit Meal Name</button>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/jsp/mealPrice.jsp?username='+username">Edit Meal Price</button>
        <button onclick="location.href='http://localhost:8080/Tools-Akeel/jsp/viewReport.jsp?username='+username">View Report</button>
        
        <!-- form fields go here -->
        <button type="submit">Show Menu</button>
      </form>
    </div>
    <script>
      // Get the query parameters from the URL
       const queryString = window.location.search;
       const urlParams = new URLSearchParams(queryString);
       const username = urlParams.get('username');
       console.log(username)
      document.getElementById("order-form").addEventListener("submit", async function(event) {
        event.preventDefault();
        // Get the query parameters from the URL
        

        // Use the username and password values as needed
        console.log('Welcome, '+username+"!");
        const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/OWNER';
        const responsePassword=await fetch(getPasswordURL, {
         method: 'GET',
         headers: {
            'Content-Type': 'application/json'},});
        const password = await responsePassword.text();

        const getIDURL ='http://localhost:8080/Tools-Akeel/api/user/getUserID/'+username+'/OWNER';

        const response1=await fetch(getIDURL, {
         method: 'GET',
         headers: {
            'Content-Type': 'application/json'
         },
      });
      const ownerID = await response1.text(); 
      const getResID ='http://localhost:8080/Tools-Akeel/api/owner/getRestaurantByOwner/'+ownerID;
        const responseResID=await fetch(getResID, {
         method: 'GET',
         headers: {
            'Authorization': 'Basic ' + btoa(username + ':' + password)},});

        const resID = await responseResID.text();
        console.log("res" +resID)

        const url = 'http://localhost:8080/Tools-Akeel/api/owner/getRestaurant/'+resID;
        const response = await fetch(url, {
            method: 'GET',
            headers: {
              'Authorization': 'Basic ' + btoa(username + ':' + password)
            }
          });
          const r = await response.text();


          if(response.ok) {
           
            alert(r);
            } else {
              ordersDiv.innerText = "No orders found.";
            }
          } 
        
      );
    </script>
</body>
</html>