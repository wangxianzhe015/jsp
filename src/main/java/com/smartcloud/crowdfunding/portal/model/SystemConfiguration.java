package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="PORTAL_SYSTEM_CONFIG")
public class SystemConfiguration implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="CONFIG_ID")
	private Long configId;
	

	@Column(name="CONFIG_KEY")
	private String configKey;
	

	@Column(name="CONFIG_VALUE")
	private String configValue;
	

	@Column(name="CONFIG_DESC")
	private String configDesc;


	public Long getConfigId() {
		return configId;
	}


	public void setConfigId(Long configId) {
		this.configId = configId;
	}


	public String getConfigKey() {
		return configKey;
	}


	public void setConfigKey(String configKey) {
		this.configKey = configKey;
	}


	public String getConfigValue() {
		return configValue;
	}


	public void setConfigValue(String configValue) {
		this.configValue = configValue;
	}


	public String getConfigDesc() {
		return configDesc;
	}


	public void setConfigDesc(String configDesc) {
		this.configDesc = configDesc;
	}

	
	
}
