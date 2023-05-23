<!DOCTYPE html>
<html>
<head>
  <title>Create Order</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>
<body>
    
    <h1>Create Order</h1>
    <form id="order-form">
      <label for="customer-id">Customer ID:</label>
      <input type="text" id="customer-id" name="customer-id"><br><br>
        
      <label for="restaurant-id">Restaurant ID:</label>
      <input type="number" id="restaurant-id" name="restaurant-id"><br><br>
        
      <fieldset>
        <legend>Items:</legend>
        <div id="item-list">
          <div class="item">
            <label for="item-id-1">Item ID:</label>
            <input type="number" id="item-id-1" name="item-id[]" required>
          </div>
        </div>
    
        <button type="button" onclick="addItem()">Add another item</button>
      </fieldset>
    
      <br><br>
      <button type="submit">Create order</button>
    </form>
    
    <script>
      let nextItemId = 2;
    
      function addItem() {
        const itemListDiv = document.getElementById("item-list");
    
        const itemDiv = document.createElement("div");
        itemDiv.className = "item";
        
        const itemIdLabel = document.createElement("label");
        itemIdLabel.for = `item-id-${nextItemId}`;
        itemIdLabel.innerText = "Item ID:";
    
        const itemIdInput = document.createElement("input");
        itemIdInput.type = "number";
        itemIdInput.id = `item-id-${nextItemId}`;
        itemIdInput.name = "item-id[]";
        itemIdInput.required = true;
    
        itemDiv.appendChild(itemIdLabel);
        itemDiv.appendChild(itemIdInput);
    
        itemListDiv.appendChild(itemDiv);
    
        nextItemId++;
      }
    
      document.getElementById("order-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const customerId = document.getElementById("customer-id").value;
        const restaurantId = document.getElementById("restaurant-id").value;
        const username='Sarah';
        const password='1234';
        const itemIds = [];
        const itemDivs = document.getElementsByClassName("item");
        for (let i = 0; i < itemDivs.length; i++) {
            const itemId = itemDivs[i].querySelector("input[name='item-id[]']").value;

            itemIds.push(parseInt(itemId));
        }

        const url = 'http://localhost:8080/Tools-Akeel/api/customer/createOrder/' +customerId+'/'+restaurantId;
        const requestBody = JSON.stringify(itemIds);

        try {
          const response = await fetch(url, {
            method: 'POST',
            headers: {
          
              'Content-Type': 'application/json',
              'Authorization': 'Basic ' + btoa(username + ':' + password)
            },
            body: requestBody
          });

          if(response.ok) {
            const orderId = await response.text();
            console.log(`Order created with IDorderId}`);
            console.log(`res created with ID ${restaurantId}`);
            console.log(`cus created with ID ${customerId}`);
          } else {
            console.log('hi');
            console.log(`Error creating order13: ${response.status}`);
          }
        } catch (error) {
          console.log(`Error creating order12: ${error}`);
        }
      });
    </script>
</body>
</html>