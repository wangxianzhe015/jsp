package com.smartcloud.crowdfunding.portal;

/**
 * 常量定义
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public final class Constants {
	
	/**
	 * 图片验证码
	 */
	public static final String KEY_IMAGE_VERIFY_CODE="_image_verifycode";
	
	/**
	 * 支付图片验证码
	 */
	public static final String KEY_PAY_VERIFY_CODE="_pay_image_verifycode";
	
	/**
	 * 首页菜单项标识
	 */
	public static final String[] MENU_ITEMS=new String[]{"main","list","guide","aboutus"};
	
	/**
	 * 发布项目
	 */
	public static final String UC_MENU_PUBLISH_PROJECT="publish_project";
	
	/**
	 * 用户中心(默认菜单)
	 */
	public static final String UC_MENU_USER_INDEX="index";
	
	/**
	 * 消息中心
	 */
	public static final String UC_MENU_MESSAGE_LIST="message_list";
	
	/**
	 * 我的账户-安全设置
	 */
	public static final String UC_MENU_SAFE_SETTING="safe_setting";
	/**
	 * 我的账户-个人信息
	 */
	public static final String UC_MENU_PERSONAL_SETTING="personal_setting";
	
	/**
	 * 我的账户-资金往来
	 */
	public static final String UC_MENU_FINANCE_DEAL="finance_deal";
	
	/**
	 * 我的账户-资金账户
	 */
	public static final String UC_MENU_FINANCE_ACCOUNT="finance_account";
	
	/**
	 * 我的项目-认购的项目
	 */
	public static final String UC_MENU_SUBSCRIBE_RPOJECTS="subscribe_projects";
	/**
	 * 我的项目-发布的项目
	 */
	public static final String UC_MENU_MY_RPOJECTS="my_projects";
	/**
	 * 我的项目-关注的项目
	 */
	public static final String UC_MENU_FOCUS_RPOJECTS="focus_projects";
	
	/**
	 * 待审核项目列表
	 */
	public static final String UC_MENU_AUDITING_PROJECTS="auditing_projects";
	
	
	
	
	/**
	 * 对外公示的项目
	 */
	public static final String[] NORMAL_PROJECT_STATES={"prepared","financing","successed"};
	
	/**
	 * 项目类型
	 */
	public static final String DICT_TYPE_PROJECT_TYPE="PORTAL_PROJECT_TYPE";
	
	/**
	 * 项目状态
	 */
	public static final String DICT_TYPE_PROJECT_STATE="PORTAL_PROJECT_STATE";
	
	/**
	 * 付款状态
	 */
	public static final String DICT_TYPE_PAY_STATE="PORTAL_PAY_STATE";
	/**
	 * 交易状态
	 */
	public static final String DICT_TYPE_DEAL_STATE="PORTAL_DEAL_STATE";
	/**
	 * 订单状态
	 */
	public static final String DICT_TYPE_ORDER_STATE="PORTAL_ORDER_STATE";
	
	/**
	 * 是否有效
	 */
	public static final String DICT_TYPE_IS_VALID="PORTAL_IS_VALID";
	
	/**
	 * 认购类型
	 */
	public static final String DICT_TYPE_SUBSCRIBE_TYPE="PORTAL_SUBSCRIBE_TYPE";
	
	/**
	 * 支付方式
	 */
	public static final String DICT_TYPE_PAY_TYPE="PORTAL_PAY_TYPE";
	
	/**
	 * 支持银行的列表
	 */
	public static final String DICT_TYPE_BANK_LIST="PORTAL_BANK_LIST";
	
	/**
	 * 发布项目
	 */
	public static final String PROJECT_STATE_PUBLISHED="published";
	
	/**
	 * 平台受理
	 */
	public static final String PROJECT_STATE_ACCEPTED="accepted";
	/**
	 * 审核项目
	 */
	public static final String PROJECT_STATE_AUDITING="auditing";
	
	/**
	 * 预热项目
	 */
	public static final String PROJECT_STATE_PREPARED="prepared";
	
	/**
	 * 上线融资
	 */
	public static final String PROJECT_STATE_FINANCING="financing";
	/**
	 * 融资成功
	 */
	public static final String PROJECT_STATE_SUCCESSED="successed";
	
	/**
	 * 经营项目
	 */
	public static final String PROJECT_STATE_OPERATING="operating";
	
	/**
	 * 分红项目
	 */
	public static final String PROJECT_STATE_DIVIDENDS="dividends";
	
	
	/**
	 * 热门项目
	 */
	public static final String PROJECT_TYPE_HOT="hot";
	

	/**
	 * 未支付
	 */
	public static final String PAY_STATE_UNPAY="unpay";
	
	/**
	 * 付款确认
	 */
	public static final String PAY_STATE_CONFIRM="confirm";
	/**
	 * 付款成功
	 */
	public static final String PAY_STATE_SUCCESS="success";
	/**
	 * 付款失败
	 */
	public static final String PAY_STATE_FAIL="fail";
	
	
	/**
	 * 交易确认
	 */
	public static final String DEAL_STATE_CONFIRM="confirm";
	/**
	 * 交易完成
	 */
	public static final String DEAL_STATE_FINISH="finish";
	/**
	 * 交易失败
	 */
	public static final String DEAL_STATE_FAIL="fail";
	
	/**
	 * 预购
	 */
	public static final String SUBSCRIBE_TYPE_PREBUY="prebuy";
	
	/**
	 * 购买
	 */
	public static final String SUBSCRIBE_TYPE_BUY="buy";
	
	/**
	 * 账户划款支付
	 */
	public static final String PAY_TYPE_ACCOUNT="account";
	/**
	 * 银行卡支付
	 */
	public static final String PAY_TYPE_BANKCARD="bankcard";
	


}
