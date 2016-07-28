/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/util/ResourceHelper.java,v 1.1 2012/12/04 07:35:18 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:18 $
 *
 *==============================================================================
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 * 
 * Created on 2012-7-25
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.platform.component.mvc.repository.ActionComponentMeta;
import com.smartcloud.platform.component.mvc.repository.ActionRepository;
import com.smartcloud.platform.component.mvc.repository.ActionRepositoryManager;
import com.smartcloud.platform.component.mvc.service.internal.ActionBean;

public class ResourceHelper {

	private static DynaTreeUtil util = new DynaTreeUtil();

	/**
	 * gas/a.b.c.action====>gas/a.b
	 * 
	 * @param path
	 * @return
	 */
	public static Map<String, String> splitPath(String path) {
		Map<String, String> sm = new HashMap<String, String>();
		ActionRepository acr = ActionRepositoryManager.findRepository(path);
		if (acr == null)
			return sm;

		ActionComponentMeta am = acr.getActionComponentMeta(path);
		if (am == null)
			return sm;

		sm.put("moduleName", acr.getModule().getName());
		sm.put("className", am.getActionClass());
		return sm;

	}

	public static List<ActionBean> compareLists(List<ActionBean> functionBeans, List<Function> functions) {
		String[] funcNames = new String[functions.size()];
		for (int i = 0; i < functions.size(); i++) {
			funcNames[i] = functions.get(i).getFunctionName();
		}
		for (ActionBean fb : functionBeans) {
			String mName = fb.getActionName();
			if (util.isInArray(mName, funcNames)) {
				fb.setActionStatus(fb.IS_EXIST);
			}
		}
		return functionBeans;
	}

	public static String convertArrayToString(String[] strs) {
		String str = "";
		for (int i = 0; i < strs.length; i++) {
			String temp = strs[i];
			if (i == strs.length - 1) {
				str += temp;
			} else {
				str += temp + ",";
			}

		}
		return str;
	}

}
