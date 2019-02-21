package dbbeans;

import connection.DataAccess;
import java.sql.*;


public class LikeArtistBean {
    private Connection connection;
    private Statement st;
    private DataAccess dataaccess;
    private ResultSet rs;
    private String likeArtistList="";


    public LikeArtistBean() {
    }

    public void setDataAccess(DataAccess db)
    {
        dataaccess = db;
    }
    
    public boolean existsLikeArtist(int custid, String aname, DataAccess db) {
        boolean exists = false;
        String temp;
        int temp2;
        connection = db.getConnection();

        try{
            st = connection.createStatement();
            rs  = st.executeQuery("SELECT * FROM laboratories.likeartist");
            while (rs.next())
            {
                temp = rs.getString("aname");
                temp2 = rs.getInt("custid");
                temp = temp.trim();
                if (temp.compareTo(aname.trim())==0 && custid == temp2)
                    exists = true;
            }
            rs.close();
            st.close();
            }catch(Exception e){
                System.out.println("Cant read likeartist table");
            }
            return(exists);
    }

     
    public void insertLikeArtist(int custid, String aname, DataAccess db)
    {
        connection = db.getConnection();
        try {
            st = connection.createStatement();
            st.executeUpdate("INSERT INTO laboratories.likeartist "
                            + " (custid,aname) VALUES ("+custid+",'" + aname + "')");
            rs.close();
            st.close();
        }catch(Exception e){
            System.out.println("Cant insert into likeartist");
        }
    }
   

    public String getLikeArtistList()
    {
        connection = dataaccess.getConnection();
        String cname;
        String aname;

        try {
            st = connection.createStatement();
            rs = st.executeQuery("SELECT c.name,la.aname FROM laboratories.customer c, laboratories.likeartist la WHERE c.custid = la.custid");
        } catch(Exception e){
            System.out.println("Cant read likeartist table");
        }
        try{
            while (rs.next())
            {
                cname=rs.getString("name");
                aname=rs.getString("aname");
                likeArtistList+="<tr><tr><td>"
                               + cname
                               + "</td><td>"
                               + aname
                               +"</td></tr>";
            }
        }catch(Exception e){
            System.out.println("Error creating table "+e);
        }
        return likeArtistList;
    }

}
