<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Create Restaurant</title>
</head>
<body>
    
    <h1>Create Restaurant</h1>
    <form id="restaurant-form">
      <label for="name">Restaurant name:</label>
      <input type="text" id="name" name="name"><br><br>
    
      <fieldset>
        <legend>Menu:</legend>
        <div id="menu-items">
          <div class="menu-item">
            <label for="meal-name-1">Meal name:</label>
            <input type="text" id="meal-name-1" name="meal-name[]" required>
    
            <label for="meal-price-1">Price:</label>
            <input type="number" id="meal-price-1" name="meal-price[]" required>
    
            <label for="meal-desc-1">Description:</label>
            <textarea id="meal-desc-1" name="meal-desc[]" required></textarea>
          </div>
        </div>
    
        <button type="button" onclick="addMenuItem()">Add another item</button>
      </fieldset>
    
      <br><br>
      <button type="submit">Create restaurant</button>
    </form>
    
    <script>
      let nextMenuItemId = 2;
    
      function addMenuItem() {
        const menuItemsDiv = document.getElementById("menu-items");
    
        const menuItemDiv = document.createElement("div");
        menuItemDiv.className = "menu-item";
    
        const mealNameLabel = document.createElement("label");
        mealNameLabel.for = `meal-name-${nextMenuItemId}`;
        mealNameLabel.innerText = "Meal name:";
    
        const mealNameInput = document.createElement("input");
        mealNameInput.type = "text";
        mealNameInput.id = `meal-name-${nextMenuItemId}`;
        mealNameInput.name = "meal-name[]";
        mealNameInput.required = true;
    
        const mealPriceLabel = document.createElement("label");
        mealPriceLabel.for = `meal-price-${nextMenuItemId}`;
        mealPriceLabel.innerText = "Price:";
    
        const mealPriceInput = document.createElement("input");
        mealPriceInput.type = "number";
        mealPriceInput.id = `meal-price-${nextMenuItemId}`;
        mealPriceInput.name = "meal-price[]";
        mealPriceInput.required = true;
    
        const mealDescLabel = document.createElement("label");
        mealDescLabel.for = `meal-desc-${nextMenuItemId}`;
        mealDescLabel.innerText = "Description:";
    
        const mealDescTextarea = document.createElement("textarea");
        mealDescTextarea.id = `meal-desc-${nextMenuItemId}`;
        mealDescTextarea.name = "meal-desc[]";
        mealDescTextarea.required = true;
    
        menuItemDiv.appendChild(mealNameLabel);
        menuItemDiv.appendChild(mealNameInput);
        menuItemDiv.appendChild(mealPriceLabel);
        menuItemDiv.appendChild(mealPriceInput);
        menuItemDiv.appendChild(mealDescLabel);
        menuItemDiv.appendChild(mealDescTextarea);
    
        menuItemsDiv.appendChild(menuItemDiv);
    
        nextMenuItemId++;
      }
        document.getElementById("restaurant-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const name = document.getElementById("name").value;

        const menuItems = [];
        const menuItemDivs = document.getElementsByClassName("menu-item");
        for (let i = 0; i < menuItemDivs.length; i++) {
            const mealName = menuItemDivs[i].querySelector("input[name='meal-name[]']").value;
            const mealPrice = menuItemDivs[i].querySelector("input[name='meal-price[]']").value;
            const mealDesc = menuItemDivs[i].querySelector("textarea[name='meal-desc[]']").value;

            const menuItem = {
            name: mealName,
            price: parseFloat(mealPrice),
            description: mealDesc
            };

            menuItems.push(menuItem);
        }
        console.log(menuItems)
        const ownerID = "1"; // replace with actual owner ID
        const url = 'http://localhost:8080/Tools-Akeel/api/owner/createRestaurant/'+ownerID+'/'+name;
        console.log(url)

        const requestBody = JSON.stringify(menuItems);
        console.log(requestBody)
        try {
        const response = await fetch(url, {
         method: 'POST',
         headers: {
            'Content-Type': 'application/json'
         },
         body: requestBody
      });

        if (response.ok) {
            console.log("hello")
        }
        }catch (error) {
          console.log(error);
        }


        // const xhr = new XMLHttpRequest();
        // console.log(xhr)
        // xhr.open("POST", url);
        // xhr.setRequestHeader("Content-Type", "application/json");
        // xhr.onload = function() {
        //     if (xhr.status === 200) {
        //     console.log(xhr.responseText);
        //     }
        // };
        // xhr.send(requestBody); // send the request with the requestBody as the argument
        });


      
    </script>
</body>
</html>