package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.T001;
import comm.dhee.util.DBConnection;

@Repository
public class T001Dao {

	public String getOrderId() throws SQLException {
		Connection connection = DBConnection.getConnection();
		String orderId = null;

		String sql = "select lpad(nvl((select max(t00101) from t001),0)+1,5,'0') from dual";
		Statement st = connection.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while (rs.next()) {
			orderId = rs.getString(1);
		}

		DBConnection.closeConnection();
		return orderId;
	}

	public boolean insertOrder(T001 t001) throws SQLException {
		Connection connection = DBConnection.getConnection();
		int insert;

		String sql = "insert into t001(t00101,t00102,t00103,t00105,t00106,t00107) values(?,?,?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, t001.getT00101());
		ps.setDate(2, t001.getT00102());
		ps.setDate(3, t001.getT00103());
		ps.setString(4, t001.getT00105());
		ps.setString(5, t001.getT00106());
		ps.setString(6, t001.getT00107());
		insert = ps.executeUpdate();

		DBConnection.closeConnection();

		if (insert > 0) {
			return true;
		} else {
			return false;
		}
	}

	public T001 selectT001(String t00101) throws SQLException {
		Connection connection = DBConnection.getConnection();
		T001 t001 = new T001();

		String sql = "select t00103,t00105,t00107,t00106 from t001 where t00101=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, t00101);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			t001.setT00103(rs.getDate(1));
			t001.setT00105(rs.getString(2));
			t001.setT00107(rs.getString(3));
			t001.setT00106(rs.getString(4));
		}

		DBConnection.closeConnection();
		return t001;
	}
}
