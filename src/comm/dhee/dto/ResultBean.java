package comm.dhee.dto;

import java.util.List;

public class ResultBean {

	private T001 t001;
	private List<T002> lt002;

	public T001 getT001() {
		return t001;
	}

	public void setT001(T001 t001) {
		this.t001 = t001;
	}

	public List<T002> getLt002() {
		return lt002;
	}

	public void setLt002(List<T002> lt002) {
		this.lt002 = lt002;
	}

}
