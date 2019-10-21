package comm.dhee.dto;


public class PR20202{//获取账单数据
	
	private int requestId;//请求书编号	==顾客id
	private String id;//顾客id
	private String name;//顾客名
	private String orderDate;//订货日期
	
	
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

}
