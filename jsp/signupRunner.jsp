<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="signuprunner.css">
  </head>
  <body>
    <form id="signup-form">
      <h2>SIGNUP RUNNER</h2>
      <label for="username">Username:</label>
      <input type="text" id="username" name="username"><br><br>
      <label for="password">Password:</label>
      <input type="password" id="password" name="password"><br><br>
      
      <label for="fees">Delivery Fees:</label>
      <input type="text" id="fees" name="fees"><br><br>
      </div>
      <button type="submit">Sign Up</button>
    </form>
    <div id="result"></div>
    <script>
    const form = document.getElementById('signup-form');
    const runnerFields = document.getElementById('runner-fields');
    form.addEventListener('submit', async (event) => {
    event.preventDefault();
      const username = form.elements.username.value;
      const password = form.elements.password.value;
      const role = "RUNNER";
      const fees= form.elements.fees.value;
      let data = { username, password, role };
      try {
          const response = await fetch('http://localhost:8080/Tools-Akeel/api/user/setUpRunner/'+fees, {
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
            window.location.href = 'http://localhost:8080/Tools-Akeel/jsp/runnerHomePage.jsp?username='+username; // Redirect to homepage.jsp with query parameters
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