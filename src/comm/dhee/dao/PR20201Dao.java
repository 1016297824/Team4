package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import comm.dhee.dto.PR20201_1;
import comm.dhee.util.DBConnection;

public class PR20201Dao {

	public List<PR20201_1> getCustomers() {// 获取顾客额度信息;
		List<PR20201_1> list = new ArrayList<PR20201_1>();
		Connection conn = DBConnection.getConnection();

		String sql = "select Distinct(M00101),M00103,M00110 from M001,T001 where M001.M00101=T001.T00105 and t001.t00108 is null and t001.t00104 is not null";

		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			PR20201_1 pr = null;
			while (rs.next()) {

				pr = new PR20201_1();
				pr.setId(rs.getString(1));
				pr.setName(rs.getString(2));
				pr.setQuota(rs.getInt(3));

				list.add(pr);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBConnection.closeConnection();
		return list;
	}

	public List<PR20201_1> getCustomersByName(String name) {// 通过顾客姓名查找额度信息
		PR20201_1 pr = null;
		List<PR20201_1> list = new ArrayList<PR20201_1>();
		Connection conn = DBConnection.getConnection();
		String sql = "select M00101,M00103,M00110 from M001 where M00103 like ?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + name + "%");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				pr = new PR20201_1();
				pr.setId(rs.getString(1));
				pr.setName(rs.getString(2));
				pr.setQuota(rs.getInt(3));

				list.add(pr);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBConnection.closeConnection();
		}
		return list;
	}
}
