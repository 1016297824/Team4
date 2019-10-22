package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import comm.dhee.dto.PR20101;
import comm.dhee.util.DBConnection;

public class PR20101Dao {

	// 查询所有受注コード
	public List<PR20101> selectAllid(String t00101) throws SQLException {

		List<PR20101> allidlist = new ArrayList<PR20101>();
		Connection connection = DBConnection.getConnection();
		String sql = "select * from t001 where t00101 = ?";
		PR20101 allid = new PR20101();
		PreparedStatement ps;

		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, t00101);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				allid.setT00101(rs.getString(1));
				allid.setT00104(rs.getString(4));
				allidlist.add(allid);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return allidlist;

	}

	// 检索按钮
	public List<PR20101> pr20101(String t00101) throws SQLException {

		List<PR20101> pr20101list = new ArrayList<PR20101>();

		Connection conn = DBConnection.getConnection();
		String sql = "select m1.m00101,m1.m00103,m1.m00112,t1.t00104,sum(t2.t00203*t2.t00204)*1.04 sum from m001 m1,t001 t1,t002 t2 "
				+ "where m1.m00101 = t1.t00105 and t2.t00201 = t1.t00101 and t1.t00101 = ? "
				+ "group by m1.m00101,m1.m00103,m1.m00112,t1.t00104";

		PR20101 p = new PR20101();
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, t00101);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				p.setM00101(rs.getString(1));
				p.setM00103(rs.getString(2));
				p.setM00112(rs.getString(3));
				p.setT00104(rs.getString(4));
				p.setSummoney(rs.getString(5));
				pr20101list.add(p);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return pr20101list;
	}

	// 更新日期
	public boolean upddate(String pr20101date, String t00101) {

		Connection conn = DBConnection.getConnection();
		String sql = "update t001 set t00104 =to_date(?,'yyyy-mm-dd') where t00101 = ?";
		PreparedStatement ps;
		try {
			// System.out.println("upddate" + pr20101date);

			ps = conn.prepareStatement(sql);
			ps.setString(1, pr20101date);
			ps.setString(2, t00101);
			if (ps.executeUpdate() > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}
		return false;
	}

	// 更新残高
	public boolean updcangao(String t00101) {

		Connection conn = DBConnection.getConnection();
		String sql = "update m001 set m00112 = m00112 + ( select sum(t00203*t00204)*1.04 from t002 where t00201 = ?) "
				+ "where m00101 = (select t00105 from t001 where t00101 = ?)";
		PreparedStatement ps;
		try {
			// System.out.println("updcangao" + t00101);

			ps = conn.prepareStatement(sql);
			ps.setString(1, t00101);
			ps.setString(2, t00101);

			if (ps.executeUpdate() > 0) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}
		return false;
	}

	// 查询登录后的残高
	public List<PR20101> pr20101login(String t00101) throws SQLException {

		List<PR20101> pr20101list1 = new ArrayList<PR20101>();

		Connection conn = DBConnection.getConnection();
		String sql = "select m1.m00112 from m001 m1,t001 t1 where m1.m00101 = (select t00105 from t001 where t00101 = ?)";

		PR20101 q = new PR20101();
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, t00101);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				q.setM00112(rs.getString(1));
				pr20101list1.add(q);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return pr20101list1;
	}

}
