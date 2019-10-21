package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.M002;
import comm.dhee.dto.T002;
import comm.dhee.util.DBConnection;

@Repository
public class M002Dao {

	public List<M002> selectAllProducts() throws SQLException {
		Connection connection = DBConnection.getConnection();
		List<M002> lm002 = new ArrayList<M002>();

		String sql = "select m00201,m00202,m00203,m00204,m00207 from m002";
		Statement st = connection.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while (rs.next()) {
			M002 m002 = new M002();
			m002.setM00201(rs.getString(1));
			m002.setM00202(rs.getString(2));
			m002.setM00203(rs.getInt(3));
			m002.setM00204(rs.getString(4));
			m002.setM00207(rs.getInt(5));
			lm002.add(m002);
		}

		DBConnection.closeConnection();

		return lm002;
	}

	public List<M002> selectProductByName(String productName) throws SQLException {
		List<M002> lm002 = new ArrayList<M002>();
		Connection connection = DBConnection.getConnection();

		String sql = "select m00201,m00202,m00203,m00204,m00207 from m002 where m00202 like ?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, "%" + productName + "%");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			M002 m002 = new M002();
			m002.setM00201(rs.getString(1));
			m002.setM00202(rs.getString(2));
			m002.setM00203(rs.getInt(3));
			m002.setM00204(rs.getString(4));
			m002.setM00207(rs.getInt(5));
			lm002.add(m002);
		}

		DBConnection.closeConnection();

		return lm002;
	}

	public boolean updateProducts(List<T002> lt002) throws SQLException {
		Connection connection = DBConnection.getConnection();

		String sql = "update m002 set m00207 = m00207-? where m00201 = ?";
		PreparedStatement ps = connection.prepareStatement(sql);
		for (T002 t002 : lt002) {
			int update = 0;
			ps.setInt(1, t002.getT00203());
			ps.setString(2, t002.getT00202());
			update = ps.executeUpdate();
			if (update == 0) {
				DBConnection.closeConnection();
				return false;
			}
		}

		DBConnection.closeConnection();
		return true;
	}
}
