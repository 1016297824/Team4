package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.M003;
import comm.dhee.util.DBConnection;

@Repository
public class M003Dao {

	public M003 selectM003ByM00301(String m00301) throws SQLException {
		Connection connection = DBConnection.getConnection();

		M003 nM003 = new M003();

		String sql = "select * from M003 where m00301=?";
		PreparedStatement ps = connection.prepareStatement(sql);

		ps.setString(1, m00301);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			//System.out.println(rs.getString(3));
			nM003.setM00301(rs.getString(1));
			nM003.setM00302(rs.getString(2));
			nM003.setM00303(rs.getString(3));
			nM003.setM00304(rs.getString(4));
		}

		DBConnection.closeConnection();

		return nM003;
	}
}
