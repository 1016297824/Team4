package comm.dhee.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import comm.dhee.dao.PR20202Dao;
import comm.dhee.dto.PR20202;
import comm.dhee.dto.PR20202_1;

@Controller
public class PR20202Controller {
	public String id;
	@RequestMapping("PR20202_1.action")
	public String selectInfo(HttpServletRequest request,HttpServletResponse response){
			int amount=0;//总和
			boolean isExisting = true;
			
			String message = null;
		try {
			id = request.getParameter("CustomerID");
			String date = request.getParameter("RequestDate");

			PR20202 pr= new PR20202();
			PR20202Dao dao = new PR20202Dao();
			 isExisting = dao.cheak(id);//查询请求书番号是否已经存在，存在则不可再次制作申请书
			 
			 
			pr = dao.selectInfoById(id,date);//查询顾客信息

			List<PR20202_1> list = new ArrayList<PR20202_1>();
			list = dao.getAllInfoById(id);
			
			for (PR20202_1 pr20202_1 : list) {//遍历list数据
				amount +=pr20202_1.getAmountWhitTax();//计算总金额
			}
			dao.insertRequestTable(date);//插入请求番号和日期
			dao.commit();
			dao.updateRequest(id);//更新t004
			
			request.setAttribute("PR20202_1List", list);
			request.getSession().setAttribute("PR20202", pr);
			request.setAttribute("PR20202Amount", amount);
		} catch (NullPointerException e) {
			
		} 
		if (isExisting == false) {
			message="M202001E：請求書を作成する必要の顧客がありません。";
			request.setAttribute("PR20201message", message);
			
			return "PR20201";
		}else{
			return "PR20202";
		}
		
	}
	
	
}
