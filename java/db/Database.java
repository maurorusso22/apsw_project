package db;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Database {
	public static final int ISUP_INS = 0;
	public static final int RESULT = 1;
	public static final int NORESULT = 2;
	public static final int ERROR = 3;

	public static void setParams(PreparedStatement statement, List<Object> queryParams) throws SQLException {
		for (var i = 0; i < queryParams.size(); ++i) {
			var param = queryParams.get(i);
			statement.setObject(i + 1, param);
		}
	}

	public static void execute(SQLQuery... queries) {

		try {

			Context context = new InitialContext();
			var ds = (DataSource) context.lookup("java:comp/env/apsw_project/apsw_db");

			try (var connection = ds.getConnection()) {

				for (var i = 0; i < queries.length; i++) {

					PreparedStatement statement;

					statement = connection.prepareStatement(queries[i].getQuery());
					var queryParams = queries[i].getParams();
					setParams(statement, queryParams);

					System.out.println("FULL: " + statement);
					
					statement.execute();
					
					queries[i].setResult(statement.getResultSet());
					System.out.println("RESULT-SET: " + queries[i].getResult());

					statement.close();
				}

			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

	}
}
