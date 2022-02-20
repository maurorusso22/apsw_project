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
			String vac_time = request.getParameter("newVacTime");
			String vac_date_time = vac_date + " " + vac_time;
			int dose_number = Integer.parseInt(request.getParameter("nextDose"));
			int next_id = Integer.parseInt(request.getParameter("nextId"));
			String vaccinationId = fiscalCode + "_" + next_id;
			
			String insertBooking = "INSERT INTO Vaccination VALUES (?, ?, null, null, ?, ?); ";
			List<Object> paramsBooking = Arrays.asList(vaccinationId, fiscalCode, vac_date_time, dose_number);
			SQLQuery query = new SQLQuery(insertBooking, paramsBooking);
	
			try {
				Database.execute(query);
			} catch (Exception e) {
				response.sendError(500);
			}
		} else {
			response.sendError(408);
		}
	}

}
