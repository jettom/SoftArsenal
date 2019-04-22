package com.test;

import com.service.TreeNode;

public class Test1 {

	public static void main(String[] args) {
		System.out.println("test ");
		TreeNode<String> treeRoot = getSetA();
		for (TreeNode<String> node : treeRoot) {
			String indent = createIndent(node.getLevel());
			System.out.println(indent + node.data);
		}
		System.out.println("test*");
		Comparable<String> searchFCriteria = new Comparable<String>() {
			@Override
			public int compareTo(String treeData) {
				if (treeData == null)
					return 1;
				boolean nodeOk = treeData.contains("F");
				return nodeOk ? 0 : 1;
			}
		};
		TreeNode<String> foundF = treeRoot.findTreeNode(searchFCriteria);
		System.out.println("F: parent=" + foundF.parent + ",children=" + foundF.children);
	}

	private static String createIndent(int depth) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < depth; i++) {
			sb.append(' ');
		}
		return sb.toString();
	}

	public static TreeNode<String> getSetA() {
		TreeNode<String> A = new TreeNode<String>("A");
		{
			TreeNode<String> B = A.addChild("B");
			TreeNode<String> C = A.addChild("C");
			TreeNode<String> D = A.addChild("D");
			{
				TreeNode<String> E = B.addChild("E");
				TreeNode<String> F = C.addChild("F");
				TreeNode<String> G = C.addChild("G");
				{
					TreeNode<String> H = F.addChild("H");
					TreeNode<String> I = F.addChild("I");
					TreeNode<String> J = F.addChild("J");
				}
			}
		}
		return A;
	}

}
