//Alexandre Billard
//6812210
//Lab 8 
package connection;

import java.sql.*;

public class DataAccess
{

    private Connection connection;
    private Statement st;
    private ResultSet rs;

    public DataAccess()
    {
    }
    
    public Connection getConnection()
    {
        return connection;
    }    
    

    public void openConnection() {
        try
        {
            Password password = new Password();

            Class.forName("org.postgresql.Driver");
            //connection = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/svale054","svale054",password.getPass());
            connection = DriverManager.getConnection("jdbc:postgresql://acadb:5432/svale054","svale054",password.getPass());
            System.out.println("Connection Established");
        }catch(Exception e){
            System.out.println("No connection established: "+e.toString());
        }
    }


    

    public boolean siguiente() {
        try {
            return (rs.next());
        } catch(Exception e){
            System.out.println("Error moving to the next one");
            return false;
        }
    }


    public String getField(String name){
        try {
            return (rs.getString(name));
        } catch(Exception e){
            System.out.println("Error getting the field");
            return "";
        }
    }
    

   public void closeConsult(){
        try {
            rs.close();
            st.close();
        } catch(Exception e){}
    }

    public void closeConnection() {
        try {
            connection.close();
        } catch (Exception e){}
    }
    

   
}

