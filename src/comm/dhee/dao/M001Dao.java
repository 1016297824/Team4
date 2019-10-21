package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.M001;
import comm.dhee.util.DBConnection;

@Repository
public class M001Dao {

	public List<M001> getAllCustomers() throws SQLException {
		Connection connection = DBConnection.getConnection();

		String sql = "select m00101,m00103,m00110,m00105 from m001";
		Statement st = connection.createStatement();

		List<M001> lm001 = new ArrayList<M001>();

		ResultSet rs = st.executeQuery(sql);
		while (rs.next()) {
			M001 m001 = new M001();
			m001.setM00101(rs.getString(1));
			m001.setM00103(rs.getString(2));
			m001.setM00110(rs.getInt(3));
			m001.setM00105(rs.getString(4));
			lm001.add(m001);
		}

		DBConnection.closeConnection();

		return lm001;
	}

	public List<M001> selectCustomersByName(String cname) throws SQLException {

		Connection connection = DBConnection.getConnection();

		String sql = "select m00101,m00103,m00110,m00105 from m001 where m00103 like ?";

		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, "%" + cname + "%");

		ResultSet rs = ps.executeQuery();

		List<M001> lm001 = new ArrayList<M001>();
		while (rs.next()) {
			M001 m001 = new M001();
			m001.setM00101(rs.getString(1));
			m001.setM00103(rs.getString(2));
			m001.setM00110(rs.getInt(3));
			m001.setM00105(rs.getString(4));
			lm001.add(m001);
		}

		DBConnection.closeConnection();

		return lm001;
	}

	public M001 selectCustomerById(String id) throws SQLException {

		Connection connection = DBConnection.getConnection();

		String sql = "select m00101,m00103,m00110,m00105 from m001 where m00101=?";

		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();

		M001 m001 = new M001();
		while (rs.next()) {
			m001.setM00101(rs.getString(1));
			m001.setM00103(rs.getString(2));
			m001.setM00110(rs.getInt(3));
			m001.setM00105(rs.getString(4));
		}

		DBConnection.closeConnection();

		return m001;
	}

	public M001 selectExcelCustomerById(String id) throws SQLException {

		Connection connection = DBConnection.getConnection();

		String sql = "select m00101,m00103,m00110,m00105,m00106,m00107,m00108 from m001 where m00101=?";

		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();

		M001 m001 = new M001();
		while (rs.next()) {
			m001.setM00101(rs.getString(1));
			m001.setM00103(rs.getString(2));
			m001.setM00110(rs.getInt(3));
			m001.setM00105(rs.getString(4));
			m001.setM00106(rs.getString(5));
			m001.setM00107(rs.getString(6));
			m001.setM00108(rs.getString(7));
		}

		DBConnection.closeConnection();

		return m001;
	}
}
