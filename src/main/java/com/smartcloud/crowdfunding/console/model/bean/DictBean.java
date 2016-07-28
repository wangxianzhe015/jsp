/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model.bean;

import com.smartcloud.platform.component.mvc.web.dict.DictEntry;



public class DictBean {
	private DictEntry dictEntry;
	
	private Boolean inUse;

	public DictEntry getDictEntry() {
		return dictEntry;
	}

	public void setDictEntry(DictEntry dictEntry) {
		this.dictEntry = dictEntry;
	}

	public Boolean getInUse() {
		return inUse;
	}

	public void setInUse(Boolean inUse) {
		this.inUse = inUse;
	}

}
