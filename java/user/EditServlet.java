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

@WebServlet("/edit")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// edit the date of a booked vaccination

	public EditServlet() {
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
		
			String newDate = request.getParameter("newDate");
			String newTime = request.getParameter("editVacTime");
			String vacId = request.getParameter("vacId");
			
			String newDateTime = newDate + " " + newTime;
			
			String sql = "UPDATE Vaccination SET vac_date = ? WHERE id_vaccination = ? AND id_user = ? ;";
			List<Object> params = Arrays.asList(newDateTime, vacId, fiscalCode);
			SQLQuery query = new SQLQuery(sql, params);
	
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
