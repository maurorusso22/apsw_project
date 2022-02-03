package user;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ulogin")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 2L;
	
	public LoginServlet() {
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
		String fiscalCode = request.getParameter("fiscalCode");
		String password = request.getParameter("password");
		
		log(fiscalCode);

		// db search
				
		var output = "{\"result\": \"" + password.endsWith("ciao") + "\", \"fiscalCode\": \"" + fiscalCode + "\"}";
		response.setContentType("application/json");
		out.print(output);
	}
}
