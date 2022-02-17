package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import db.Database;
import db.SQLQuery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/availability")
public class AvailabilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int hourLimit = 4;
	
	public AvailabilityServlet() {
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
		
		PrintWriter out = response.getWriter();
			
		String searchDate = request.getParameter("searchDate");
		
		String startDateTime = searchDate + " 00:00:00";
		String endDateTime = searchDate + " 23:00:00";
				
		String sql = "SELECT * FROM Vaccination WHERE vac_date > ? AND vac_date < ? ;";
		List<Object> params = Arrays.asList(startDateTime, endDateTime);
		SQLQuery query = new SQLQuery(sql, params);

		Database.execute(query);
		
		// if no error on db
		
		List<List<String>> result = query.getResult();
		
		// array that counts how many vaccinations for a determined time
		// index -> hours (0 => 09:00, 1 => 10:00, 2 => 11:00, ... 9 => 18:00)
		int[] counter = new int[10];
		
		for (int i = 0; i < result.size(); i++) {
			String h = result.get(i).get(4).split(" ")[1].split(":")[0];
			switch (h) {
				case "09":
					counter[0]++;
					break;
				case "10":
					counter[1]++;
					break;
				case "11":
					counter[2]++;
					break;
				case "12":
					counter[3]++;
					break;
				case "13":
					counter[4]++;
					break;
				case "14":
					counter[5]++;
					break;
				case "15":
					counter[6]++;
					break;
				case "16":
					counter[7]++;
					break;
				case "17":
					counter[8]++;
					break;
				case "18":
					counter[9]++;
					break;
				default:
					break;
			}
		}
		
		Boolean[] boolArray = new Boolean[10];
		
		for (int j = 0; j < 10; j++) {
			boolArray[j] = counter[j] < hourLimit;
		}
				
		var output = "{\"result\": [" + 
				boolArray[0] + "," + 
				boolArray[1] + "," +
				boolArray[2] + "," +
				boolArray[3] + "," +
				boolArray[4] + "," +
				boolArray[5] + "," +
				boolArray[6] + "," +
				boolArray[7] + "," +
				boolArray[8] + "," +
				boolArray[9] + 
		"]}";
				
		response.setContentType("application/json");
		out.print(output);
	}

}
