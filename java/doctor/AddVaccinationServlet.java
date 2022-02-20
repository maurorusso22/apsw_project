package doctor;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import db.Database;
import db.SQLQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addvac")
public class AddVaccinationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	public AddVaccinationServlet() {
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
		
		HttpSession docSession = request.getSession();
		String sessionType = (String) docSession.getAttribute("type");

		if (sessionType != null && sessionType.equals("doctor")) {
		
			String doctorFiscalCode = (String) docSession.getAttribute("id_doctor");

			String vaccinationId = request.getParameter("vaccinationId").toUpperCase();
			String product = request.getParameter("product");
			
			String update = "UPDATE Vaccination SET id_doctor = ?, product = ?, vac_date = CURRENT_TIMESTAMP() WHERE id_vaccination = ? ";
					
			List<Object> params = Arrays.asList(doctorFiscalCode, product, vaccinationId);
	
			SQLQuery query = new SQLQuery(update, params);
	
			try {
				Database.execute(query);
			} catch (Exception e) {
				response.sendError(500);
			}
			
			int result = query.getUpdateCount();
			
			if (result != 1) {
				response.sendError(404);
			}
					
		} else {
			response.sendError(408);
		}
	}
}
