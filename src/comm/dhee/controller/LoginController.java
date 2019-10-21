package comm.dhee.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.M003Dao;
import comm.dhee.dao.M005Dao;
import comm.dhee.dto.M003;
import comm.dhee.dto.M005;

@Controller
public class LoginController {

	@Autowired
	private M005Dao m005Dao;

	@Autowired
	private M003Dao m003Dao;

	@RequestMapping("tologin.action")
	public String toLogin(HttpServletRequest request) throws SQLException {

		List<M005> lm005 = new ArrayList<M005>();
		lm005 = m005Dao.selectAllDepartments();
		if (lm005.get(0).getM00502() != null) {
			request.setAttribute("lm005", lm005);
		} else {
			request.setAttribute("departmentMessage", "部門名称がありません");
		}

		return "login";
	}

	@RequestMapping("/login.action")
	public String login(@ModelAttribute M003 m003, HttpServletRequest request) throws SQLException {

		request.setAttribute("departmentMessage", "");
		request.setAttribute("userMessage", "");
		request.setAttribute("passwordMessage", "");

		List<M005> lm005 = new ArrayList<M005>();
		lm005 = m005Dao.selectAllDepartments();
		if (lm005.get(0).getM00502() != null) {
			request.setAttribute("lm005", lm005);
			// request.setAttribute("departmentMessage", "部門名称がありません");
		} else {
			request.setAttribute("departmentMessage", "部門名称がありません");
		}

		M003 nm003 = new M003();
		nm003 = m003Dao.selectM003ByM00301(m003.getM00301());

		if (nm003.getM00301() != null && nm003.getM00303().equals(m003.getM00303())
				&& nm003.getM00304().equals(m003.getM00304())) {
			request.getSession().setAttribute("userId", nm003.getM00301());
			request.getSession().setAttribute("userName", nm003.getM00302());
			request.getSession().setAttribute("userPassword", nm003.getM00303());
			return "PR10101";
		} else {
			if (nm003.getM00301() == null || !nm003.getM00304().equals(m003.getM00304())) {
				request.setAttribute("userMessage", "該当する担当者コードがありません");
			} else if (!(nm003.getM00303().equals(m003.getM00303()))) {
				request.setAttribute("passwordMessage", "パスワードが不正です");
			}
			return "login";
		}
	}
}
