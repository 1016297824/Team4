package comm.dhee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.PR10302Business;

@Controller
public class PR10302Controller {
	
	
	@RequestMapping("aPR10302.action")
	public String jumpPR10302(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PR10302Business pr10302Business = new PR10302Business();
		List<Double> sumList = pr10302Business.getDoubleList();
		List<String> idList = pr10302Business.getStringList();
		request.setAttribute("PR10302sumList", sumList);
		request.setAttribute("PR10302idList", idList);
		 return "PR10302";
	}
}
