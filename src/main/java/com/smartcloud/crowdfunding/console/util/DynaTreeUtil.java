package com.smartcloud.crowdfunding.console.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;


/**
 * 根据module_path取父节点
 * 
 * @author dgw
 * 
 */
public class DynaTreeUtil {

	/**
	 * 处理path，path由父元素的主键和当前主键由","拼接而成
	 * 
	 * @param path
	 * @return
	 */
	public Map<String, String> dealPath(String path) {

		Map<String, String> pathMap = new HashMap<String, String>();
		if (path.contains(",")) {
			String parentPath = StringUtils.substringBeforeLast(path, ",");
			String attrId = StringUtils.substringAfterLast(path, ",");
			pathMap.put("parentPath", parentPath);// 获得父节点
			pathMap.put("attrId", attrId);// 获得主键
			// TODO 获得根节点(总机构或者主模块)
		}
		return pathMap;

	}

	/**
	 * 此方式没用递归，全部取出来根据path判断归属的,这样可以具体判断哪个是选中的，然后选中的全部expend。
	 * 
	 * 将树生成dynaTree的json数据的格式，并赋样式，初始化无格式树,适用于表自身关联(比如 模块树和 机构树)
	 * 
	 * @param groups
	 * @return
	 */
	public Map<String, TreeNodeBean> createTreeNodes(Map<String, TreeNodeBean> groups) {
		Set<Entry<String, TreeNodeBean>> ent = groups.entrySet();
		if (ent.size() > 0) {
			for (Entry<String, TreeNodeBean> entry : ent) {
				String path = entry.getKey();
				TreeNodeBean tbean = entry.getValue();

				if (path.contains(",")) {
					String parentPath = dealPath(path).get("parentPath");
					TreeNodeBean parentTbean = groups.get(parentPath);

					List<TreeNodeBean> clist = parentTbean.getChildren();
					if (clist == null) {
						clist = new ArrayList<TreeNodeBean>();
					}
					clist.add(entry.getValue());// 作为children给加进来
					parentTbean.setChildren(clist);
					parentTbean.setIsFolder(true);// 有子节点才设置为folder样式
					// 如果当前状态为select=true或者exptend=true或者active=true时才调用
					if (tbean.getSelect() || tbean.getExpand() || tbean.getActivate()) {
						setNodeStateExpand(groups, tbean);
					}
					groups.put(parentPath, parentTbean);
				}
			}
		}
		return groups;

	}

	/**
	 * 当前被select或者active为true的节点和groups为参数，设置此节点和所有父节点的exptend为true
	 * 
	 * @param groups
	 * @param tbean
	 */
	public void setNodeStateExpand(Map<String, TreeNodeBean> groups, TreeNodeBean tbean) {
		if (tbean.getSelect() || tbean.getExpand() || tbean.getActivate()) {
			String path = tbean.getKey();
			if (path.contains(",")) {
				TreeNodeBean paTBean = groups.get(dealPath(path).get("parentPath"));
				paTBean.setExpand(true);
				setNodeStateExpand(groups, paTBean);
			}

		}

	}

	/**
	 * 根据树节点的children的状态展开树节点
	 * 
	 * @param tbean
	 * @param children
	 * 
	 * @created at 2012-11-16下午02:01:20
	 */
	public void expandNodeByChildren(TreeNodeBean tbean, List<TreeNodeBean> children) {
		for (TreeNodeBean treeNodeBean : children) {
			if (treeNodeBean.getSelect() || treeNodeBean.getActivate() || treeNodeBean.getExpand()) {
				tbean.setExpand(true);
			}
		}
	}

	/**
	 * 判断s是否存在于数组ss中
	 * 
	 * @param s
	 * @param ss
	 * @return
	 */
	public boolean isInArray(String s, String[] ss) {
		if (ss == null || ss.length == 0) {
			return false;
		}
		for (String tmp : ss) {
			if (s.equals(tmp)) {
				return true;
			}
		}
		return false;
	}

}
