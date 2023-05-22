<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up</title>
  </head>
  <body>
    <form id="signup-form">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username"><br><br>
      <label for="password">Password:</label>
      <input type="password" id="password" name="password"><br><br>
      <label for="role">Role:</label>
      <select id="role" name="role">
        <option value="OWNER">Owner</option>
        <option value="CUSTOMER">Customer</option>
        <option value="RUNNER">Runner</option>
      </select><br><br>
      <button type="submit">Sign Up</button>
    </form>
    <div id="result"></div>
    <script>
      // Get the query parameters from the URL
  const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);

// Get the username and password values from the query parameters
const username = urlParams.get('username');
const password = urlParams.get('password');

// Use the username and password values as needed
console.log(`Welcome, ${username}!`);
      const form = document.getElementById('signup-form');
      form.addEventListener('submit', async (event) => {
        event.preventDefault();
        const username = form.elements.username.value;
        const password = form.elements.password.value;
        const role = form.elements.role.value;
        const data = { username, password,role };
        try {
        const response = await fetch('http://localhost:8080/Tools-Akeel/api/user/signUp',{
          method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
          });
          const result = await response.text();
          console.log(result)
          //const resultObj = JSON.parse(result);
          const resultDiv = document.getElementById('result');
          
          if (result  === "Signed up!") {
            console.log("hiiiiiii")
            window.location.href = 'http://localhost:8080/Tools-Akeel/jsp/ownerHomePage.jsp?username= '+ username +'password='+password; // Redirect to homepage.jsp with query parameters
 // Redirect to homepage.jsp
            resultDiv.textContent = `Welcome, ${username}!`;
          } else {
            resultDiv.textContent = result;
          }
        } catch (error) {
          console.log(error);
        }
    });
    </script>
  </body>
</html>