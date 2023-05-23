<!DOCTYPE html>
<html>
  <head>
    <title>Restaurant Report</title>
    <link rel="stylesheet" href="customerhomepage.css">
    <style>
      #report {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 30%;
        height: 30%;
        padding: 10px;
        overflow-y: auto;
        background-color: #fff;
        box-shadow: 0px 0px 10px #888888;
      }
    </style>
  </head>
  <body>
    <h1>Restaurant Report</h1>
    
    <form id="report-form">
        <label for="owner-id">Owner ID:</label>
        <input type="text" id="owner-id" name="owner-id"><br><br>

        <button type="submit">Fetch Report</button>
    </form>

    <div id="report"></div>

    <script>
      document.getElementById("report-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const ownerId = document.getElementById("owner-id").value;

        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);


        // Get the username and password values from the query parameters
        const username = urlParams.get('username');

        const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/OWNER';
        const responsePassword=await fetch(getPasswordURL, {
         method: 'GET',
         headers: {
            'Content-Type': 'application/json'},});
        const password = await responsePassword.text();

        
        const url = 'http://localhost:8080/Tools-Akeel/api/owner/getRestaurantReport/'+ownerId;

        try {
      const response = await fetch(url, {
            method: 'GET',
            headers: {
             'Content-Type': 'application/json',
             'Authorization': 'Basic ' + btoa(username + ':' + password)
              }
          });

          if (response.ok) {
            console.log('it works');
            const report = await response.text();
            console.log(report);
            document.getElementById('report').textContent = report;
          } else {
            alert("Failed to fetch restaurant report.");
          }

        } catch (error) {
          console.error(error);
          alert("An error occurred while fetching the restaurant report.");
        }
      });
    </script>
    
  </body>
</html>