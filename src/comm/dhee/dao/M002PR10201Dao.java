package comm.dhee.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import comm.dhee.dto.M002PR10201;
import comm.dhee.util.DBConnection;

public class M002PR10201Dao {

	public static List<M002PR10201> searchm002() throws SQLException, ServletException, IOException {
		Connection connection = DBConnection.getConnection();
//		String sql = "select m00201,m00202,t00101,t00203,t00203 from M002,T001,T002 where M002.M00201=T002.T00202 and T001.T00101=T002.t00201  and to_char(sysdate,'yy-mm-dd')=to_char(t00103,'yy-mm-dd') and t00104 is null order by m00201";
		/*
		 * String sql1 =
		 * "select sum(t00101) from M002,T001,T002 where M002.M00201=T002.T00202 and T001.T00101=T002.t00201 and to_char(sysdate,'yy-mm-dd')=to_char(t00103,'yy-mm-dd') and t00104 is null order by m00201 group by m00201"
		 * ;
		 */
// 		String sql = "select m00201,m00202,t00101,t00203,sum from H001 where to_char(sysdate,'yy-mm-dd')=to_char(t00103,'yy-mm-dd') order by m00201";
		String sql = "select m00201,m00202,t00101,t00203,sum(t00203) over(partition by m00201 order by m00201) from M002,T001,T002 where M002.M00201=T002.T00202 and T001.T00101=T002.t00201  and to_char(sysdate,'yy-mm-dd')=to_char(t00103,'yy-mm-dd') and t00104 is null";

		Statement ps = connection.createStatement();
		List<M002PR10201> m002list = new ArrayList<M002PR10201>();
		M002PR10201 m002 = null;
		ResultSet rs = ps.executeQuery(sql);
		while (rs.next()) {
			m002 = new M002PR10201();
			m002.setM00201(rs.getString(1));
			m002.setM00202(rs.getString(2));
			m002.setT00101(rs.getString(3));
			m002.setT00203(rs.getString(4));
			m002.setSum(rs.getString(5));
			m002list.add(m002);

		}
		DBConnection.closeConnection();
		return m002list;
	}
}
