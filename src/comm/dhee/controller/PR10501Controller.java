package comm.dhee.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.M005Dao;
import comm.dhee.dto.M002PR10201;

@Controller
public class PR10501Controller {

	@RequestMapping("/m002search.action")
	public String m002search(HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException {

		String m0050 = request.getParameter("m0050");
		M005Dao m005dao = new M005Dao();
		List<M002PR10201> m002list = m005dao.searchm005(m0050);

		request.setAttribute("m002list", m002list);

		return "PR10501";

	}
}
