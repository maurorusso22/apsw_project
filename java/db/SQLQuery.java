package db;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SQLQuery {
	
	private String query;
	private List<Object> params = new ArrayList<>();
	private int status = -1;
	private List<List<String>> result = new ArrayList<>();
	private String excMessage;

	public SQLQuery(String query, List<Object> params) {
		this.query = query;
		this.params = params;
	}

	public String getQuery() {
		return this.query;
	}

	public List<Object> getParams() {
		return this.params;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int s) {
		this.status = s;
	}

	public List<List<String>> getResult() {
		return this.result;
	}

	public void setResult(ResultSet rs) {
		try {

			// other metadata?
			var columnCount = rs.getMetaData().getColumnCount();

			while (rs.next()) {
				List<String> row = new ArrayList<>();
				for (var i = 0; i < columnCount; i++) {
					row.add(rs.getString(i + 1));
				}
				result.add(row);
			}

			if (result.size() > 0) {
				setStatus(Database.RESULT);
			} else if (result.size() == 0) {
				setStatus(Database.NORESULT);
			}

		} catch (Exception exc) {
			setExcMessage(exc.getMessage());
			setStatus(Database.ERROR);
		}
	}

	public String getExcMessage() {
		return this.excMessage;
	}

	public void setExcMessage(String exc) {
		this.excMessage = exc;
		setStatus(Database.ERROR);
	}
}