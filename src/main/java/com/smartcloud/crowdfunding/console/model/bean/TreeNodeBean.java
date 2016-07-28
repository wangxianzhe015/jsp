package com.smartcloud.crowdfunding.console.model.bean;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;

/**
 * 树的基本属性
 * 
 * DynaTreeNode< this.data.key>: this.data.title ;
 * 
 * 现改成return
 * "{path:"+this.data.key+"},{name:"+this.data.title+"},{attrId:"+this.
 * data.attrId+"}";
 * 
 * @author dgw
 * 
 */
public class TreeNodeBean {
	public static final String NODE_TYPE_MODULE = "module";
	public static final String NODE_TYPE_APP = "app";
	public static final String NODE_TYPE_FUNCTION = "function";
	public static final String NODE_TYPE_USER = "user";
	public static final String NODE_TYPE_ORG = "org";
	public static final String NODE_TYPE_EMPLOYEE = "employee";
	public static final String PERSIST_STATE_EXIST = "exist";// 节点在库中已经存在

	private String attrId;// 主键

	private String title;// 对应组织名称bean.Name

	private String key;// 对应这每个部门的bean.Path,就是(上级Id,当前节点id)

	private boolean isFolder;// 有子部门就为true

	private boolean isLazy;// 是否懒加载

	private boolean expand;// 是否展开(当前的展开，没有初始化就不展开)js端默认值是false

	private String tooltip;// 带的tooltip：提示信息，不是必须

	private String icon;// 图片:不是必须

	private boolean select;// 是否可以选择都可以选则,用默认值

	private boolean activate;// 激活状态

	private boolean unselectable;// 是否可选(在权限地方可以用)

	private boolean hideCheckbox;// 主分组目录隐藏checkbox

	private String addClass;// 新增一个string属性控制node.span的样式,样式class定义在resource/dynatree/src/skin/ui.dynatree.css中

	private List<TreeNodeBean> children = new ArrayList<TreeNodeBean>();// 子元素

	private String nodeType;// 节点类型
	
	private String persistState;// 初始化节点选中，判断节点数据在库中的是否存在
	
	private int displayNo;
	

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public boolean isHideCheckbox() {
		return hideCheckbox;
	}

	public void setHideCheckbox(boolean hideCheckbox) {
		this.hideCheckbox = hideCheckbox;
	}

	public String getAttrId() {
		return attrId;
	}

	public void setAttrId(String attrId) {
		this.attrId = attrId;
	}

	public void setChildren(List<TreeNodeBean> children) {
		this.children = children;
	}

	public List<TreeNodeBean> getChildren() {
		return children;
	}

	public boolean getActivate() {
		return activate;
	}

	public void setActivate(boolean activate) {
		this.activate = activate;
	}

	public boolean getExpand() {
		return expand;
	}

	public void setExpand(boolean expand) {
		this.expand = expand;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public boolean getSelect() {
		return select;
	}

	public void setSelect(boolean select) {
		this.select = select;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTooltip() {
		return tooltip;
	}

	public void setTooltip(String tooltip) {
		this.tooltip = tooltip;
	}

	public String toJSON() {
		return JSON.toJSONString(this);
	}

	public boolean getUnselectable() {
		return unselectable;
	}

	public void setUnselectable(boolean unselectable) {
		this.unselectable = unselectable;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public boolean getIsFolder() {
		return isFolder;
	}

	public void setIsFolder(boolean isFolder) {
		this.isFolder = isFolder;
	}

	public boolean getIsLazy() {
		return isLazy;
	}

	public void setIsLazy(boolean isLazy) {
		this.isLazy = isLazy;
	}

	public String getPersistState() {
		return persistState;
	}

	public void setPersistState(String persistState) {
		this.persistState = persistState;
	}

	public String getAddClass() {
		return addClass;
	}

	public void setAddClass(String addClass) {
		this.addClass = addClass;
	}

	public int getDisplayNo() {
		return displayNo;
	}

	public void setDisplayNo(int displayNo) {
		this.displayNo = displayNo;
	}
	
	

}
