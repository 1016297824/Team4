package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import comm.dhee.dto.PR20202;
import comm.dhee.dto.PR20202_1;
import comm.dhee.util.DBConnection;

public class PR20202Dao {

	public PR20202 selectInfoById(String id, String date) {// 查询顾客账单数据

		Connection conn = DBConnection.getConnection();

		String sql = "select Distinct(M00101),M00103 from M001 where M00101=?";
		PR20202 PR20202 = null;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				PR20202 = new PR20202();
				PR20202.setId(rs.getString(1));// 顾客id
				PR20202.setRequestId(getRequestindexNext());// 请求书编号
				PR20202.setName(rs.getString(2));// 顾客姓名
				PR20202.setOrderDate(date);// 订货日期
			}

		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return PR20202;
	}

	public List<PR20202_1> getAllInfoById(String id) {// 通过顾客id查找代金信息
		PR20202_1 pr = null;
		List<PR20202_1> list = new ArrayList<PR20202_1>();
		Connection conn = DBConnection.getConnection();
		String sql = "select T00101,T00102,T00104,Sum(T00203*T00204),Sum(T00203*T00204)*0.05,Sum(T00203*T00204)*1.05 from T001,T002,M001,M002 where T00104 is not null and T00108 is null and T001.t00105=M001.M00101 and T002.t00202=M002.M00201 and T001.T00101=T002.T00201 and T001.T00105=? group by T00101,T00102,T00104";
		int index = 1;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				System.out.println("also true");
				pr = new PR20202_1();
				pr.setIndex(index);// 序列号
				pr.setId(rs.getString(1));// 受注コード
				System.out.println(rs.getString(1));
				pr.setOrderDate(rs.getDate(2));// 订货日期
				pr.setDeliveryDate(rs.getDate(3));// 交货日期
				pr.setAmountWhitoutTax(rs.getInt(4));// 不含税金额
				pr.setTax(rs.getInt(5));// 税
				pr.setAmountWhitTax(rs.getInt(6));// 含税金额
				list.add(pr);
				index++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return list;
	}

	public int getRequestindexNext() {// 获取请求书番号+1
		int index = 1;
		Connection conn = DBConnection.getConnection();
		String sql = "select lpad(nvl(Max(T00301),0)+1,3,'0') from t003";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if (rs.next()) {
				index = rs.getInt(1);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return index;
	}

	public int getRequestindex() {// 获取当前请求书番号
		int index = 1;
		Connection conn = DBConnection.getConnection();
		String sql = "select lpad(nvl(Max(T00301),0),3,'0') from t003";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if (rs.next()) {
				index = rs.getInt(1);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return index;
	}

	public Date getRequestDate(String id) {// 获取请求日期
		Date date = null;
		Connection conn = DBConnection.getConnection();
		String sql = "select T00104 from t001 where t00105=?";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if (rs.next()) {
				date = rs.getDate(1);
			}
			System.out.println(date);
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}
		return date;
	}

	public void updateRequest(String id) {// 更新T00108 请求书 番号

		int index = getRequestindex();
		Connection conn = DBConnection.getConnection();
		String sql = "update t001 set t00108= ? where t00105=? and t00104 is not null and t00108 is null";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, index);
			ps.setString(2, id);
			ResultSet rs = ps.executeQuery();
			commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}
	}

	public void insertRequestTable(String date) {// 插入T003请求书番号
		int index = getRequestindexNext();
		Connection conn = DBConnection.getConnection();
		String sql = "insert into T003 values(?,to_date(?,'yyyy-mm-dd'),null)";
		try {

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, index);
			ps.setString(2, date);
			ResultSet rs = ps.executeQuery();
			commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}
	}

	public boolean cheak(String id) {// 查询是否T00108 是否已经存在

		Connection conn = DBConnection.getConnection();
		String sql = "select * from t001 where ? in (select Distinct(M00101) from M001,T001 where M001.M00101=T001.T00105 and t001.t00108 is null and t001.t00104 is not null)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next() == false) {
				System.out.println(rs.next());
				return false;
			} else {
				System.out.println(rs.next());
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

		return true;
	}

	public void commit() {// 提交
		Connection conn = DBConnection.getConnection();
		String sql = "commit work";

		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			DBConnection.closeConnection();
		}

	}
}
