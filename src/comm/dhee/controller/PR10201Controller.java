package comm.dhee.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.M002PR10201Dao;
import comm.dhee.dto.M002PR10201;


@Controller
public class PR10201Controller {
	@RequestMapping("/search.action")
	public String search(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException{
		
		String message="";
	M002PR10201Dao m002dao = new M002PR10201Dao();
	List<M002PR10201> m002list = m002dao.searchm002();
	request.setAttribute("m002list", m002list);

	if(m002list.size() == 0){
		message="本日出庫商品がありません";
		//JOptionPane.showMessageDialog(null, "本日出庫商品がありません");
	}
	
	request.setAttribute("message", message);
	return "PR10201";
		
	}

}
