package comm.dhee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import comm.dhee.dto.T002;
import comm.dhee.util.DBConnection;

@Repository
public class T002Dao {

	public boolean insertOrderDetailed(List<T002> lt002) throws SQLException {
		Connection connection = DBConnection.getConnection();

		String sql = "insert into t002 values (?,?,?,?)";
		PreparedStatement ps = connection.prepareStatement(sql);
		for (T002 t002 : lt002) {
			int insert = 0;
			ps.setString(1, t002.getT00201());
			ps.setString(2, t002.getT00202());
			ps.setInt(3, t002.getT00203());
			ps.setDouble(4, t002.getT00204());

			insert = ps.executeUpdate();
			if (insert == 0) {
				DBConnection.closeConnection();
				return false;
			}
		}

		DBConnection.closeConnection();
		return true;
	}
}
