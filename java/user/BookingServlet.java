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
import jakarta.servlet.http.HttpSession;

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
		
		HttpSession userSession = request.getSession();
		String sessionType = (String) userSession.getAttribute("type");

		if (sessionType != null && sessionType.equals("user")) {
			
			String fiscalCode = (String) userSession.getAttribute("id_user");
					
			String vac_date = request.getParameter("newVacDate");
			int dose_number = Integer.parseInt(request.getParameter("nextDose"));
			String vaccinationId = fiscalCode + "_" + dose_number;
			
			String insertBooking = "INSERT INTO Vaccination VALUES (?, ?, null, null, ?, ?); ";
			List<Object> paramsBooking = Arrays.asList(vaccinationId, fiscalCode, vac_date, dose_number);
			SQLQuery query = new SQLQuery(insertBooking, paramsBooking);
	
			Database.execute(query);
			
			// control if some error happen on db execution. 
		} else {
			response.sendError(408);
		}
	}

}
