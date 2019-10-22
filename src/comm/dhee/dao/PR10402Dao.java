package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PR10402Dao {
	private Connection conn;

	public PR10402Dao(Connection conn) {
		this.conn = conn;
	}

	public List<Double> getSumList() throws SQLException {

		List<Double> PR10402sumList = new ArrayList<Double>();

		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "select t002.t00202,sum(T00203*T00204) as Sum from M002,T002 where m002.m00201=t002.t00202 group by t00202";
		pst = conn.prepareStatement(sql);

		rs = pst.executeQuery();
		while (rs.next()) {
			PR10402sumList.add(rs.getDouble("Sum"));
		}

		rs.close();
		pst.close();
		return PR10402sumList;
	}

	public List<String> getIdList() throws SQLException {

		List<String> PR10402idList = new ArrayList<String>();

		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "select t002.t00202,sum(T00203*T00204) as Sum from M002,T002 where m002.m00201=t002.t00202 group by t00202";
		pst = conn.prepareStatement(sql);

		rs = pst.executeQuery();
		while (rs.next()) {
			PR10402idList.add(rs.getString(1));
		}

		rs.close();
		pst.close();
		return PR10402idList;
	}
}
