package com.huatusoft.dcac.organizationalstrucure.vo;

import com.huatusoft.dcac.base.vo.BaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:37
 */
@Getter
@Setter
public class ControlledStrategyVo extends BaseVo {

    /**受控策略名称*/
    private String name;
    /**受控策略描述*/
    private String desc;
    /**关联应用程序*/
    private List<ProgramVo> programs=new ArrayList<ProgramVo>();

    private List<UserVo> users=new ArrayList<UserVo>();
}
