package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectDoc;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.condition.CriteriaQuery;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectService {
	
	
	/**
	 * 获取置顶项目
	 * @return
	 */
	public List<Project> getTopProjects();
	
	/**
	 * 获取推荐项目
	 * @return
	 */
	public List<Project> getRecommendProjects();

	/**
	 * 发布项目
	 * @param project
	 * @return 项目ID
	 */
	public Long publishProject(Project project);
	
	
	/**
	 * 分页查询所有项目
	 * @param project
	 * @param page
	 * @return
	 */
	public List<Project> findAllProjects(Project project,Page page);
	
	
	/**
	 * 查找所有项目名称
	 * @return
	 */
	public List<Project> findProjectIdAndNames();
	
	
	/**
	 * 根据项目状态获取的项目列表
	 * @param projectState 项目状态
	 * @param page 分页对象
	 * @return
	 */
	public List<Project> getProjectsByState(Page page,String... projectState);
	
	
	/**
	 * 项目综合查询
	 * @param query 查询条件对象
	 * @param page 分页对象
	 * @return
	 */
	public List<Project> queryProjects(CriteriaQuery query,Page page);
	
	/**
	 * 获取项目信息
	 * @param projectId
	 * @return
	 */
	public Project getProject(Long projectId);
	/**
	 * 获取项目状态获取项目列表
	 * @param projectState 项目状态
	 * @param sort 排序方式 (DESC/ASC)
	 * @param orderby 排序字段
	 * @param lastNumber 最近的项目个数
	 * @return
	 */
	public List<Project> getProjectsByState(String projectState,String sort, String orderby, int lastNumber);
	
	/**
	 * 判断当前用户是否存在未审核的项目
	 * @param userId
	 * @return
	 */
	public boolean hasUnauditProject(Long userId);
	
	
	/**
	 * 修改项目
	 * @param project
	 */
	public void updateProject(Project project);
	
	/**
	 * 取消项目
	 * @param project
	 */
	public void removeProject(Project project);
	
	/**
	 * 统计项目数
	 * @param projectState 项目状态
	 * @return
	 */
	public Integer statProjectsByState(String... projectState);
	
	
	/**
	 * 根据项目类型获取项目列表
	 * @param projectType 
	 * @param maxResult 返回结果数量
	 * @return
	 */
	public List<Project> getProjectsByType(String projectType,Integer maxResult);
	
	
	/**
	 * 查询用户关注的项目列表
	 * @param userId 用户ID
	 * @param projectState 项目状态，如果项目状态为空，则查询所有关注的项目
	 * @param page 分页对象
	 * @return
	 */
	public List<Project> findFocusProjects(String userId,String projectState,Page page);
	
	/**
	 * 查询用户发布的项目
	 * @param userId
	 * @param projectState
	 * @param page
	 * @return
	 */
	public List<Project> findPublishProjects(String userId,String projectState,Page page);
	
	/**
	 * 查询用户认购的项目
	 * @param userId
	 * @param projectState
	 * @param page
	 * @return
	 */
	public List<Project> findSubscribeProjects(String userId,String projectState,Page page);
	
	
	
	/**
	 * 关注项目
	 * @param userId
	 * @param projectId
	 * @return
	 */
	public int addFocusProject(String userId,Long projectId);
	
	/**
	 * 取消关注项目
	 * @param userId
	 * @param projectId
	 * @return
	 */
	public int removeFocusProject(String userId,Long projectId);
	
	/**
	 * 更新项目关注数量
	 * @param projectId 项目ID
	 * @param value 值为整数即表示增加关注数，值为负数则表示减少关注数
	 * @return
	 */
	public int updateFocusCount(Long projectId,int value);
	
	/**
	 * 检查当前用户是否具有访问该用户权限<BR>
	 * 返回值说明:<BR>
	 * <li>返回1:当前用户是该项目的发起人，并且项目状态为未提交审核(即 空"")，则可以访问
	 * <li>返回0:当前用户是该项目的发起人，但项目状态为已受理,则不可访问
	 * <li>返回-1:当前项目不是该项目的发起人,不可访问</li>
	 * @param userId
	 * @param projectId
	 * @return 
	 */
	public int checkProjectAccessPermission(String userId,Long projectId);
	
	
	/**
	 * 判断是否关注了项目
	 * @param userId 用户ID
	 * @param projectId 项目ID
	 * @return
	 */
	public boolean isAttention(String userId,Long projectId);
	
	

	/**
	 * 获取项目文档
	 * @param projectId
	 * @return
	 */
	public ProjectDoc getProjectDoc(Long projectId);
	/**
	 * 保存项目文档
	 * @param projectDoc
	 */
	public void saveProjectDoc(ProjectDoc projectDoc);
	
	/**
	 * 删除项目文档
	 * @param projectId
	 */
	public void removeProjectDoc(Long projectId);
	
	
}
