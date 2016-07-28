package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectDoc;
import com.smartcloud.crowdfunding.portal.model.ProjectFocus;
import com.smartcloud.crowdfunding.portal.model.ProjectState;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.SQLQuery;
import com.smartcloud.platform.component.persistence.query.condition.CriteriaQuery;
import com.smartcloud.platform.component.persistence.query.condition.WhereExpression;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class ProjectServiceImpl extends DAOSupport implements ProjectService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public Long publishProject(Project project) {
		if(project.getProjectId()==null){
			this.insert(project);
		}else
			this.update(project);
		
		return project.getProjectId();
	}

	public List<Project> getProjectsByState(Page page,String... projectState) {
		StringBuilder condition=new StringBuilder("(");
		int i=0;
		for(String state:projectState){
			if(i==0)
				condition.append("'").append(state).append("'");
			else{
				condition.append(",").append("'").append(state).append("'");
			}
			i++;
		}
		condition.append(")");
		CriteriaQuery criteria=new CriteriaQuery();
		criteria.setEntityClass(Project.class.getName());
		criteria.appendExpr(new WhereExpression("projectState", "in", condition.toString()));
		return this.executeCriteriaPageQuery(criteria, page);
	}

	public boolean hasUnauditProject(Long userId) {
		return false;
	}

	public void updateProject(Project project) {
		this.update(project);
	}

	public void removeProject(Project project) {
		this.delete(project);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public List<Project> getProjectsByState(String projectState,String sort, String orderby, int lastNumber) {
		if(StringUtils.isBlank(orderby)){
			orderby="project_no,create_time";
		}
		
		if(StringUtils.isBlank(sort)){
			sort="desc";
		}
		//TODO:要避免读取blob字段
		SQLQuery query=(SQLQuery)this.createUnnamedNativeQuery("select * from portal_project where project_state=? order by "+orderby+" "+sort, Project.class).
				setParameter(1, projectState).setMaxResults(lastNumber);
		
		if(Constants.PROJECT_STATE_SUCCESSED.equals(projectState))
			query.setImmediateFetchJoinFields("bonus");
		
		return (List<Project>)query.getResultList();
	}


	public Integer statProjectsByState(String... projectState) {
		String value="";
		for(String s:projectState){
			value="'"+s+"',";
		}
		value=value.substring(0,value.length()-1);
		
		return (Integer)this.createUnnamedNativeQuery("select count(*) from portal_project where project_state in (#projectState#) ",Integer.class).setParameter("projectState", value).getSingleResult();
	}


	public Project getProject(Long projectId) {
		Project project=new Project();
		project.setProjectId(projectId);
		
		return (Project)this.find(project);
	}

	public List<Project> findAllProjects(Project project, Page page) {
		
		return this.executeEntitiesPageQuery(project, page);
	}

	public List<Project> queryProjects(CriteriaQuery query, Page page) {
		
		return this.executeCriteriaPageQuery(query, page);
	}

	public List<Project> getProjectsByType(String projectType,Integer maxResult) {
		SQLQuery query=(SQLQuery)this.createUnnamedNativeQuery("select * from portal_project where project_type=? order by create_time desc", Project.class).
				setParameter(1, projectType).setMaxResults(maxResult);
		
		return (List<Project>)query.getResultList();
	}

	public List<Project> findFocusProjects(String userId, String projectState, Page page) {
		StringBuilder sql=new StringBuilder();
		sql.append("select portal_project.* from portal_project join portal_project_focus on portal_project.project_id = portal_project_focus.project_id and portal_project_focus.user_id=$userId" );
		if(StringUtils.isNotBlank(projectState))
			sql.append(" and portal_project.project_state=$projectState ");
		sql.append(" order by portal_project.create_time desc " );
		
		Map<String,String> params=new HashMap<String,String>();
		params.put("userId", userId);
		params.put("projectState", projectState);
		return this.executeUnnamedNativePageQuery(sql.toString(), null, Project.class, params, new Project(), page);
		
	}

	public List<Project> findPublishProjects(String userId,String projectState, Page page) {
		Project project=new Project();
		project.setUserId(userId);
		if(StringUtils.isNotBlank(projectState))
			project.setProjectState(projectState);
		return this.executeEntitiesPageQuery(project, page);
	}

	
//	public List<ProjectSubscribe> findSubscribeProjects(String userId,String projectState,Page page) {
//		ProjectSubscribe subscribe=new ProjectSubscribe();
//
//		subscribe.setUserId(userId);
//		if(StringUtils.isNotBlank(projectState)){
//			Project project=new Project();
//			project.setProjectState(projectState);
//			subscribe.setProjectId(projectId);
//		}
//
//		return this.executeEntitiesPageQuery(subscribe, page);
//	}

	public List<Project> findSubscribeProjects(String userId,String projectState,Page page) {
	
		Map<String,String> params=new HashMap<String,String>();
		params.put("userId",userId);
		params.put("projectState", projectState);
		
		return (List<Project>)this.executeUnnamedNativePageQuery(
				"SELECT a.*,b.SUBSCRIBE_TYPE as subscribeType FROM portal_project a JOIN portal_project_subscribe b ON a.project_id=b.project_id " +
				"AND b.user_id=$userId #if(${projectState}!='') AND a.project_state=$projectState #end", null, Project.class, params, new Project(), page);
	}

	
	public int addFocusProject(String userId, Long projectId) {
		ProjectFocus focus=new ProjectFocus();
		focus.setFocusTime(DateUtils.getCurrentTime());
		focus.setProjectId(projectId);
		focus.setUserId(userId);
		this.insert(focus);
		return 1;
	}

	public int removeFocusProject(String userId, Long projectId) {
		return this.em.createNativeQuery("DELETE FROM PORTAL_PROJECT_FOCUS WHERE USER_ID=? AND PROJECT_ID=?").setParameter(1, userId).setParameter(2, projectId).executeUpdate();
	}

	public int updateFocusCount(Long projectId, int value) {
		String str="";
		if(value>=0)
			str="+"+value;
		else
			str=String.valueOf(value);
		return em.createNativeQuery("UPDATE PORTAL_PROJECT SET FOCUS_COUNT=FOCUS_COUNT"+str +" WHERE PROJECT_ID=? ").setParameter(1,projectId).executeUpdate();

	}

	public int checkProjectAccessPermission(String userId, Long projectId) {
		Project project=(Project)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT WHERE USER_ID =? AND PROJECT_ID=?", Project.class).setParameter(1, userId).setParameter(2, projectId).getSingleResult();
		if(project==null){
			return -1;
		}else{
			if(ArrayUtils.contains(ProjectState.processingStates,project.getProjectState())){
				return 0;
			}
			else{
				return 1;
			}
		}

	}

	public boolean isAttention(String userId, Long projectId) {
		
		ProjectFocus focus=(ProjectFocus)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_FOCUS WHERE USER_ID=? AND PROJECT_ID=? ", ProjectFocus.class).setParameter(1, userId).setParameter(2, projectId).getSingleResult();
		return focus!=null?true:false;
	}

	public List<Project> findProjectIdAndNames() {
	
		return (List<Project>)em.createNativeQuery("SELECT PROJECT_ID ,PROJECT_STATE,PROJECT_NAME FROM PORTAL_PROJECT ORDER BY PROJECT_NAME,PROJECT_STATE ", Project.class).getResultList();
	}

	public List<Project> getTopProjects() {
		List<Project> projects=em.createNativeQuery("SELECT PROJECT_ID, " +
				"PROJECT_NAME," +
				"PROJECT_DESC," +
				"PROJECT_TYPE," +
				"PROJECT_STATE," +
				"PROJECT_IMAGE," +
				"BACKGROUND_IMAGE," +
				"PROJECT_PROFILE," +
				"PROJECT_PROVINCE," +
				"PROJECT_CITY," +
				"SUBSCRIBE_COUNT,"+
				"FINANCE_AMOUNT," +
				"FOUNDER_INVEST_AMOUNT,"+
				"MIN_INVEST_AMOUNT,"+
				"RAISE_BEGIN_DATE," +
				"RAISE_END_DATE," +
				"PREBUY_BEGIN_DATE,"+
				"PREBUY_END_DATE,"+
				"INDUSTRY_CATEGORY " +
				"FROM PORTAL_PROJECT WHERE IS_TOP='Y' ",Project.class).getResultList();

		return projects;
	}

	public List<Project> getRecommendProjects() {
		List<Project> projects=(List<Project>)em.createNativeQuery("SELECT PROJECT_ID, " +
				"PROJECT_NAME," +
				"PROJECT_DESC," +
				"PROJECT_TYPE," +
				"PROJECT_STATE," +
				"PROJECT_IMAGE," +
				"BACKGROUND_IMAGE," +
				"PROJECT_PROFILE," +
				"PROJECT_PROVINCE," +
				"PROJECT_CITY," +
				"FINANCE_AMOUNT," +
				"RAISE_BEGIN_DATE," +
				"SUBSCRIBE_COUNT,"+
				"MIN_INVEST_AMOUNT,"+
				"FINANCE_PROGRESS,"+
				"MIN_INVEST_AMOUNT,"+
				"FOUNDER_INVEST_RATE,"+
				"FOUNDER_INVEST_AMOUNT,"+
				"FOUNDER_INCOME_RATE,"+
				"INVESTOR_INVERST_RATE,"+
				"INVESTOR_AMOUNT,"+
				"INVESTOR_INCOME_RATE,"+
				"CREATE_TIME,"+
				"RAISE_BEGIN_DATE," +
				"RAISE_END_DATE," +
				"INDUSTRY_CATEGORY " +
				"FROM PORTAL_PROJECT WHERE PROJECT_TYPE='classic' ",Project.class).getResultList();
		return projects;
	}

	public void saveProjectDoc(ProjectDoc projectDoc) {
		Long projectId=(Long)this.em.createNativeQuery("select project_id from portal_project_doc where project_id=?", Long.class).setParameter(1, projectDoc.getProjectId()).getSingleResult();
		if(projectId!=null){
			this.update(projectDoc);
		}else{
			this.insert(projectDoc);
		}
	}

	public void removeProjectDoc(Long projectId) {
		ProjectDoc doc=new ProjectDoc();
		doc.setProjectId(projectId);
		this.delete(doc);
	}

	public ProjectDoc getProjectDoc(Long projectId) {
		ProjectDoc doc=new ProjectDoc();
		doc.setProjectId(projectId);
		return (ProjectDoc)find(doc);
	}
	
	
	
	

}
