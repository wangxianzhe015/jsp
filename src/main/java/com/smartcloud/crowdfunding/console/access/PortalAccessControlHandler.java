/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
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
 * Created on 2013-5-29
 *******************************************************************************/


package com.smartcloud.crowdfunding.console.access;

import java.util.List;

import com.smartcloud.crowdfunding.console.dao.FunctionDao;
import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.platform.component.common.extension.Activate;
import com.smartcloud.platform.component.mvc.User;
import com.smartcloud.platform.component.mvc.security.AccessControlHandler;
import com.smartcloud.platform.component.mvc.service.api.ServiceFactory;

@Activate
public class PortalAccessControlHandler implements AccessControlHandler{

	public PortalAccessControlHandler(){
		
	}
	
	public boolean checkPermission(User currentUser, String mappingUri, String action) {
		try {
			FunctionDao dao=ServiceFactory.getService(FunctionDao.class);
			List<Function> functions=dao.fetchFuncsByRoles(currentUser.getRoleIds());
			for(Function f:functions){
				if(f.getFunctionUrl().startsWith(mappingUri) || "N".equals(f.getModule().getAccessFlag())){
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public int getPriority() {
		
		return 0;
	}

}
