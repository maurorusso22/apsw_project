package user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;

import db.Database;
import db.SQLQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utilities.HashedPassword;
import utilities.RandomString8;

@WebServlet("/book")
public class BookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public BookingServlet() {
		super();
	}


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String fiscalCode = request.getParameter("fiscalCode").toUpperCase();
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String city = request.getParameter("city");
		String birthdate = request.getParameter("birthdate");
		int gender = Integer.parseInt(request.getParameter("gender"));
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String category = request.getParameter("category");

		String vac_date = request.getParameter("vac_date");
		int dose_number = Integer.parseInt(request.getParameter("dose"));
		
		RandomString8 randomString = new RandomString8(8);
		String password = randomString.getRandomString().toUpperCase();
		HashedPassword hashPsw = null;
		try {
			hashPsw = new HashedPassword(password);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String hashedPassword = hashPsw.getHashedPassword();
		
		System.out.println(password);
		System.out.println(hashedPassword);
		
		String insertUser = "INSERT INTO Vac_User VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?); ";
		String insertBooking = "INSERT INTO Vaccination VALUES (UUID(), ?, null, null, ?, ?); ";
		String insertCredentials = "INSERT INTO User_Credentials VALUES(?, ?); ";
				
		List<Object> paramsUser = Arrays.asList(fiscalCode, name, surname, city, birthdate, gender, email, phone, category);
		List<Object> paramsBooking = Arrays.asList(fiscalCode, vac_date, dose_number);
		List<Object> paramsCredentials = Arrays.asList(fiscalCode, hashedPassword);

		SQLQuery query1 = new SQLQuery(insertUser, paramsUser);
		SQLQuery query2 = new SQLQuery(insertBooking, paramsBooking);
		SQLQuery query3 = new SQLQuery(insertCredentials, paramsCredentials);

		Database.execute(query1, query2, query3);
		
		// control if some error happen on db execution. DO ONLY ONE QUERY
		
	    System.out.println("ALL RIGHT!");
		
		response.sendRedirect("http://localhost:8080/apsw_project/pages/user/userhome.jsp?fc=" + fiscalCode);
	}

}
