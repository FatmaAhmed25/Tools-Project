<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Edit Meal Name</title>
  <link rel="stylesheet" href="ownerhomepage.css">
</head>
<body>
    
    <h1>Edit Meal Name</h1>
    
    <%-- Retrieve the meal ID and current name from the request parameters --%>
    <%
        int mealID = Integer.parseInt(request.getParameter("mealID"));
        String mealName = request.getParameter("mealName");
    %>
    
    <form id="edit-meal-form">
      <label for="name">New meal name:</label>
      <input type="text" id="name" name="name" value="<%= mealName %>"><br><br>
    
      <br><br>
      <button type="submit">Save changes</button>
    </form>
    
    <script>
      document.getElementById("edit-meal-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const newMealName = document.getElementById("name").value;

        const ownerID = "1"; // replace with actual owner ID
        const restaurantID = 1; // replace with actual restaurant ID
        const mealID ='<%= mealID %>';

        const url= 'http://localhost:8080/Tools-Akeel/api/editMealName/'+ownerID+'/'+restaurantID+'/'+mealID+'/'+newMealName;

        try {
          const response = await fetch(url, {
            method: 'PUT'
          });

          if (response.ok) {
            console.log("Meal name updated successfully");
            // Optionally, redirect the user to the restaurant menu page
          } else {
            console.log("Failed to update meal name");
          }
        } catch (error) {
          console.log(error);
        }
      });
    </script>
</body>
</html>