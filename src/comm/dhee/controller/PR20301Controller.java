package comm.dhee.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import comm.dhee.dao.PR20301Dao;
import comm.dhee.dto.PR20301;

@Controller
public class PR20301Controller {

	// 根据顾客号检索
	@RequestMapping("pr20301search.action")
	@ResponseBody
	public Map<String, Object> pr20301search(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException {

		String m00101 = request.getParameter("m00101");
		String m00101Message = null;
		String tableMessage = null;

		Map<String, Object> map = new HashMap<String, Object>();
		PR20301Dao pr20301dao = new PR20301Dao();
		List<PR20301> selpr20301list = pr20301dao.selpr20301(m00101);

		if (selpr20301list.size() == 0) {
			m00101Message = "該当する顧客コードがありません。";
			tableMessage = "該当する顧客が入金する必要はありません。";
			map.put("m00101Message", m00101Message);
			map.put("tableMessage", tableMessage);
		}

		map.put("selpr20301list", selpr20301list);

		return map;
	}

	// 检索所有顾客情报
	@RequestMapping("pr20301selall.action")
	@ResponseBody
	public Map<String, Object> pr20301selall(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException {

		Map<String, Object> map = new HashMap<String, Object>();
		PR20301Dao pr20301dao1 = new PR20301Dao();
		List<PR20301> selalllist = pr20301dao1.selall();
		map.put("selalllist", selalllist);
		return map;

	}

	// 检索输入的一条顾客情报
	@RequestMapping("pr20301selone.action")
	@ResponseBody
	public Map<String, Object> pr20301selone(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ParseException {

		String m00103 = request.getParameter("m00103");
		String m00103Message = null;
		Map<String, Object> map = new HashMap<String, Object>();
		PR20301Dao pr20301dao2 = new PR20301Dao();
		List<PR20301> selonelist = pr20301dao2.selone(m00103);

		if (selonelist.size() == 0) {
			m00103Message = "該当する顧客名がありません。";
			map.put("m00103Message", m00103Message);
		}
		map.put("selonelist", selonelist);

		return map;

	}

	// 登录按钮
	@ResponseBody
	@RequestMapping("pr20301login.action")
	public Map<String, Object> pr20301login(HttpServletRequest request) throws SQLException, ParseException {

		String m00101 = request.getParameter("m00101");
		String pr20301date = request.getParameter("pr20301date");
		String summoney = request.getParameter("summoney");


			// 追加入金コード和入金日付
			PR20301Dao pr20301dao3 = new PR20301Dao();
			pr20301dao3.inid(pr20301date);

			// 更新请求表的入金コード
			PR20301Dao pr20301dao4 = new PR20301Dao();
			pr20301dao4.updid(m00101);

			// 更新残高
			PR20301Dao pr20301dao5 = new PR20301Dao();
			pr20301dao5.updcangao(summoney, m00101);

			// 查询登录后残高
			Map<String, Object> map = new HashMap<String, Object>();
			PR20301Dao pr20301dao6 = new PR20301Dao();
			List<PR20301> pr20301loginlist = pr20301dao6.selcangao(m00101);
			map.put("pr20301loginlist", pr20301loginlist);
			
		return map;
	}
}
