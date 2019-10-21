package comm.dhee.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import comm.dhee.dao.PR20201Dao;
import comm.dhee.dto.PR20201_1;


@Controller
public class PR20201Controller {

	@RequestMapping("PR20201Customers.action")
	@ResponseBody
	public Map<String, Object> getCustomers(HttpServletRequest request,HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String,Object>();
		List<PR20201_1> list = new ArrayList<PR20201_1>();
		
		PR20201Dao dao = new PR20201Dao();
		
		list = dao.getCustomers();
		
		map.put("cusList", list);
		
		return map;
	}
	
	@RequestMapping("PR20201Customers2.action")
	@ResponseBody
	public Map<String, Object> getCustomersByName(HttpServletRequest request,HttpServletResponse response) {
		Map<String,Object> map = new HashMap<String,Object>();
		List<PR20201_1> list = new ArrayList<PR20201_1>();
		String customerName = request.getParameter("CustomerName");
		System.out.println(customerName);
		PR20201Dao dao = new PR20201Dao();
		
		if (customerName.equals("") || customerName==null) {
			list = dao.getCustomers();
		} else {
			list = dao.getCustomersByName(customerName);
		}

		map.put("cusList2", list);
		
		return map;
	}
	
	
	@RequestMapping("PR20202.action")
	public String PR20202(String id){
		
		
		
		return "PR20202";
	}
}
