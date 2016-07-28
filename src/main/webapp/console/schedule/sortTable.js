/*
文件说明：这是一个JavaScript脚本文件
功能说明：本脚本程序用来在表格中对指定的列进行页面级排序（升序、降序）
版    本：1.0
修改纪录:
---------------------------------------------------------------------------
时间		    修改人		说明
2003-6-28	ajun		创建
2004-6-21   YuanYi      修改
2005-4-14   陈春         增加中文字符串按拼音或者笔画排序
--------------------------------------------------------------------------- 
使用方法：
<table id="sortTable" >
<tr>
 <td onClick="sort()" title="点击排序">第1列</td>
 <td onClick="sort()" title="点击排序">第2列</td>
 <td onClick="sort()" title="点击排序">第3列</td>
 <td onClick="sort()" title="点击排序">第4列</td>
 <td onClick="sort()" title="点击排序">第5列</td>
</tr>
<tr>
......
</tr>
</table>
*/

document.write('<style type="text/css">')
document.write(".arrow {")
document.write(" FONT-FAMILY: Marlett; TOP: 2px;")
document.write("}")
document.write("</style>")

var isSorting = false;
var charMode  = true;  //指定是按拼音还是按笔画排序,true为拼音,false为笔画

var dom = (document.getElementsByTagName) ? true : false;
var ie5 = (document.getElementsByTagName && document.all) ? true : false;
var arrowUp, arrowDown;

if (ie5 || dom)
	CreateArrow();
	
/*
功能说明：创建降序、升序的显示箭头
*/
function CreateArrow() {
	arrowUp = document.createElement("SPAN");

	var tn = document.createTextNode("↑");
	arrowUp.appendChild(tn);
	
	arrowUp.className = "arrow";

	arrowDown = document.createElement("SPAN");

	var tn = document.createTextNode("↓");
	arrowDown.appendChild(tn);

	arrowDown.className = "arrow";
}

/*
功能说明：对指定表格的列进行交错排序
使用说明：降序、升序交错执行（第一次点击为降序）
参数说明：tablename  要排序的表格名称，默认为sortTable
		 colIndex	 当前要排序的列
*/
function sort(tablename,colIndex)
{

	var tobject;	
	if(tablename==null)
		tobject=getobj("sortTable");
	else
		tobject=getobj(tablename);
		
	if(tobject==null)
	{
		alert(gov_i18n_sortTable_pleaseSpecifyTableToSort);
		return;
	}

	//为了防止重复点击造成排序混乱，设定一个标志，在上一次排序没有完成前，不再次进行排序
	if (isSorting) return;	
	isSorting = true;
	
	//提取<td>的属性
	var event = window.event || arguments.callee.caller.arguments[0];
	parentTD =  event.srcElement || event.target;
   	while ( parentTD )
   	{
      	if ( parentTD.tagName=="TD" )
        	break;
      	parentTD=parentTD.parentElement||parentTD.parentNode;
   	}
	var value = parentTD.getAttribute("SORT");
	var parentTDparent=parentTD.parentElement||parentTD.parentNode;
	
	if(value==null || value=="DESC")
	{
		sortColumn(false,colIndex==null?parentTD:'null',tobject,colIndex);
		parentTD.setAttribute("SORT","ASC");
		HiddenArrow(parentTDparent);
		parentTDparent.arrow = arrowDown.cloneNode(true);
		parentTD.appendChild(parentTDparent.arrow);
	}
	else
	{
		sortColumn(true,colIndex==null?parentTD:'null',tobject,colIndex);	
		parentTD.setAttribute("SORT","DESC");
		HiddenArrow(parentTDparent);
		parentTDparent.arrow = arrowUp.cloneNode(true);
		parentTD.appendChild(parentTDparent.arrow);
	}
	isSorting = false;
}


function HiddenArrow(TRobject)
{
	if (TRobject.arrow != null) {
		TRobject.arrow.parentNode.removeChild(TRobject.arrow);
	}
}

