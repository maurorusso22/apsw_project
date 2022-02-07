package asp;

import java.io.IOException;
import java.io.PrintWriter;
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
import jakarta.servlet.http.HttpSession;
import utilities.HashedPassword;
import utilities.RandomString8;

@WebServlet("/newdoctor")
public class NewDoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public NewDoctorServlet() {
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
		
		HttpSession aspSession = request.getSession();
		String sessionType = (String) aspSession.getAttribute("type");

		if (sessionType != null && sessionType.equals("asp")) {
		
			PrintWriter out = response.getWriter();
			
			String aspName = (String) aspSession.getAttribute("id_asp");
					
			String name = request.getParameter("name");
			String surname = request.getParameter("surname");
			String birthdate = request.getParameter("birthdate");
			String fiscalCode = request.getParameter("fiscalCode").toUpperCase();
			
			RandomString8 randomString = new RandomString8(8);
			String password = randomString.getRandomString().toUpperCase();
			HashedPassword hashPsw = null;
			try {
				hashPsw = new HashedPassword(password);
			} catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			String hashedPassword = hashPsw.getHashedPassword();
	
			String insertNewDoctor = "INSERT INTO Doctor VALUES (?, ?, ?, ?, ?); ";
			String insertNewDocCredentials = "INSERT INTO Doctor_Credentials VALUES (?, ?); ";
			
			List<Object> paramsDoctor = Arrays.asList(fiscalCode, name, surname, birthdate, aspName);
			List<Object> paramsCredentials = Arrays.asList(fiscalCode, hashedPassword);
			
			SQLQuery query1 = new SQLQuery(insertNewDoctor, paramsDoctor);
			SQLQuery query2 = new SQLQuery(insertNewDocCredentials, paramsCredentials);
	
			Database.execute(query1, query2);
			
			// if no error on db
					
			var output = "{\"doc_password\": \"" + password + "\", \"success\": \"" + true + "\"}";
			response.setContentType("application/json");
			out.print(output);
		} else {
			response.sendError(408);
		}
	}

}
