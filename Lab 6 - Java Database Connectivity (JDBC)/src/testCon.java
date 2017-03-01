/* Alexandre Billard
 * 6812210
 * Lab 6*/

import java.sql.*;

public class testCon {
 public static void main(String[] args) throws SQLException {
  Connection conn1 = null;
  Statement st = null;
  ResultSet rs = null;
  
  String dbURL2 = "jdbc:postgresql://web0.site.uottawa.ca:15432/abill015";
  String user = "abill015";
  String pass = "Uo6812210";
  conn1 = DriverManager.getConnection(dbURL2, user, pass);
  if (conn1 != null)
  {
   System.out.print("Connected to Database #2");
  }
  st = conn1.createStatement();
  rs = st.executeQuery("SELECT count(*) FROM artist");
  
  while(rs.next())
  {
   System.out.println(rs.getString(1));
  }
  rs.close();
  st.close();
 }
}
