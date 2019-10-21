package comm.dhee.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import comm.dhee.dao.PR20101Dao;
import comm.dhee.dto.PR20101;

@Controller
public class PR20101Controller {

	@RequestMapping("pr20101search.action")
	public String pr20101search(HttpServletRequest request) throws IOException, SQLException {

		String t00101 = request.getParameter("t00101");

		// 检索受注コード是否存在
		request.setAttribute("t00101Message", "");
		PR20101Dao pr20101dao1 = new PR20101Dao();
		List<PR20101> allidlist = pr20101dao1.selectAllid(t00101);
		// System.out.println(allidlist.size());
		if (allidlist.size() == 0) {

			request.setAttribute("t00101Message", "該当する受注コードがありません。");

		} else if (allidlist.size() != 0 && allidlist.get(0).getT00104() != null) {

			request.setAttribute("allidlist", allidlist);
			request.setAttribute("t00101Message", "該当売掛をすでに登録しました。 ");

		} else {

			// 检索数据
			String value = "";
			if (t00101 != null) {
				value = t00101;
			}
			PR20101Dao pr20101dao2 = new PR20101Dao();
			List<PR20101> pr20101list = pr20101dao2.pr20101(t00101);
			request.setAttribute("t00101", value);
			request.setAttribute("pr20101list", pr20101list);

		}

		return "PR20101";

	}

	@ResponseBody
	@RequestMapping("pr20101login.action")
	public Map<String, Object> pr20101login(HttpServletRequest request) throws SQLException, ParseException {

		String t00101 = request.getParameter("t00101");
		String pr20101date = request.getParameter("pr20101date");

		// 更新残高
		PR20101Dao pr20101dao1 = new PR20101Dao();
		pr20101dao1.updcangao(t00101);

		// 更新纳入日期
		PR20101Dao pr20101dao2 = new PR20101Dao();
		pr20101dao2.upddate(pr20101date, t00101);

		// 查询登录后残高
		Map<String, Object> map = new HashMap<String, Object>();
		PR20101Dao pr20101dao3 = new PR20101Dao();
		List<PR20101> pr20101list1 = pr20101dao3.pr20101login(t00101);
		map.put("pr20101list1", pr20101list1);
		return map;

	}
}
