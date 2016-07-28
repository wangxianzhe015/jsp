package com.smartcloud.crowdfunding.console.util;

import java.io.InputStream;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

/**
 * <p>用于验证数据是否被篡改，常用的算法包括MD5和SHA。消息摘要还可以用在口令加密中，通过比较口令的消息摘要从而可以判断口令是否正确，如果采用加salt处理，则口令会更加安全。 </p>                                      
 * <p>代码示例：<p>
    <pre>
    	DigestMessage digestMessage = new DigestMessage(DigestMessage.ALG_MD5);
    	// 加密口令
    	String cryptStr = digestMessage.cryptPassword("aksdasd");
    	// 检验口令
    	digestMessage.checkPassword("aksdasd", cryptStr);
    </pre>
 *
 * @author wengzr (mailto:zrweng@hotmail.com)
 */
/*
 * 修改历史
 * $Log: DigestMessage.java,v $
 * Revision 1.1  2012/12/04 07:35:18  supyuser
 * *** empty log message ***
 *
 * Revision 1.1  2012/05/25 06:28:21  supyuser
 * *** empty log message ***
 *
 * Revision 1.2  2008/02/08 15:51:17  wengzr
 * Update:重构
 *
 * Revision 1.1  2007/12/13 15:22:12  wengzr
 * 提交CVS
 *
 */
public class DigestMessage {
	/**
	 * 消息摘要算法：MD5
	 */
	public static final String ALG_MD5 = "MD5";
	/**
	 * 消息摘要算法：SHA
	 */
	public static final String ALG_SHA = "SHA";
	/**
	 * 缺省的Salt字节数，用于口令+salt的消息摘要中,为12，足够了
	 */
	public static final int SALT_BITNUM = 12;

	//口令加salt消息摘要中使用的salt字节数， 缺省使用SALT_BITNUM定义
	private int saltBitNum = SALT_BITNUM;
	// 消息摘要算法算法
	private String algorithm = null;

	/**
	 * 构造器
	 * @param _algorithm 加密算法，支持的算法有{@link #ALG_MD5}和{@link #ALG_SHA}
	 * @throws java.security.NoSuchAlgorithmException 如果不支持参数<b>_algorithm<b>加密算法，则掷出。
	 * @see #ALG_MD5
	 * @see #ALG_SHA
	 */
	public DigestMessage(String _algorithm) throws NoSuchAlgorithmException {
		if (_algorithm.equals(ALG_MD5) || _algorithm.equals(ALG_SHA)) {
			this.algorithm = _algorithm;
		} else {
			throw new NoSuchAlgorithmException("不支持消息摘要算法:" + _algorithm);
		}
	}

	/**
	 * 获得字节数组的消息摘要字节数组
	 * @param _oBytes 待计算字节数组
	 * @return 消息摘要字节数组
	 */
	public byte[] getMessageDegistBytes(byte[] _oBytes) {
		byte[] mBytes = null;
		try {
			MessageDigest md = MessageDigest.getInstance(this.algorithm);
			md.update(_oBytes);
			mBytes = md.digest();
		} catch (Exception e) {
			// can't happen
		}
		return mBytes;
	}

	/**
	 * 获得输入流的消息摘要字节数组
	 * @param _in 待计算输入流
	 * @return 消息摘要字节数组
	 */
	public byte[] getMessageDegistBytes(InputStream _in) {
		byte[] mBytes = null;
		try {
			MessageDigest md = MessageDigest.getInstance(this.algorithm);
			DigestInputStream din = new DigestInputStream(_in, md);
			//读一遍，将数据导入MessageDigest中
			while (din.read() != -1) {
			}
			mBytes = md.digest();
			din.close();
		} catch (Exception e) {
			// can't happen
		}
		return mBytes;
	}

	/**
	 * 获得字符串的消息摘要字节数组，使用UTF-8编码。
	 * @param _str 待计算字符串
	 * @return 消息摘要字节数组
	 */
	public byte[] getMessageDegistBytes(String _str) {
		//使用UTF8编码
		try {
			return getMessageDegistBytes(toBytes(_str, "UTF8"));
		} catch (Exception e) {
			// can't happen
			return null;
		}
	}

	/**
	 * 获得口令的消息摘要字符串，本方法采用随机的salt+口令的消息摘要，从而达到加密口令的效果。如果需要采用不加Salt的方式获得口令的消息摘要使用{@link #getMessageDegistBytes(String)}方法
	 * @param _password 口令
	 * @return 采用UTF8编码的salt字符串+口令加盐的消息摘要字符串
	 */
	public String cryptPassword(String _password) {
		String value = null;
		try {
			// salt
			byte[] salt = new byte[saltBitNum];
			new Random().nextBytes(salt);
			//不使用UTF8编码转换salt，防止数据丢失
			//salt串+消息摘要
			value = toStr(salt) + getMessageDigestStr(toBytes(_password, "UTF8"), salt);
		} catch (Exception e) {
			// can't happen
		}
		return value;
	}

