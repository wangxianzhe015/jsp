package com.smartcloud.crowdfunding.console.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 用于图形化展示的节点
 * 
 */
public class GraphNode {
	private String id;

	private String type;

	private String name;

	private int level;

	private List<String> connections = new ArrayList<String>();

	public List<String> getConnections() {
		return connections;
	}

	public void setConnections(List<String> connections) {
		this.connections = connections;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void addTargetId(String targetId) {
		this.connections.add(targetId);
	}
}
