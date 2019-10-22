package comm.dhee.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import comm.dhee.dao.ExcelResultDao;
import comm.dhee.dao.M001Dao;
import comm.dhee.dao.M002Dao;
import comm.dhee.dao.M003Dao;
import comm.dhee.dao.T001Dao;
import comm.dhee.dao.T002Dao;
import comm.dhee.dto.ExcelResult;
import comm.dhee.dto.M001;
import comm.dhee.dto.M002;
import comm.dhee.dto.M003;
import comm.dhee.dto.ResultBean;
import comm.dhee.dto.T001;
import comm.dhee.dto.T002;
import comm.dhee.util.ExcelUtils;

@Controller
public class PR10101Controller {

	@Autowired
	private M001Dao m001Dao;

	@Autowired
	private M002Dao m002Dao;

	@Autowired
	private M003Dao m003Dao;

	@Autowired
	private T001Dao t001Dao;

	@Autowired
	private T002Dao t002Dao;

	@Autowired
	private ExcelResultDao excelResultDao;

	@ResponseBody
	@RequestMapping("/getAllCustomer.action")
	public Map<String, Object> getCustomer(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {

		Map<String, Object> map = new HashMap<String, Object>();

		List<M001> lm001 = new ArrayList<M001>();
		lm001 = m001Dao.getAllCustomers();

		map.put("lm001", lm001);

		return map;
	}

	@ResponseBody
	@RequestMapping("/selectCustomers.action")
	public Map<String, Object> searchCustomers(HttpServletRequest request, HttpServletResponse response, String cname,
			String productName) throws SQLException {

		String customerMessage = null;
		Map<String, Object> map = new HashMap<String, Object>();

		List<M001> lm001 = new ArrayList<M001>();
		lm001 = m001Dao.selectCustomersByName(cname);

		if (lm001.size() == 0) {
			customerMessage = "顧客コードがありません。顧客情報管理に顧客情報を追加してください";
			map.put("customerMessage", customerMessage);
		}

		map.put("lm001", lm001);

		return map;
	}

	@ResponseBody
	@RequestMapping("/selectAllProdects.action")
	public Map<String, Object> selectAllProducts() throws SQLException {

		Map<String, Object> map = new HashMap<String, Object>();

		List<M002> lm002 = new ArrayList<M002>();
		lm002 = m002Dao.selectAllProducts();

		map.put("lm002", lm002);

		return map;
	}

	@ResponseBody
	@RequestMapping("/selectProducts.action")
	public Map<String, Object> selectProducts(HttpServletRequest request, String productName) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		String productMessage = null;

		List<M002> lm002 = new ArrayList<M002>();
		lm002 = m002Dao.selectProductByName(productName);

		if (lm002.size() == 0) {
			productMessage = "商品コードがありません。商品情報管理に商品情報を追加してください";
			map.put("productMessage", productMessage);
		}

		map.put("lm002", lm002);

		return map;
	}

	@ResponseBody
	@RequestMapping("/issuePR10101.action")
	public Map<String, Object> issueCustomer(@RequestBody ResultBean resultBean, HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();

		T001 t001 = resultBean.getT001();
		List<T002> lt002 = resultBean.getLt002();

		String orderId = t001Dao.getOrderId();
		request.getSession().setAttribute("orderId", orderId);
		if (orderId != null) {
			t001.setT00101(orderId);
			M001 m001 = m001Dao.selectCustomerById(t001.getT00105());
			if (m001.getM00101() == null) {
				map.put("result", false);
				map.put("message", "該当する顧客コードがありません");
				return map;
			} else {
				double total = 0;
				for (T002 t002 : lt002) {
					total += t002.getT00203() * t002.getT00204();
				}
				total *= 1.05;
				total += m001.getM00112();
				if (total > m001.getM00110()) {
					map.put("result", false);
					map.put("message", "信用限度額をオーバーしています");
					return map;
				} else {
					if (t001.getT00106() == "") {
						t001.setT00106(m001.getM00105());
					}
					if (!t001Dao.insertOrder(t001)) {
						map.put("result", false);
						map.put("message", "SQL実行例外が発生しました");
						return map;
					} else {
						if (!m002Dao.updateProducts(lt002)) {
							map.put("result", false);
							map.put("message", "SQL実行例外が発生しました");
							return map;
						} else {
							for (T002 t002 : lt002) {
								t002.setT00201(orderId);
							}
							if (!t002Dao.insertOrderDetailed(lt002)) {
								map.put("result", false);
								map.put("message", "SQL実行例外が発生しました");
								return map;
							} else {
								map.put("result", true);
								map.put("message", "受注完了");
								return map;
							}
						}
					}
				}
			}
		} else {
			map.put("result", false);
			map.put("message", "SQL実行例外が発生しました");
			return map;
		}
	}

	@RequestMapping("/issueExcel.action")
	public void pr10102(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		M001 m001 = new M001();
		M003 m003 = new M003();
		T001 t001 = new T001();
		List<ExcelResult> lexcelResult = new ArrayList<ExcelResult>();

		String orderId = (String) request.getSession().getAttribute("orderId");
		map.put("orderId", orderId);

		t001 = t001Dao.selectT001(orderId);
		Date deliveryDay = t001.getT00103();
		map.put("deliveryDay", deliveryDay);
		map.put("location", t001.getT00106());

		m001 = m001Dao.selectExcelCustomerById(t001.getT00105());
		map.put("customer", m001);
		
		m003 = m003Dao.selectM003ByM00301(t001.getT00107());
		map.put("undertakerName", m003.getM00302());

		lexcelResult = excelResultDao.selectExcelResult(orderId);
		map.put("lexcelResult", lexcelResult);

		ExcelUtils.exportToExcel(request, response, "受注商品明細.xls", "PR10101.xls", map);
	}
}
