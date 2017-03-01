/* Alexandre Billard
 * 6812210
 * Lab 6*/

package src.connection;
import java.sql.*;

public class PostgreSQL2 {

 public static void main(String[] args) {
  try
  {
   Class.forName("org.postgresql.Driver");
   Connection con=DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/{Your Database name}","{Your Database username goes here}","{password goes here}");
   if(con!=null)
    System.out.println("Connected");
   String[] feilds={"aname","birthplace","Germany","Spain"};
   //You can also provide particular field to retrieve in Where Clause.
   Statement st = con.createStatement(); 
   ResultSet rs = st.executeQuery("SELECT "+feilds[0]+","+feilds[1]+" FROM lab.artist where country in('"+feilds[2]+"',"+"'"+feilds[3]+"')"); 
   /*
   while (rs.next()) {
    System.out.print("Column 1 returned: ");
    System.out.println(rs.getString(1));
    System.out.print("Column 2 returned: ");
    System.out.println(rs.getString(2));
    } */
   System.out.println("---------------------------------------");
            System.out.println("| Artist_Name" + " | " + "Artist_Birthplace |");
            while (rs.next()){
                System.out.println("------------------------------------");
                System.out.println("| " + rs.getString(1) + "     | " + rs.getString(2) + "   |");
            }
            System.out.println("-------------------------------------");
    rs.close();
    st.close(); 
  }
  catch(Exception ee)
  {
   ee.printStackTrace();
  }
 }

}
