package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.ExcelResult;
import comm.dhee.util.DBConnection;

@Repository
public class ExcelResultDao {

	public List<ExcelResult> selectExcelResult(String orderId) throws SQLException {
		List<ExcelResult> lexcelResul = new ArrayList<ExcelResult>();

		Connection connection = DBConnection.getConnection();

		String sql = "select t00203,m00202,t00204 from m002,t002 where m00201=t00202 and t00201=?";
		PreparedStatement ps = connection.prepareStatement(sql);
		ps.setString(1, orderId);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			ExcelResult excelResult = new ExcelResult();
			excelResult.setAmount(rs.getInt(1));
			excelResult.setProductName(rs.getString(2));
			excelResult.setPrice(rs.getDouble(3));
			lexcelResul.add(excelResult);
		}

		DBConnection.closeConnection();

		return lexcelResul;
	}
}
