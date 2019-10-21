package comm.dhee.dto;

import java.util.Date;

public class PR20202_1 {

	private int index;// 序列号
	private String id;// 受注コード
	private Date orderDate;// 订货日期
	private Date deliveryDate;// 交货日期

	private int amountWhitoutTax;// 不含税金额
	private int tax;// 税
	private int amountWhitTax;// 含税金额
	
	public int getAmountWhitoutTax() {
		return amountWhitoutTax;
	}

	public void setAmountWhitoutTax(int amountWhitoutTax) {
		this.amountWhitoutTax = amountWhitoutTax;
	}

	public int getTax() {
		return tax;
	}

	public void setTax(int tax) {
		this.tax = tax;
	}

	public int getAmountWhitTax() {
		return amountWhitTax;
	}

	public void setAmountWhitTax(int amountWhitTax) {
		this.amountWhitTax = amountWhitTax;
	}

	

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	

	

}
