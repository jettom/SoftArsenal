package com.service;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * Tree structure
 *
 * @author ijiangtao
 * @create 2019-04-18 15:13
 **/
public class TreeNode<T> implements Iterable<TreeNode<T>> {
	/**
	* tree node
	*/
	public T data;
	/**
	* parent node ,root have no parent node
	*/
	public TreeNode<T> parent;
	/**
	* child node, leaf have no child node.
	*/
	public List<TreeNode<T>> children;
	/**
	* save current node and all child node for quern
	*/
	private List<TreeNode<T>> elementsIndex;

	/**
	* constructure
	*
	* @param data
	*/
	public TreeNode(T data) {
		this.data = data;
		this.children = new LinkedList<TreeNode<T>>();
		this.elementsIndex = new LinkedList<TreeNode<T>>();
		this.elementsIndex.add(this);
	}

	/**
	*
	*
	* @return
	*/
	public boolean isRoot() {
		return parent == null;
	}

	/**
	*
	*
	* @return
	*/
	public boolean isLeaf() {
		return children.size() == 0;
	}

	/**
	* add child node
	*
	* @param child
	* @return
	*/
	public TreeNode<T> addChild(T child) {
		TreeNode<T> childNode = new TreeNode<T>(child);
		childNode.parent = this;
		this.children.add(childNode);
		this.registerChildForSearch(childNode);
		return childNode;
	}

	/**
	* get current node level
	*
	* @return
	*/
	public int getLevel() {
		if (this.isRoot()) {
			return 0;
		} else {
			return parent.getLevel() + 1;
		}
	}

	/**
	*
	*
	* @param node
	*/
	private void registerChildForSearch(TreeNode<T> node) {
		elementsIndex.add(node);
		if (parent != null) {
			parent.registerChildForSearch(node);
		}
	}

	/**
	*
	*
	* @param cmp
	* @return
	*/
	public TreeNode<T> findTreeNode(Comparable<T> cmp) {
		for (TreeNode<T> element : this.elementsIndex) {
			T elData = element.data;
			if (cmp.compareTo(elData) == 0)
				return element;
		}
		return null;
	}

	/**
	*
	*
	* @return
	*/
	@Override
	public Iterator<TreeNode<T>> iterator() {
		TreeNodeIterator<T> iterator = new TreeNodeIterator<T>(this);
		return iterator;
	}

	@Override
	public String toString() {
		return data != null ? data.toString() : "[tree data null]";
	}
}