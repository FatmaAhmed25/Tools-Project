<!DOCTYPE html>
<html>
<head>
  <title>Edit Order - Add/Remove Item</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>
<body>
    
    <h1>Edit Order- Add/Remove Item</h1>

    <h2>Add Item</h2>
    <form id="add-item-form">
      <label for="customer-id">Customer ID:</label>
      <input type="text" id="customer-id" name="customer-id"><br><br>
        
      <label for="order-id">Order ID:</label>
      <input type="text" id="order-id" name="order-id"><br><br>
        
      <fieldset>
        <legend>Items:</legend>
        <div id="add-item-list">
          <div class="item">
            <label for="add-item-id-1">Item ID:</label>
            <input type="number" id="add-item-id-1" name="item-id[]" required>
          </div>
        </div>
    
        <button type="button" onclick="addItem()">Add another item</button>
      </fieldset>
    
      <br><br>
      <button type="submit">Add item to order</button>
    </form>

    <h2>Remove Item</h2>
    <form id="remove-item-form">
      <label for="customer-id">Customer ID:</label>
      <input type="text" id="customer-id" name="customer-id"><br><br>
        
      <label for="order-id">Order ID:</label>
      <input type="text" id="order-id" name="order-id"><br><br>
        
      <fieldset>
        <legend>Items:</legend>
        <div id="remove-item-list">
          <div class="item">
            <label for="remove-item-id-1">Item ID:</label>
            <input type="number" id="remove-item-id-1" name="item-id[]" required>
          </div>
        </div>
    
        <button type="button" onclick="removeItem()">Remove another item</button>
      </fieldset>
    
      <br><br>
      <button type="submit">Remove item from order</button>
    </form>
    
    <script>
      let nextAddItemId = 2;
      let nextRemoveItemId = 2;
    
      function addItem() {
        const itemListDiv = document.getElementById("add-item-list");

        const itemDiv = document.createElement("div");
        itemDiv.className = "item";
        
        const itemIdLabel = document.createElement("label");
        itemIdLabel.for = `add-item-id-${nextAddItemId}`;
        itemIdLabel.innerText = "Item ID:";
    
        const itemIdInput = document.createElement("input");
        itemIdInput.type = "number";
        itemIdInput.id = `add-item-id-${nextAddItemId}`;
        itemIdInput.name = "item-id[]";
        itemIdInput.required = true;
    
        itemDiv.appendChild(itemIdLabel);
        itemDiv.appendChild(itemIdInput);
    
        itemListDiv.appendChild(itemDiv);
    
        nextAddItemId++;
      }

      function removeItem() {
        const itemListDiv = document.getElementById("remove-item-list");

        const itemDiv = document.createElement("div");
        itemDiv.className = "item";
        
        const itemIdLabel = document.createElement("label");
        itemIdLabel.for = `remove-item-id-${nextRemoveItemId}`;
        itemIdLabel.innerText = "Item ID:";
    
        const itemIdInput = document.createElement("input");
        itemIdInput.type = "number";
        itemIdInput.id = `remove-item-id-${nextRemoveItemId}`;
        itemIdInput.name = "item-id[]";
        itemIdInput.required = true;
    
        itemDiv.appendChild(itemIdLabel);
        itemDiv.appendChild(itemIdInput);
    
        itemListDiv.appendChild(itemDiv);
    
        nextRemoveItemId++;
      }
    
      document.getElementById("add-item-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const customerId = document.getElementById("customer-id").value;
        const orderId = document.getElementById("order-id").value;
        const itemIds = [];
        const itemDivs = document.getElementById("add-item-list").getElementsByClassName("item");
        for (let i = 0; i < itemDivs.length; i++) {
            const itemId = itemDivs[i].querySelector("input[name='item-id[]']").value;
            itemIds.push(parseInt(itemId));
        }

        const url = 'http://localhost:8080/Tools-Akeel/api/customer/editOrderAddItem/'+customerId+'/'+orderId;
        const requestBody = JSON.stringify(itemIds);

        try {
          const response = await fetch(url, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json'
              },
            body: requestBody
          });

          if (response.ok) {
            alert("Item(s) added to order successfully!");
          } else {
            alert("Failed to add item(s) to order.");
          }

        } catch (error) {
          console.error(error);
          alert("An error occurred while adding item(s) to order.");
        }
      });

      document.getElementById("remove-item-form").addEventListener("submit", async function(event) {
        event.preventDefault();

        const customerId = document.getElementById("customer-id").value;
        const orderId = document.getElementById("order-id").value;
        const itemIds = [];
        const itemDivs = document.getElementById("remove-item-list").getElementsByClassName("item");
        for (let i = 0; i < itemDivs.length; i++) {
            const itemId = itemDivs[i].querySelector("input[name='item-id[]']").value;
            itemIds.push(parseInt(itemId));
        }

        const url = 'http://localhost:8080/Tools-Akeel/api/customer/editOrderRemoveItem/'+customerId+'/'+orderId;
        const requestBody = JSON.stringify(itemIds);

        try {
          const response = await fetch(url, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json'
              },
            body: requestBody
          });

          if (response.ok) {
            alert("Item(s) removed from order successfully!");
          } else {
            alert("Failed to remove item(s) from order.");
          }

        } catch (error) {
          console.error(error);
          alert("An error occurred while removing item(s) from order.");
        }
      });
    </script>
    
</body>
</html>