package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectNotice;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目公告服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectNoticeService {
	
	/**
	 * 获取最近lastestNum条项目公告
	 * @param lastestNum 条数
	 * @return
	 */
	public List<ProjectNotice> getProjectNotices(Integer lastestNum);
	
	
	/**
	 * 获取公告总数
	 * @return
	 */
	public Integer getNoticeTotalCount();
	
	
	/**
	 * 获取项目公示信息
	 * @param noticeId
	 * @return
	 */
	public ProjectNotice getProjectNotice(Long noticeId);
	/**
	 * 分页查询项目公告
	 * @param notice 查询条件
	 * @param page 分页对象
	 * @return
	 */
	public List<ProjectNotice> findProjectNotices(ProjectNotice notice,Page page);
	
	/**
	 * 获取所有项目公告(无条件,分页)
	 * @param page 分页对象
	 * @return
	 */
	public List<ProjectNotice> findAllProjectNotices(Page page);
	/**
	 * 添加项目公告
	 * @param notice
	 */
	public void addProjectNotice(ProjectNotice notice);
	
	/**
	 * 修改项目公告
	 * @param notice
	 */
	public void updateProjectNotice(ProjectNotice notice);
	
	/**
	 * 删除项目公告
	 * @param noticeId
	 */
	public void removeProjectNotice(Long noticeId);

}