/*
function sortColumn(type,Eobject,tobject,colindex)
功能说明：对指定的列进行指定的排序

参数说明：
bASC:	排序的规则：true 升序、 false 降序
Eobject:当前鼠标点击的对象(如果为null，表示指定了排序列)
tobject:要排序的表格对象
colindex:当前要排序的列
*/
function sortColumn(bASC,Eobject,tobject,colindex)
{
	//取得表格体的对象
	var tBody = tobject.tBodies[0];
	//取得指定的排序列
	colindex=colindex==null?0:colindex;
	//取得当前要排序的列
	var column = Eobject=="null"?colindex:Eobject.cellIndex;
	
	//取得表格的总行数
	var rows = tobject.rows;
    var absRowsLength = rows.length;
	//这里过滤表格底部的数据
    if(tobject.tFoot) 
	{
		absRowsLength -= tobject.tFoot.rows.length;
	}
	//这里过滤表格头部的数据(默认为1,这样处理是防止表格头有多行的情况)
	var row_start = 1;
	if(tobject.tHead) 
	{
		row_start = tobject.tHead.rows.length;
	}
	
	var a = new Array();
	var valueColumn;
	for (var i=0; i<absRowsLength-row_start; i++) 
	{
		a[i] = rows[i+row_start];
		valueColumn = a[i].cells[column].innerText;
		valueColumn = (valueColumn == null ? "" : valueColumn.trim());
		var cell=a[i].cells[column];
		if (cell.textContent){
			cell.textContent=valueColumn;			
		}else{
			cell.innerText=valueColumn;
		}
	}
	a.sort(compareByColumn(column,bASC));
	for (var i = 0; i < a.length; i++)
	{
		a[i].className=(i%2==0?"result_content":"result_content_");
		a[i].cells[column].innerHTML=a[i].cells[column].innerHTML==""?"&nbsp;":a[i].cells[column].innerHTML;
		tBody.appendChild(a[i]);
	}
}

/*
function compareByColumn(nCol, bAscending)
功能说明：用来确定元素顺序的函数

参数说明：
nCol:		进行排序的列
bAscending:	是否降序
*/
function compareByColumn(nCol, bAscending) {
	var c = nCol;
	var d = bAscending;

	function _compare(n1, n2) {
		var v;
		try {
			var s1 = n1.cells[c].innerText || n1.cells[c].firstChild.eibValue || n1.cells[c].firstChild.value || n1.cells[c].firstChild.innerText;
			var s2 = n2.cells[c].innerText || n2.cells[c].firstChild.eibValue || n2.cells[c].firstChild.value || n2.cells[c].firstChild.innerText;					
			s1 = s1.replace(/[,\:\-\ ]/g,"");
			s2 = s2.replace(/[,\:\-\ ]/g,"");
			var f1 = parseFloat(s1);
			var f2 = parseFloat(s2);
			s1 = s1.toLowerCase();
			s2 = s2.toLowerCase();
			if (!isNaN(f1) && !isNaN(f2))
			{
				// sorting numbers
				if (f1 < f2) v = (d) ? -1 : +1;
				else if (f1 > f2) v = (d) ? +1 : -1;
				else v = 0;
			}
			else
			{
				// sorting strings
				s1=s1.toString();
				s2=s2.toString();
				if(s1.charCodeAt(0)>=19968 && s2.charCodeAt(0)>=19968){
					v = judge_CN(s1,s2,d);
				}else{
					v = d?(s1>s2?1:(s1<s2?-1:0)):(s1<s2?1:(s1>s2?-1:0));
				}
			}
		} catch(e) { v = 0; }

		return v;
	}
	
	return _compare;
}

function getobj(mtxt)  /* Get object by object name */
{
  if (document.getElementById) {
      m=document.getElementById(mtxt);
  } else if (document.all) {
      m=document.all[mtxt];
  } else if (document.layers) {
      m=document.layers[mtxt];
  }
  return m;
}

var charPYStr = "拼音";
var charBHStr = "编号";
function judge_CN(char1,char2,mode){
	var charSet=charMode?charPYStr:charBHStr;
	for(var n=0;n<(char1.length>char2.length?char1.length:char2.length);n++){
		if(char1.charAt(n)!=char2.charAt(n)){
			if(mode) return(charSet.indexOf(char1.charAt(n))>charSet.indexOf(char2.charAt(n))?1:-1);
			else	 return(charSet.indexOf(char1.charAt(n))<charSet.indexOf(char2.charAt(n))?1:-1);
			break;
		}
	}
	return(0);
}
