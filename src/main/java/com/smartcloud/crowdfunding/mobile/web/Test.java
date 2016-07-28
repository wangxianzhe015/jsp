package com.smartcloud.crowdfunding.mobile.web;

import com.smartcloud.crowdfunding.console.util.DigestMessage;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args)throws Exception {
		// TODO Auto-generated method stub
		DigestMessage dm = new DigestMessage(DigestMessage.ALG_MD5);
		System.out.println(dm.cryptPassword("000000"));
	}

}
