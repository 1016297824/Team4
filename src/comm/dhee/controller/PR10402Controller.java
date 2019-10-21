package comm.dhee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import comm.dhee.dao.PR10402Business;
import comm.dhee.dao.PR10402Business;

@Controller
public class PR10402Controller {

	@RequestMapping("aPR10402.action")
	public String jumpPR10402(HttpServletRequest request, HttpServletResponse response) throws Exception {

		PR10402Business pr10402Business = new PR10402Business();
		List<Double> sumList = pr10402Business.getDoubleList();
		List<String> idList = pr10402Business.getStringList();
		request.setAttribute("PR10402sumList", sumList);
		request.setAttribute("PR10402idList", idList);
		return "PR10402";
	}
}
