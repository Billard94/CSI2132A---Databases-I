<!-- Alexandre Billard -->
<!-- 6812210
Lab 7 -->

<!DOCTYPE html>
<html>
<head>
  <title>Student Database</title>
</head>
<?php
  if (array_key_exists('save', $_POST)) {
    $studentnum = $_POST['istudentnum'];
    $lastname = $_POST['ilastname'];
    $firstname = $_POST['ifirstname'];
    $password = $_POST['ipassword'];
    $street = $_POST['istreet'];
    $city = $_POST['icity'];
    $gender = $_POST['igender'];
    $email = $_POST['iemail'];

    $conn_string = "host=web0.site.uottawa.ca port=15432 dbname=dbname user=username password=password";

    $dbconn = pg_connect($conn_string) or die("Connection failed");

    $query = "INSERT INTO php_project.student(student_num, last_name, first_name, student_pass, street, city, gender, email) VALUES ('$studentnum', '$lastname', '$firstname', '$password', '$street', '$city', '$gender', '$email')";

    $result = pg_query($dbconn, $query);

    if(!$result){
      die("Error in SQL query: " . pg_last_error());
    }

    echo "Data Succesfully Entered " . "<a href='index.php'>login now</a>";

    pg_free_result($result);
    pg_close($dbconn);
  }
?>
  <body>

    <div id="header">USER REGISTRATION FORM</div>
    <form id="testform" name="testform" method="post" action="">
      <p>
        <label for="istudentnum">Student #: </label>
        <input name="istudentnum" type="text" id="repno"/>
      </p>
      <p>
        <label for="ilastname">Last Name: </label>
        <input type="text" name="ilastname" id="ilastname">
      </p>
      <p>
        <label for="ifirstname">First Name: </label>
        <input type="text" name="ifirstname" id="ifirstname">
      </p>
      <p>
        <label for="ipassword">Password: </label>
        <input type="password" name="ipassword" id="ipassword">
      </p>
      <p>
        <label for="iconfpass">Confirm Password: </label>
        <input type="password" name="iconfpass" id="iconfpass">
      </p>
      <p>
        <label for="istreet">Street: </label>
        <input type="text" name="istreet" id="istreet">
      </p>
      <p>
        <label for="icity">City: </label>
        <input type="text" name="icity" id="icity">
      </p>
      <p>
        <label for="igender">Gender: </label>
        <select name="igender">
          <option value="male">Male</option>
          <option value="female">Female</option>
        </select>
      </p>
      <p>
        <label for="iemail">Email: </label>
        <input type="text" name="iemail" id="iemail">
      </p>
      <p>
        <input type="submit" name="save" value="Register">
      </p>
    </form>
  </body>
</html>
