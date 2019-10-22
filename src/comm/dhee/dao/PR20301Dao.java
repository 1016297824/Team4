package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import comm.dhee.dto.PR20301;
import comm.dhee.util.DBConnection;

public class PR20301Dao {

	// 查询所有顾客id
	public List<PR20301> selectAllid(String m00101) throws SQLException {

		List<PR20301> allidlist = new ArrayList<PR20301>();
		Connection connection = DBConnection.getConnection();
		String sql = "select * from m001 where m00101 = ?";
		PR20301 allid = new PR20301();
		PreparedStatement ps;

		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, m00101);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				allid.setM00101(rs.getString(1));
				allidlist.add(allid);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return allidlist;

	}

	// 检索（外）查询
	public List<PR20301> selpr20301(String m00101) throws SQLException {

		List<PR20301> selpr20301list = new ArrayList<PR20301>();
		Connection connection = DBConnection.getConnection();
		String sql = "select m1.m00103,m1.m00112,t3.t00301,to_char(t3.t00302,'yyyy/MM/dd'),sum(t2.t00203*m2.m00203) "
				+ "from m001 m1,m002 m2,t001 t1,t002 t2,t003 t3 "
				+ "where t1.t00105 = m1.m00101(+) and t1.t00108 = t3.t00301(+) "
				+ "and t1.t00101 = t2.t00201(+) and t2.t00202 = m2.m00201(+) and t1.t00105 = ? "
				+ "group by m1.m00103,m1.m00112,t3.t00301,t3.t00302";
		PR20301 a = new PR20301();
		PreparedStatement ps;

		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, m00101);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				a.setM00103(rs.getString(1));
				a.setM00112(rs.getString(2));
				a.setT00301(rs.getString(3));
				a.setT00302(rs.getString(4));
				a.setSumtm(rs.getString(5));
				selpr20301list.add(a);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return selpr20301list;
	}

	// 搜索框查询
	public List<PR20301> selall() throws SQLException {

		List<PR20301> selalllist = new ArrayList<PR20301>();
		Connection conn = DBConnection.getConnection();
		String sql = "select m00101,m00103,m00110 from m001";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);

			while (rs.next()) {
				PR20301 b = new PR20301();
				b.setM00101(rs.getString(1));
				b.setM00103(rs.getString(2));
				b.setM00110(rs.getString(3));

				selalllist.add(b);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return selalllist;
	}

	// 检索（内）查询
	public List<PR20301> selone(String m00103) throws SQLException {

		List<PR20301> selonelist = new ArrayList<PR20301>();
		Connection conn = DBConnection.getConnection();
		String sql = "select m00101,m00103,m00110 from m001 where m00103 like ?";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + m00103 + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				PR20301 c = new PR20301();
				c.setM00101(rs.getString(1));
				c.setM00103(rs.getString(2));
				c.setM00110(rs.getString(3));

				selonelist.add(c);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return selonelist;
	}

	// 追加入金コード和入金日付
	public boolean inid(String pr20301date) throws SQLException {

		Connection conn = DBConnection.getConnection();
		String sql = "insert into t004 values((select lpad(nvl(MAX(t00401),0)+1,4,'0') from t004),to_date(?,'yyyy-mm-dd'))";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pr20301date);

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

	// 更新请求表的入金コード
	public boolean updid(String m00101) throws SQLException {

		Connection conn = DBConnection.getConnection();
		String sql = "update t003 set t00303 = (select max(t00401) from t004) "
				+ "where t00301 = (select t00108 from t001 where t00105 = ?)";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, m00101);

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
	public boolean updcangao(String summoney, String m00101) {

		Connection conn = DBConnection.getConnection();
		String sql = "update m001 set m00112 = m00112 - ? where m00101 = ?";
		PreparedStatement ps;
		try {

			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(summoney));
			ps.setString(2, m00101);

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
	public List<PR20301> selcangao(String m00101) throws SQLException {

		List<PR20301> cangaolist = new ArrayList<PR20301>();

		Connection conn = DBConnection.getConnection();
		String sql = "select m00112 from m001 where m00101 = ?";

		PR20301 d = new PR20301();
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, m00101);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				d.setM00112(rs.getString(1));
				cangaolist.add(d);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return cangaolist;
	}

}
