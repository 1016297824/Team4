package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.M002PR10201;
import comm.dhee.dto.M005;
import comm.dhee.util.DBConnection;

@Repository
public class M005Dao {

	public List<M005> selectAllDepartments() throws SQLException {

		Connection connection = DBConnection.getConnection();

		String sql = "select * from m005";
		Statement st = connection.createStatement();
		ResultSet rs = st.executeQuery(sql);

		List<M005> lm005 = new ArrayList<M005>();

		while (rs.next()) {
			M005 m005 = new M005();
			m005.setM00501(rs.getString(1));
			m005.setM00502(rs.getString(2));
			m005.setM00503(rs.getString(3));
			lm005.add(m005);
		}

		DBConnection.closeConnection();

		return lm005;
	}
	
public static List<M002PR10201> searchm005(String m0050) throws SQLException{
		
		
		List<M002PR10201> m002list = new ArrayList<M002PR10201>();
		
		Connection conn = DBConnection.getConnection();
		String sql = "select m00202,m00207 from m002 where m00201 = ?";
		M002PR10201 m002 = new M002PR10201();
		PreparedStatement ps;
		ps = conn.prepareStatement(sql);
//		ps.setString(1, "%" + m0050 +"%");
		ps.setString(1,  m0050);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			m002.setM00202(rs.getString(1));
			m002.setM00207(rs.getString(2));
			m002list.add(m002);			
		}
		DBConnection.closeConnection();	
		return m002list;	
	}
}
