<!DOCTYPE html>
<html>
<!-- Alexandre Billard -->
<!-- 6812210
Lab 7 -->
<head>
  <title>Student Database</title>
</head>
  <?php
    error_reporting(E_ALL);
    session_start();

    if (array_key_exists('login', $_POST)) {
      $studentnum = $_POST['studentnum'];
      $password = $_POST['userPassword'];

      $conn_string = "host=web0.site.uottawa.ca port=15432 dbname=dbname user=username password=password";

      $dbconn = pg_connect($conn_string) or die('Connection failed');

      $query = "SELECT * FROM php_project.student WHERE student_num = $1 AND student_pass = $2";

      $stmt = pg_prepare($dbconn, "ps", $query);
      $result = pg_execute($dbconn, "ps", array($studentnum, $password));

      if (!$result) {
        die("Error in SQL query" . pg_last_error());
      }

      $row_count = pg_num_rows($result);

      if($row_count > 0){
        $_SESSION['studentnum'] = $studentnum;
        header("location: http://localhost/students/records.php");
        exit;
      }

      echo "Data Succesfully Entered " . "<a href='index.php'>login now</a>";

      pg_free_result($result);
      pg_close($dbconn);

    }
  ?>
<body>
    <div id="header">USER LOGIN FORM</div>
    <form method="POST" action="">
      <p>Student #: <input type="text" name="studentnum" id="studentnum"/></p>
      <p>Password #: <input type="password" name="userPassword" id="userPassword"/></p>
      <p><input type="submit" value="Login" name="login" id="login"/></p>
    </form>

    <a href="register.php">Register</a>
</body>
</html>