	// 获得字节数组+salt的消息摘要
	private String getMessageDigestStr(byte[] _mBytes, byte[] _salt) {
		String value = null;
		try {
			MessageDigest md = MessageDigest.getInstance(this.algorithm);
			// add salt;
			md.update(_salt);
			md.update(_mBytes);
			value = getMessageDegistString(md.digest());
		} catch (Exception e) {
			//can't happen
		}
		return value;
	}

	/**
	 * 该方法是{@link #cryptPassword(String)}方法的逆方法，验证口令是否正确
	 * @param _password 待检验口令
	 * @param _saltAndMDStr Salt和消息摘要的字符串
	 * @return true验证成功，false验证失败
	 */
	public boolean checkPassword(String _password, String _saltAndMDStr) {
		int digestBitNum = 0;
		if (this.algorithm.equals(ALG_MD5)) {
			digestBitNum = 32;
		} else {
			digestBitNum = 40;
		}

		int length = _saltAndMDStr.length();
		String digestStr = _saltAndMDStr.substring(length - digestBitNum);
		byte[] salt = toBytes(_saltAndMDStr.substring(0, length - digestBitNum));
		try{
			return getMessageDigestStr(toBytes(_password, "UTF8"), salt).equals(digestStr);
		}catch(Exception pe) {
			// can't happen
			return false;
		}
	}

	/**
	 * 从消息摘要的字节数组获得它的字符串形式
	 * @param _mBytes 消息摘要字节数组
	 * @return 消息摘要字符串
	 */
	public static String getMessageDegistString(byte[] _mBytes) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < _mBytes.length; i++) {
			sb.append(Integer.toHexString((0x000000ff & _mBytes[i]) | 0xffffff00).substring(6));
		}
		return sb.toString();
	}

	/**
	 * 获得使用的Salt字节数
	 * @return Salt字节数
	 */
	public int getSaltBitNum() {
		return saltBitNum;
	}

	/**
	 * 设置使用的Salt字节数
	 * @param _saltBitNum Salt的位数，越大难用字典式攻击破解。一般可以取12位
	 */
	public void setSaltBitNum(int _saltBitNum) {
		this.saltBitNum = _saltBitNum;
	}

	/**
	 * 将字符串转化为字节，字符串必须是3位的数字串，并且代表的数字范围为[0,256]，如234<br>
	 * 该方法是{@link #toStr(byte)}方法的逆操作。
	 * @param _str 待转化字符串
	 * @return 字节
	 */
	private static byte toByte(String _str) {
		if (_str.length() != 3) {
			throw new IllegalArgumentException("参数必须是3位数字串");
		}
		return (byte) Integer.parseInt(_str);
	}
	/**
	 * 将字符串转化为字节数组，字符串的长度必须是3的倍数，并且每3位代表的数字范围为[0,256]，如234001<br>
	 * 该方法是{@link #toStr(byte[])}方法的逆操作。
	 * @param _str 待转化字符串
	 * @return 字节数组
	 */
	private static byte[] toBytes(String _str) {
		if (_str == null) {
			return null;
		}
		if ((_str.length() % 3) != 0) {
			throw new IllegalArgumentException("参数必须是长度为3的倍数的数字串");
		}
		String s = null;
		String tStr = new String(_str);
		byte[] bytes = new byte[(int) (_str.length() / 3)];
		for (int i = 0; i < bytes.length; i++) {
			s = tStr.substring(i * 3, (i + 1) * 3);
			bytes[i] = toByte(s);
		}
		return bytes;

	}
	/**
	 * 字符串处理，将字节转化为数字串，每一个字节用三位数字表示，不足三位补0，如:1000001为129， 而00000001为001<br>
	 * 该方法用于那些使用编码转化可能产生问题的情况下，另外它的逆操作是{@link #toByte(String)}
	 * @param _byte 字节
	 * @return 转化后的字符串
	 */
	private static String toStr(byte _byte) {
		int i = _byte;
		if (i < 0) {
			i = 256 + i;
		}
		String s = "";
		if (i < 10) {
			s = "00";
		} else if (i < 100) {
			s = "0";
		}
		s += Integer.toString(i);
		return s;
		//return Integer.toHexString( (0x000000ff & _byte) | 0xffffff00).substring(6);
	}

	/**
	 * 字符串处理，将字节数组，转换规则见{@link #toStr(byte)}方法，该方法的逆操作是
	 * @param _bytes 字节数组
	 * @return 转化后的字符串
	 */
	private static String toStr(byte[] _bytes) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < _bytes.length; i++) {
			sb.append(toStr(_bytes[i]));
		}
		return sb.toString();
	}
	
	
	private static byte[] toBytes(String _str, String _encoding) throws Exception {
		if( _str == null) {
			return null;
		}
		byte[] b = null;
		b = _str.getBytes(_encoding);

		return b;
	}
	
	
	public static void main(String[] args)throws Exception{
		DigestMessage dm=new DigestMessage(DigestMessage.ALG_MD5);
		String str=dm.cryptPassword("888888");
		System.out.println(str);
		boolean b=dm.checkPassword("888888", str);
		System.out.println(b);
	}
}
