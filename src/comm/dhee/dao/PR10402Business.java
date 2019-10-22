package comm.dhee.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import comm.dhee.util.DBConnection;

public class PR10402Business {
	public List<Double> getDoubleList() throws Exception {

		Connection conn = null;
		PR10402Dao pr10402Dao = null;
		List<Double> dataList = null;

		try {

			conn = DBConnection.getConnection();
			pr10402Dao = new PR10402Dao(conn);

			dataList = pr10402Dao.getSumList();

			//conn.commit();
		} catch (SQLException e) {

			//conn.rollback();
			throw e;
		} finally {
			DBConnection.closeConnection();
		}
		return dataList;
	}

	public List<String> getStringList() throws Exception {

		Connection conn = null;
		PR10402Dao pr10402Dao = null;
		List<String> dataList = null;

		try {

			conn = DBConnection.getConnection();
			pr10402Dao = new PR10402Dao(conn);

			dataList = pr10402Dao.getIdList();

			//conn.commit();
		} catch (SQLException e) {

			//conn.rollback();
			throw e;
		} finally {
			DBConnection.closeConnection();
		}
		return dataList;
	}
}
