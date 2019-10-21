package comm.dhee.dto;

public class PR20101 {

	private String m00101;// 顧客コード
	private String m00103;// 顧客名
	private String m00112;// 売掛金残高
	private String t00101;// 受注コード
	private String t00104;// 納入日付
	private String summoney;// sum(売上数量*売上単価)*1.04

	public String getM00101() {
		return m00101;
	}

	public void setM00101(String m00101) {
		this.m00101 = m00101;
	}

	public String getM00103() {
		return m00103;
	}

	public void setM00103(String m00103) {
		this.m00103 = m00103;
	}

	public String getM00112() {
		return m00112;
	}

	public void setM00112(String m00112) {
		this.m00112 = m00112;
	}

	public String getT00101() {
		return t00101;
	}

	public void setT00101(String t00101) {
		this.t00101 = t00101;
	}

	public String getT00104() {
		return t00104;
	}

	public void setT00104(String t00104) {
		this.t00104 = t00104;
	}

	public String getSummoney() {
		return summoney;
	}

	public void setSummoney(String summoney) {
		this.summoney = summoney;
	}

}
