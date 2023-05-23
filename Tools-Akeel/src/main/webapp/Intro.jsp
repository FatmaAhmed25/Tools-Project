<!DOCTYPE html>
<html>
<head>
  <title>Al-Akeel Food Ordering Platform</title>
  
  <style>
    body {
      background-image: url("photo4.jpg"); /* Add the path to your background image */
      color: #000000;
      background-size: cover;
      background-position: center center;
    }
    
    #header {
      background-color: rgba(255, 255, 255, 0.8);
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
      margin: 50px auto;
      text-align: center;
      max-width: 800px;
    }
    
    #header h1 {
      font-size: 48px;
      margin-bottom: 20px;
    }
    
    #header p {
      font-size: 24px;
      margin-bottom: 40px;
    }
    
    .button {
      background-color: #050306;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3sease;
    }
  </style>
</head>
<body>
    
    <div id="header">
        <h1>Welcome to Al-Akeel Food Ordering Platform</h1>
        <p>Order your favorite meals from the comfort of your own home!</p>
        <p>To get started, please login or create an account:</p>
        <div id="buttons">
            <a href="loginUser.jsp"><button class="button">Login</button></a>
            <a href="signupCustomer.jsp"><button class="button">Create Account</button></a>
            <a href="signupRunner.jsp"><button class= "button">Create Account As Runner</button></a>
        </div>
        <!-- <img src="food.jpg"> Add the path to your photo -->
    </div>
    
</body>
</html>