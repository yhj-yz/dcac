package com.huatusoft.electronictag.organizationalstrucure.base;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 14:31
 */
public interface OrganizationalStructureService {
    /**
     * 父节点是否可用
     * @param id 查询节点id
     * @return
     */
    boolean isParentAvailable(String id);

    /**
     * 父节点是否不可用
     * @param id 查询节点id
     * @return
     */
    boolean isParentDisabled(String id);
}
