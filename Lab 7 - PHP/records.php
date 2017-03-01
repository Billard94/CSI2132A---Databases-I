<!-- Alexandre Billard -->
<!-- 6812210
Lab 7 -->

<!DOCTYPE html>
<html>
<head>
  <title>Student Database</title>
</head>
<?php
  session_start();

  if(!isset($_SESSION['studentnum'])) {
    echo "Please" . " <a href='index.php'>Login</a>";
    exit;
  }

  $conn_string = "host=web0.site.uottawa.ca port=15432 dbname=dbname user=username password=password";

  $dbconn = pg_connect($conn_string);

  if(!$dbconn){
    die("Error in connection: " . pg_last_error());
  }

  $studentnum = $_SESSION['studentnum'];

  $sql = "SELECT c.course, g.year, g.sec, g.grade
          FROM php_project.student s, php_project.grades g,
          php_project.courses c
          WHERE s.student_num = g.student_num AND g.course_Num = c.course_num AND s.student_num = $1";

  $stmt = pg_prepare($dbconn, "ps", $sql);
  $result = pg_execute($dbconn, "ps", array($studentnum));

  if (!$result) {
    die("Error in SQL query: " . pg_last_error());
  }

  // pg_free_result($result);
  // pg_close($dbconn);
?>
<body>
  <div id="header">Student Record Details</div>
  <table>
    <tr>
      <th>Course</th>
      <th>Year</th>
      <th>Session</th>
      <th>Grade</th>
    </tr>
    <?php while($row = pg_fetch_array($result)) { ?>
      <tr>
        <td><?php echo $row[0]; ?></td>
        <td><?php echo $row[1]; ?></td>
        <td><?php echo $row[2]; ?></td>
        <td><?php echo $row[3]; ?></td>
      </tr>
      <?php }?>
  </table>
  <br/>
  <?php
    pg_free_result($result);
    pg_close($dbconn);
  ?>
</body>
</html>
