<!DOCTYPE html>
<style>
    form {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #f5b8ef;
}
label {
  display: inline-block;
  margin-bottom: 5px;
}
input[type="text"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 15px;
  border: 1px solid #f8b7e4;
  border-radius: 5px;
  box-sizing: border-box;
}
input[type="submit"] {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}
input[type="submit"]:hover {
  background-color: #45a049;
}
h1 {
  text-align: center;
  margin-top: 50px;
  margin-bottom: 30px;
}
</style>
<html>

<head>
	<title>Edit Meal Name</title>
</head>
<body>
	<h1>Edit Meal Price</h1>
	<form id="editMealName">
		<label for="mealID">Meal ID:</label>
		<input type="text" id="mealID" name="mealID" required><br>

        <label for="RestaurantID">Restaurant ID:</label>
		<input type="text" id="RestaurantID" name="mealID" required><br>


		<label for="newName">New Price:</label>
		<input type="text" id="newName" name="newName" required><br>

		<input type="submit" value="Save Changes">
	</form>
    <script>
        const queryString = window.location.search;
            const urlParams = new URLSearchParams(queryString);
                // Get the username and password values from the query parameters
            const username = urlParams.get('username');
            console.log(username)
        document.getElementById("editMealName").addEventListener("submit", async function(event) {
		event.preventDefault(); // prevents the default form submission
            
            const getPasswordURL ='http://localhost:8080/Tools-Akeel/api/user/getUserPassword/'+username+'/OWNER';
            const responsePassword=await fetch(getPasswordURL, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'},});
            const password = await responsePassword.text(); 
            console.log(password)
            const mealID = document.getElementById("mealID").value;
            const RestaurantID = document.getElementById("RestaurantID").value;
            const newName = document.getElementById("newName").value;
            const url = 'http://localhost:8080/Tools-Akeel/api/owner/editMealPrice/'+RestaurantID+'/'+mealID+'/'+newName;
        
            try {
            const response = await fetch(url, {
                method: 'PUT',
                headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Basic ' + btoa(username + ':' + password)
                }
            });
            if (response.ok) {
                const output = await response.text();
                alert(output);
            } else {
                alert("Failed to edit meal name");
            }
            } catch (error) {
            console.error(error);
            alert("An error occured");
            }
   
        });
    </script>
</body>
</html>