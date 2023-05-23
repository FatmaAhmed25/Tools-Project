<!DOCTYPE html>
<html>
<head>
  <title>Edit Order - Add Item</title>
  <link rel="stylesheet" href="customerhomepage.css">
</head>
<body>
    
    <h1>Edit Order - Add Item</h1>
    <form id="order-form">
      <label for="customer-id">Customer ID:</label>
      <input type="text" id="customer-id" name="customer-id"><br><br>
        
      <label for="order-id">Order ID:</label>
      <input type="text" id="order-id" name="order-id"><br><br>
        
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
      <button type="submit">Add item to order</button>
    </form>
    
    <script>
      let nextItemId = 2;
    
      function addItem() {
        const itemListDiv = document.getElementById("item-list");

        const itemDiv =document.createElement("div");
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
        const orderId = document.getElementById("order-id").value;
        const itemIds = [];
        const itemDivs = document.getElementsByClassName("item");
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
    </script>
  </body>
</html>