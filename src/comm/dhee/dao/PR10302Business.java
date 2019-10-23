package comm.dhee.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import comm.dhee.util.DBConnection;

public class PR10302Business {
	public List<Double> getDoubleList() throws Exception {

		Connection conn = null;
		PR10302Dao pr10302Dao = null;
		List<Double> dataList = null;

		try {

			conn = DBConnection.getConnection();
			pr10302Dao = new PR10302Dao(conn);

			dataList = pr10302Dao.getSumList();

			// conn.commit();
		} catch (SQLException e) {

			// conn.rollback();
			throw e;
		} finally {
			DBConnection.closeConnection();
		}
		return dataList;
	}

	public List<String> getStringList() throws Exception {

		Connection conn = null;
		PR10302Dao pr10302Dao = null;
		List<String> dataList = null;

		try {

			conn = DBConnection.getConnection();
			pr10302Dao = new PR10302Dao(conn);

			dataList = pr10302Dao.getIdList();

			// conn.commit();
		} catch (SQLException e) {

			// conn.rollback();
			throw e;
		} finally {
			DBConnection.closeConnection();
		}
		return dataList;
	}
}
