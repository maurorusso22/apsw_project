package user;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import db.Database;
import db.SQLQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// look for the user: if he exists, redirect him to his 'userhome', otherwise redirect him to 'firstaccess' to book a vaccination
	
	public UserServlet() {
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
		
		String sql = "SELECT * FROM Vac_User WHERE fiscal_code = ? ;";
		List<Object> params = Arrays.asList(fiscalCode);
		SQLQuery query = new SQLQuery(sql, params);

		try {
			Database.execute(query);
		} catch (Exception e) {
			response.sendError(500);
		}
		
		int status = query.getStatus();

		if (status == Database.RESULT) {
			response.sendRedirect("http://localhost:8080/apsw_project/pages/user/userlogin.jsp?fc=" + fiscalCode);
		} else if (status == Database.NORESULT) {
			response.sendRedirect("http://localhost:8080/apsw_project/pages/user/booking.jsp?fc=" + fiscalCode);
		} else {
			response.sendRedirect("http://localhost:8080/apsw_project/pages/error.jsp");
		}
	}

}
