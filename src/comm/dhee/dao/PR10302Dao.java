package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PR10302Dao {
	private Connection conn;

	public PR10302Dao(Connection conn) {
		this.conn = conn;
	}

	public List<Double> getSumList() throws SQLException {

		List<Double> PR10302sumList = new ArrayList<Double>();

		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "select t001.t00105,sum(T00203*T00204) as Sum from T001,T002 where t001.t00101=t002.t00201 group by t001.t00105";
		pst = conn.prepareStatement(sql);

		rs = pst.executeQuery();
		while (rs.next()) {
			PR10302sumList.add(rs.getDouble("Sum"));
		}

		rs.close();
		pst.close();
		return PR10302sumList;
	}

	public List<String> getIdList() throws SQLException {

		List<String> PR10302idList = new ArrayList<String>();

		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "select t001.t00105,sum(T00203*T00204) as Sum from T001,T002 where t001.t00101=t002.t00201 group by t001.t00105";
		pst = conn.prepareStatement(sql);

		rs = pst.executeQuery();
		while (rs.next()) {
			PR10302idList.add(rs.getString(1));
		}

		rs.close();
		pst.close();
		return PR10302idList;
	}
}
