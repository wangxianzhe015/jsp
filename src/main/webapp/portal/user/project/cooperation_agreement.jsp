<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta name="copyright" content="众投客">
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="众投客电子协议预览"></c:set>
	<%@include file="../../common/meta.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/font-awesome.css">

<style>
body {
	margin: 0;
	padding: 0;
	font-family: "Microsoft Yahei";
	background: #fff;
}

.wap_contract {
	overflow-y: scroll;
	height: 500px;
	width: 1024px;
	margin: 0 auto;
	margin-top: 50px;
}

.contract_html {
	width: 900px;
	margin: 0 auto;
	min-height: 600px;
}

.contract_html h4 {
	text-align: center;
}

table {
	border-collapse: collapse;
	font-size: 14px;
	font-family: Microsoft Yahei;
}

table td {
	border: solid #000 1px;
	padding: 8px;
}

</style>
</head>
<body>
	<%@include file="../../common/uc_header.jsp"%>
	<form class="form" method="post" action="<%=servletPath%>/portal/uc/entryPay.action">
		<input type="hidden" name="orderId" value="${order.orderId }"/>
		<div class="wap_contract">
			<div class="contract_html">
				<p class="MsoNormal" style="text-align:center;">
					<strong><span style="font-size:16px;">股权众筹投资合作协议</span></strong>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal">
					甲方（投资人）：&nbsp;<span
						style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">&nbsp;${user.realName }</span>
				</p>
				<p class="MsoNormal">
					<br>
				</p>
				<p class="MsoNormal"></p>
				<table style="width:100%;" cellpadding="2" cellspacing="0"
					border="1" bordercolor="#000000">
					<tbody>
						<tr>
							<td><span
								style="font-family:宋体;font-size:14px;line-height:21px;">用户信息</span><br>
							</td>
							<td><span
								style="font-family:宋体;font-size:14px;line-height:21px;">投资金额（元）</span><br>
							</td>
							<td><span
								style="font-family:宋体;font-size:14px;line-height:21px;">持股比例</span><br>
							</td>
						</tr>
						<tr>
							<td>
								<p class="MsoNormal">
									<span style="font-family:宋体;font-size:10.5pt;">注册手机号：<span
										style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">${user.mobileNo }&nbsp;</span></span><span
										style="font-family:Calibri;font-size:10.5pt;"></span>
								</p>
								<p class="MsoNormal">
									<span style="font-family:宋体;font-size:10.5pt;">姓名：<span
										style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">&nbsp;${user.realName }</span></span><span
										style="font-family:Calibri;font-size:10.5pt;"></span>
								</p>
								<p class="MsoNormal">
									<span style="font-family:宋体;font-size:10.5pt;">身份证号：<span
										style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">&nbsp;${user.identityCard }</span></span>
								</p> <br>
							</td>
							<td><span
								style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">${order.totalAmount }</span><br>
							</td>
							<td><span
								style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">0.1000</span><br>
							</td>
						</tr>
					</tbody>
				</table>
				<p></p>
				<p class="MsoNormal">
					<br>
				</p>
				<p class="MsoNormal">乙方：福建众投客投资管理有限公司&nbsp;</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal">
					营业执照注册号：110108019292109&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal">
					法定代表人：&nbsp;方黄鸿&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</p>
				<p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</p>
				<p class="MsoNormal" style="text-indent:20.65pt;">特别提示：</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					甲方、乙方请认真阅读本合同项下的全部条款。本合同一旦签订本合同，即认为各方已理解并同意本合同的所有条款。</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">鉴于：</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					1<span>、甲方为众投客平台（</span><span>www.&nbsp;zhongtouke&nbsp;.com</span><span>）的注册会员，已在众投客平台充值并投资众投客发布的【${order.project.projectName }】项目（项目地址：</span>${order.project.provinceName }${order.project.cityName }${order.project.address }），该项目由${order.project.companyName }（以下简称“项目公司”）经营管理。
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					2<span>、甲方自愿委托乙方作为自己对项目公司出资的名义持有人，代持甲方所投资股权，所投资款项由乙方增资入股至项目公司。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					3<span>、在投资之前，甲方已被充分告知和了解《风险提示书》所提示投资风险，并严格遵守众投客平台规则（包括不限于《注册服务协议》、平台公告）。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					根据《中华人民共和国合同法》及相关法律法规的规定，各方遵循平等、自愿、互利和诚实信用原则，&nbsp;友好协商，&nbsp;就各方在众投客平台&nbsp;（&nbsp;域名为<span>www.&nbsp;zhongtouke.com</span><span>，</span><span>"</span><span>众投客</span><span>"</span><span>，以下简称平台）上进行投资、融资、投资咨询、风险管理及投后管理服务达成一致，以兹信守。</span>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.65pt;">
					第一条&nbsp;投资合作事项</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					1.1&nbsp;<span>甲方投资【&nbsp;&nbsp;<span
						style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">${order.totalAmount }</span>&nbsp;&nbsp;&nbsp;】元持有项目公司【&nbsp;<span
						style="font-family:&#39;Lucida Grande&#39;, Verdana, Arial, sans-serif;line-height:19.2000007629395px;">0.1000</span>&nbsp;&nbsp;】
					</span><span>%</span><span>股权（以下简称“受让股权”）。同时甲方自愿委托乙方作为自己受让股权的名义持有人，不再进行工商变更登记。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					1.2&nbsp;<span>乙方确认，在签署本协议时甲方已在众投客平台将投资款项汇入平台指定账户，投资款项已由众投客平台监管支付给乙方。</span>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					第二条&nbsp;投资权益达成&nbsp;&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					2.1<span>【${order.project.projectName }】按自然月（即每月</span><span>1</span><span>日至月末</span><span>31</span><span>日）进行利润分红，最晚分红日为每自然月结束后次月</span><span>15</span><span>日之前出具财务报表并发放红利。所发红利汇至本协议第三条账户中。</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					2.2&nbsp;<span>分红原则为当月剩余全部净利润进行分红，即分红前应先行支付福建众投客网络科技有限公司</span><span>3%</span><span>净利润收益作为提供股权众筹服务的服务对价，再将剩余全部净利润进行分配。如发生需要店面装修、升级设备、扩建等费用由项目公司在利润中提取，但乙方或公司应至少提前一月告知甲方。&nbsp;</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					2.3&nbsp;<span>分红收益具体数额以项目公司财务部门出具的财务报表为准，产生税费由各自承担。</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					2.4&nbsp;<span>分红起始月为【</span><span>2015</span><span>】年【</span><span>10</span><span>】月。&nbsp;&nbsp;</span>
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					2.5第三方支付费用。由于融资及分红都是通过第三方支付进行，甲方在每次分红中需要支付该分红金额千分之二的第三方支付管理费用，若需提现则甲方还需向第三方平台支付每人每笔2元的提现费用，上述费用可以从<B>${order.project.projectName }</B>项目的分红中扣除，不需要甲方额外支付。如第三方支付调整支付费用，甲乙双方再另行协商约定该等费用的金额和支付事宜。
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					第三条&nbsp;甲方专用账号</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					3.1&nbsp;<span>乙方应将其未来所收到的项目公司的任何投资收益（包括但不限于现金股息、红利及其他收益分配等）按本协议</span><span>1.1</span><span>条约定支付给甲方（具体应支付至甲方在众投客网站注册绑定的账户）。</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					3.2&nbsp;<span>如甲方在众投客网站注册绑定的账户需要变更，甲方可向众投客平台申请进行变更，具体以众投客平台最终确认的账号为准，账户户主必须与甲方一致。</span>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">第四条&nbsp;股权转让</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					4.1&nbsp;<span>甲方如需转让其持有的股权，仅限于在众投客股权转让平台进行转让，在众投客平台转让成功后，由乙方及众投客平台协助办理股权转让手续，但甲方不得私自转让。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					4.2&nbsp;<span>根据国家现有政策、法规规定众投客平台无法上线股权转让系统，现有甲方所受让股权与公司共负盈亏，待后期股权转让政策明晰后再行转让（详见本协议</span><span>8.3</span><span>条流动性风险）。</span>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					第五条&nbsp;甲方的权利与义务</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.1&nbsp;<span>甲方承诺并保证其已充分了解并知晓投资项目的风险，其使用众投客平台服务的风险以及根据自身判断做出投资决定所造成的风险由其自行承担。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.2&nbsp;<span>甲方享有公司按照所持股权比例分红的权利，甲方取得的分红属于个人收入，甲方应按国家规定的税务法交纳个人所得税；作为受托代持人的乙方有权在甲方未按照此条款执行的情况下对甲方所得分红的税收进行追回以统一缴纳。。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					5.3<span>甲方仅享有分红权，甲方不参与项目公司经营活动管理与监督、不行使其他公司股东的权利，由乙方决断并行使作为公司股东的权利。鉴于股权众筹的特殊性，为保证甲方不能随意干预项目公司的正常经营活动，同时为保证沟通的效率，甲方可向乙方或众投客平台反馈项目公司出现的问题，但不得越过乙方直接与项目公司对接。同时针对甲方反馈的问题，乙方原则上一个月向项目公司筛选集中反馈一次。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.4&nbsp;<span>如因甲方扰乱项目公司正常经营给项目公司造成恶劣影响或恶意诋毁众投客平台，乙方有权对甲方在交流平台的发言进行屏蔽，情节特别严重的，乙方有权清退甲方股东资格，如发生清退，由乙方进行回购，回购价款为股权转让价款扣除累计分红金额所剩余的金额，如累计分红金额大于股权转让价款，则直接取消甲方股东资格不再退款。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					5.5<span>鉴于互联网众筹的特殊性，甲方委托乙方代持甲方在项目公司的股权，该委托不可撤销，如后期发生乙方不适合继续代持的，由乙方或众投客另行指定代持人，仅需通知甲方即可。甲方以隐名股东身份持股，甲方不得要求乙方进行工商登记变更为股东名册的具名股东。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.6&nbsp;<span>甲方有义务按照众投客平台要求向乙方提供真实的个人信息，因甲方提供虚假信息而造成的一切法律后果（包括但不限于民事赔偿，行政处罚等）均由甲方承担。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.7&nbsp;<span>甲方有义务按照众投客要求操作平台软件以及查收众投客平台发出的所有消息（包括但不限于站内通知、电子邮件、手机短信等）。因甲方个人操作不当以及疏于查收信息造成的损失由甲方自行承担。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.8&nbsp;<span>投资人承诺并保证依据自身判断对众投客平台上发布的项目做出独立的投资决定、审慎发出投资意向；投资人承诺其所发出的投资意向为其真实的、不可撤销的意思表示，保证依据其发出的投资意向实施投资行为；并保证依法、依约完成其通过使用众投客平台提供的服务而达成的各项交易。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.9&nbsp;<span>甲方对分红收益或公司经营状况存在疑问的，为确保项目公司日常工作避免不必要的干扰，仅可向乙方或众投客平台申请，由乙方或众投客平台指定的第三方中介机构就本项目投资人反馈的财务问题核对公司财务状况进行审核或要求公司出具说明，但应保证不予泄露公司的商业秘密。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					5.10&nbsp;<span>如项目公司发生经营困难或其他事项无法继续经营的，公司依据《公司法》规定进入破产清算程序。进行破产清算时，项目公司的破产财产优先支付北京众投客网络技术有限公司因提供股权众筹服务的服务对价，再由甲方根据持股比例对剩余破产财产进行分配。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					第六条&nbsp;乙方的权利与义务</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.1<span>乙方应当按照本协议的规定，恪尽职守，以诚实、守信、审慎、有效管理的原则履行股东义务。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.2<span>依照本协议第四条所述的股权转让政策出台后，在不影响其他投资人、乙方、项目公司的前提下，若甲方拟将相应出资所对应的权益转移到指定的任何第三人名下时，乙方应提供必要的协助，并及时做好备案工作，向受让方出具出资证明文件。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.3<span>乙方作为公司的登记股东，有权依据公司法及公司章程的规定以股东身份参与公司的经营管理及对公司的经营管理进行监督。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.4&nbsp;<span>未经甲方事先书面同意，乙方不得转委托第三方持有上述代持股权及其股东权益。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.5&nbsp;<span>乙方承诺将其未来所收到的因代持股权所产生的任何投资收益（包括但不限于现金股息、红利或任何其他收益分配等）按本协议约定全部转交甲方。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.6&nbsp;<span>乙方应保证所代持股权权属的完整性和安全性，非经甲方书面同意，乙方不得处置代持股权，包括但不限于转让，赠与、放弃或在该等股权上设定质押等；</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.7&nbsp;<span>若因乙方的原因，如债务纠纷等，造成代持股权被查封，乙方应提供其他任何财产向法院、仲裁机构或其他机构申请解封，如给甲方造成损失的，应当承担赔偿责任。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.8&nbsp;<span>乙方不得利用名义股东身份做出损害甲方股东权益的行为，以此造成的一切责任由乙方承担。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					6.9&nbsp;<span>自本协议签订之日起不定期召开线上会议或线下见面会，由乙方或众投客平台说明公司管理运营等情况，上述会议由众投客平台召集。</span>
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					第七条&nbsp;投资风险提示</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					甲方所投资事宜包括但不限于以下风险：</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.1&nbsp;<span>投资回报风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					甲方所投资为股权投资，有别于债权型产品投资，无固定回报。同时公司可能面临无回报或产生的盈利被用于再生产，投资人可能面临投资没有任何回报的可能。
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.2&nbsp;<span>投资损失风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					公司可能面临投资出现部分<span>/</span><span>全部亏损甚至破产的可能，作为投资人应根据自己的风险承受能力选择投资额度。</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.3&nbsp;<span>流动性风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					被投资标的公司的股权，众筹股权流动市场尚未成熟，存在所投资股权转让时无受让人之可能。</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.4&nbsp;<span>股权被稀释的风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					公司可能面临多轮融资的局面，当企业进行多轮融资时，投资人所持股权比例将因其他投资者的进入而存在降低的可能，随后会影响到甲方在企业的分红权等。
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.5&nbsp;<span>破产清算时赔付次序劣后的风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					若公司经营状况不佳，陷入破产风险时，公司资产会优先赔付职工工资、所欠税款及其他债权人的债务，投资人的赔偿顺位劣后。</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					7.6&nbsp;<span>政策风险</span>
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">
					股权众筹投资是针对当前的相关法律法规和政策设计的。如国家宏观政策以及市场相关法规政策发生调整变化，可能影响投资的受理、投资、回报等的正常进行，甚至存在出现投资金额损失的可能。
				</p>
				<p class="MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">第八条&nbsp;特殊条款</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					甲方投资成功成为股东后享受的的权益如下：</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					8.1股东可以享受每投资1份获得有效期为1年的入住1晚免费券1张（限制标单/标双），可同时在广州速8酒店黄石店（地址：广州市白云区黄石西路小坪东路32号）、东圃店使用，不限本人使用。
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					8.2股东可获得1张价格38元速8酒店VIP卡，全国通用，可享受门店价8.8折优惠。</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					8.3股东入住广州速8酒店黄石店、东圃店，使用会议室可享受门店价8折优惠。</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					8.4股东如一次性投资5份以上，获得1张价格188元速8酒店白金卡，全国通用，可享受门店价8.2折优惠（白金卡和VIP卡不能重复拥有）。
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">第九条&nbsp;通知送达
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					根据本协议需要一方向另一方发出的全部通知及与本合同有关的通知和要求等，将由众投客平台以站内通知、电子邮件、手机短信等形式发布。甲方应及时关注众投客发布的通知。手机号及邮箱信息以在众投客注册时的联络信息为准，若乙方采取数据电文的形式通知，该数据电文进入甲方指定收件系统视为通知到达。如因甲方原因登记联络信息错误或个人操作不当以及疏于查收信息造成的损失由甲方自行承担。
				</p>
				<p class="MsoNormal" style="text-indent:20.25pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">第十条&nbsp;保密条款</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					协议双方对本协议履行过程中所接触或获知的对方的任何商业信息均有保密义务，除非有明显的证据证明该等信息属于公知信息或者事先得到对方的书面授权。该等保密义务在本协议终止后仍然继续有效。任一方因违反该等义务而给对方造成损失的，均应当赔偿对方的相应损失。
				</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					第十一条&nbsp;违约责任&nbsp;&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					本协议正式签订后，任何一方不履行或不完全履行本协议约定条款的，即构成违约。违约方应当负责赔偿其违约行为给守约方造成的一切直接和间接的经济损失。
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">第十二条&nbsp;不可抗力
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					本协议所指不可抗力事件系指<span>:</span><span>发生台风、洪水、冰雹、地震、海啸、火灾、旱灾、大雪、山崩等自然灾害事件；发生征收、征用、法令、政策、政府或公共机关禁止等政府行为事件；罢工、骚乱、黑客攻击等社会异常事件；其他任何一方无法预见、无法控制和无法避免的事件。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					若发生了不可抗力事件导致任何一方或各方不能履行其任何的契约性义务，该等义务应在不可抗力事件存在时暂停，而义务的履行期应自动按暂停期顺延而不加以处罚。
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					遭遇不可抗力的一方或各方应在发生不可抗力事件后的十天内向其他方提供发生不可抗力和其持续期的适当证明，并应尽其最大努力终止不可抗力事件或减少其影响。
				</p>
				<p class="MsoNormal" style="text-indent:21.0000pt;">
					发生不可抗力事件时，各方应立即磋商以寻求一个公平的解决方法，并应采用所有合理努力以减轻不可抗力的影响。</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					第十三条&nbsp;争议的解决</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					凡因履行本协议所发生的争议，甲、乙双方应友好协商解决，协商不能解决的，任一方均有权将争议提请至北京市海淀区人民法院进行诉讼。</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">第十四条&nbsp;其他事项
				</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					14.1<span>本协议一式贰份，&nbsp;双方同意，由于互联网股权众筹的特殊性，</span>由甲方网上电子点击“我已阅读并同意该协议内容”同意确认本协议且乙方对该空白协议加盖公章，本协议即生效。
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					14.2&nbsp;<span>本协议乙方签章后邮寄至甲方发生的邮寄费用由乙方在甲方首月分红费用中直接扣除。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					14.3&nbsp;<span>甲方需妥善保管此协议，如后期安排股权转让需甲方将此协议退还给乙方或众投客平台，如因合同丢失所产生的不便与损失由甲方自行负责，乙方不承担责任。</span>
				</p>
				<p class="MsoNormal" style="text-indent:21.1pt;">
					14.4&nbsp;<span>如因法规、政策变更或优化管理等其他原因需要改变本协议约定的投资模式，在保证甲方所</span>持有的公司股权分红权益不变的情况下，甲方全权委托乙方办理相关手续变更（如授权签字等），且只需通知甲方即可，该委托不可撤销。
				</p>
				<p class="MsoNormal" style="text-align:center;">（以下为签章部分，无正文）</p>
				<p class="MsoNormal" style="text-indent:21pt;">甲方：</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:105pt;">
					年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</p>
				<p class="MsoNormal">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">
					乙方（签章）：福建众投客投资管理有限公司</p>
				<p class="MsoNormal" style="text-indent:21pt;">&nbsp;</p>
				<p class="MsoNormal" style="text-indent:21pt;">法定代表人（签章）：</p>
				<p class="MsoNormal" style="text-indent:105pt;">
					年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					&nbsp; &nbsp;</p>
			</div>
		</div>
		<div
			style="margin: 0 auto;width:900px;text-align:center;padding:20px;">
			<button type="submit" style="background:#3498DB !important;color:#fff;border:none;font-family:Microsoft Yahei;width:200px;height:36px;">我已阅读并同意该协议内容</button>
		</div>
	</form>
</body>
</html>