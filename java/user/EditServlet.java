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

@WebServlet("/edit")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
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
		
		String newDate = request.getParameter("newDate");
		String vacId = request.getParameter("vacId");
		
		String sql = "UPDATE Vaccination SET vac_date = ? WHERE id_vaccination = ? ;";
		List<Object> params = Arrays.asList(newDate, vacId);
		SQLQuery query = new SQLQuery(sql, params);

		Database.execute(query);
		
		// if no error on db
				
	}

}
