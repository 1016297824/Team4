package comm.dhee.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.M005Dao;
import comm.dhee.dto.M005;

@Controller
public class JumpController {

	@Autowired
	private M005Dao m005Dao;
	
	@RequestMapping("alogin.action")
	public String jumpLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, SQLException {
		
		List<M005> lm005 = new ArrayList<M005>();
		lm005 = m005Dao.selectAllDepartments();
		request.setAttribute("lm005", lm005);
		
		return "login";
	}

	@RequestMapping("aPR10101.action")
	public String jumpPR10101(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR10101";
	}
	
	@RequestMapping("aPR10201.action")
	public String jumpPR10201(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "redirect:/search.action";
	}
	
	@RequestMapping("aPR10301.action")
	public String jumpPR10301(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR10301";
	}
	
	@RequestMapping("aPR10401.action")
	public String jumpPR10401(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR10401";
	}
	
	@RequestMapping("aPR10501.action")
	public String jumpPR10501(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR10501";
	}
	
	@RequestMapping("aPR20101.action")
	public String jumpPR20101(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR20101";
	}
	
	@RequestMapping("aPR20201.action")
	public String jumpPR20201(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR20201";
	}
	
	@RequestMapping("aPR20301.action")
	public String jumpPR20301(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return "PR20301";
	}
}
