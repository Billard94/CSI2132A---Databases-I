/* Alexandre Billard
 * 6812210
 * Lab 6*/

package src.connection;
import java.sql.*;


public class PostgreSQL1 {

 public PostgreSQL1() {
  // TODO Auto-generated constructor stub
 }

 public static String columnate(String str, int colsize) {
    String blanks = "                           ";
    return blanks.substring(0, colsize-str.length()) + str;
  }
 
 
 public static void main(String[] args) {
  // TODO Auto-generated method stub
  try {
 Class.forName("org.postgresql.Driver");
 //String url="jdbc:postgresql://web0.site.uottawa.ca:15432/jbail036";
 try {
  Connection db=DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/{Your Database name}","{Your Database username goes here}","{password goes here}");
  
   
  Statement st = db.createStatement();
  //if(db!=null)
  //System.out.println("connected");
  ResultSet rs = st.executeQuery("SELECT aname,dateofbirth FROM lab2.artist");
  
  
  System.out.print("Artist-Name "+"\t" +"\t"+ "Dateofbirth"+"\n"+"-------------------------------------"+"\n");
 
  
  
  while (rs.next()) {
  
  System.out.println(columnate(rs.getString(1),12) +"\t"+"\t"+columnate(rs.getString(2),12) );
      
  }
  rs.close();
  st.close(); 
  
 } catch (SQLException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
 }
 
  } catch (ClassNotFoundException e) {
 // TODO Auto-generated catch block
 e.printStackTrace();
}
  
  
 }
 
 

 
 

}
