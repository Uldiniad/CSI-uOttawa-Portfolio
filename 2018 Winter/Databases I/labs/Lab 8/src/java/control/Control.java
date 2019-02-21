package java.control;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.connection.DataAccess;
import java.dbbeans.CustomerBean;
import java.dbbeans.LikeArtistBean;
import java.io.IOException;


public class Control extends HttpServlet {
    private DataAccess db;


    private void processAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession s = request.getSession(true);
        String customer_name = (String) request.getParameter("txtName");
        String artist_name = (String) request.getParameter("rdArtist");


        //CUSTOMER
        CustomerBean customerbean = new CustomerBean();


        db = new DataAccess();
        db.openConnection();

        int custid = customerbean.existsCustomer(customer_name, db);

        if (custid == -1) {
            custid = customerbean.insertCustomer(customer_name, db);
        }

        customerbean.setName(customer_name);
        customerbean.setCustid(custid);

        s.setAttribute("customerbean", customerbean);


        //LIKE ARTIST
        LikeArtistBean likeartistbean = new LikeArtistBean();

        if (!likeartistbean.existsLikeArtist(custid, artist_name, db)) {
            likeartistbean.insertLikeArtist(custid, artist_name, db);
        }

        likeartistbean.setDataAccess(db);

        s.setAttribute("likeartistbean", likeartistbean);
        s.setAttribute("dataaccess", db);
        s.setAttribute("db", db);


        ///SESION
        s.setAttribute("key", "000");
        s.setMaxInactiveInterval(1000);


        db.closeConsult();


        RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/menu.jsp");
        rd.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processAction(request, response);
    }


    public void destroy() {
        super.destroy();
    }
}