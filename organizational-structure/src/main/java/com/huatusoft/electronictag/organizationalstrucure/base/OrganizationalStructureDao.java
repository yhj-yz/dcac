package com.huatusoft.electronictag.organizationalstrucure.base;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 14:31
 */
public interface OrganizationalStructureDao {
    /**
     * 父节点是否可用
     * @param id
     * @return
     */
    boolean isParentAvailable(String id);
}
