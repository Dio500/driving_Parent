package com.gx.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

public class TreePlusUtil {
	private List<TreeResult> treeResults = new ArrayList<TreeResult>();

    private List<String> selectEdId=null;

    public TreePlusUtil(List<TreeResult> treeResults, List<String> selectEdId) {
        this.treeResults = treeResults;
        this.selectEdId = selectEdId;
    }

    //建立树形结构
    public List<TreeResult> builTree(Predicate<TreeResult> predicate) {
        List<TreeResult> treeMenus = new ArrayList<TreeResult>();
        for (TreeResult treeResult : getRootNode(predicate)) {
            treeResult = buildChilTree(treeResult);
            treeMenus.add(treeResult);
        }
        return treeMenus;
    }

    //递归，建立子树形结构
    private TreeResult buildChilTree(TreeResult pNode) {
        List<TreeResult> chilMenus = new ArrayList<TreeResult>();
        for (TreeResult treeResult : treeResults) {
            if (pNode.getValue().equalsIgnoreCase(treeResult.getPvalue())) {
                if (selectEdId.stream().anyMatch(a->treeResult.getValue().equalsIgnoreCase(a))){
                    treeResult.setSelected(true);
                }
                chilMenus.add(buildChilTree(treeResult));
            }
        }
        pNode.setChildren(chilMenus);
        return pNode;
    }

    //获取根节点
    private List<TreeResult> getRootNode(Predicate<TreeResult> predicate) {
        List<TreeResult> rootMenuLists = new ArrayList<TreeResult>();
        for (TreeResult treeResult : treeResults) {
            if (predicate.test(treeResult)) {
                rootMenuLists.add(treeResult);
            }
        }
        return rootMenuLists;
    }
}