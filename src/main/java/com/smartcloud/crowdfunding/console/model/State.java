package com.smartcloud.crowdfunding.console.model;

public enum State {
	
	INVLIDATE("1"),VALIDATE("0");
	
	private final String state;
	
	private State(String state){
		this.state=state;
	}
	
	public String getValue(){
		return state;
	}
    

}
