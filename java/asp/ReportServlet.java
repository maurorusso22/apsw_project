package asp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Comment;
import org.w3c.dom.Text;

import db.Database;
import db.SQLQuery;

import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;	

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ReportServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// get data from db
		String sql = "SELECT * FROM Vaccination; ";
		
		List<Object> params = Arrays.asList();
		
		SQLQuery query = new SQLQuery(sql, params);

		Database.execute(query);
		
		List<List<String>> vaccinations = query.getResult();
		
		response.setContentType("text/xml; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=\"report.xml\"");
	    
		try {
			DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
	        DocumentBuilder docBuilder = builderFactory.newDocumentBuilder();
	        Document doc = docBuilder.newDocument();
	        doc.setXmlVersion("1.0");
	        
	        Element root = doc.createElement("report");
	        doc.appendChild(root);
	        
	        for (int i = 0; i < vaccinations.size(); i++) {
		        Element vaccination = createVaccinationElement(vaccinations.get(i), doc);
		        root.appendChild(vaccination);
	        }       
	        
	        TransformerFactory factory = TransformerFactory.newInstance();
	        Transformer transformer = factory.newTransformer();
	       
	        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	        
	        // StreamResult result = new StreamResult(System.out);
	        StreamResult result =  new StreamResult(response.getWriter());
	        DOMSource source = new DOMSource(doc);
	        transformer.transform(source, result);
	        	        
		} catch(Exception e) {
			System.out.println(e);
		}
	}
	
	private Element createVaccinationElement(List<String> vaccinationData, Document doc) {
		
        Element vaccination = doc.createElement("vaccination");

        Element id = doc.createElement("id");
        id.appendChild(doc.createTextNode(vaccinationData.get(0)));
        Element user = doc.createElement("user");
        user.appendChild(doc.createTextNode(vaccinationData.get(1)));
        Element doctor = doc.createElement("doctor");
        doctor.appendChild(doc.createTextNode(vaccinationData.get(2)));
        Element product = doc.createElement("product");
        product.appendChild(doc.createTextNode(vaccinationData.get(3)));
        Element date = doc.createElement("date");
        date.appendChild(doc.createTextNode(vaccinationData.get(4)));
        Element dose = doc.createElement("dose");
        dose.appendChild(doc.createTextNode(vaccinationData.get(5)));
        
        vaccination.appendChild(id);
        vaccination.appendChild(user);
        vaccination.appendChild(doctor);
        vaccination.appendChild(product);
        vaccination.appendChild(date);
        vaccination.appendChild(dose);
        
        return vaccination;
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
