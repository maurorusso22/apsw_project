package utilities;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtilities {
	private Date date;
	
	private static final String DEFAULT_PATTERN = "yyyy-MM-dd HH:mm:ss";
	
	public DateUtilities() {
		this.date = new Date();
	}
	
	public DateUtilities(String d) {
		DateFormat formatter = new SimpleDateFormat(DEFAULT_PATTERN);
		try {
			Date dd = formatter.parse(d);
			this.date = dd;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Date getDate() {
		return this.date;
	}
	
}