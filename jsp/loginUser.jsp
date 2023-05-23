<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Login</title>
    <link rel="stylesheet" href="login.css">
  
  </head>
  <body>
    <form id="login-form">
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
      <button type="submit">Login</button>
    </form>
    <div id="result"></div>
    <script>
      const form = document.getElementById('login-form');
      form.addEventListener('submit', async (event) => {
        event.preventDefault();
        const username = form.elements.username.value;
        const password = form.elements.password.value;
        const role = form.elements.role.value;
        const data = { username, password, role };
        try {
          const response = await fetch('http://localhost:8080/Tools-Akeel/api/user/login', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
          });
          const result = await response.text();
          console.log(result);
          const resultDiv = document.getElementById('result');
          
          if (result.includes('logged in successfully') && role==="CUSTOMER") {
              console.log('Redirecting to: CustomerHM.jsp?username=' + username);
              window.location.href = 'CustomerHM.jsp?username=' + username;
          } 
          else if (result.includes('logged in successfully') && role==="OWNER") {
           
              window.location.href = 'ownerHomePage.jsp?username=' + username;
          }
          else if (result.includes('logged in successfully') && role==="RUNNER") {
        
              window.location.href = 'runnerHomePage.jsp?username=' + username;
          }
          else {
            resultDiv.textContent = result;
          }
        } catch (error) {
          console.log(error);
        }
      });
    </script>
  </body>
</html>