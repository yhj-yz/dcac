package com.huatusoft.electronictag.organizationalstrucure.vo;

import com.huatusoft.electronictag.base.vo.BaseVo;
import com.huatusoft.electronictag.organizationalstrucure.entity.ControlledStrategyEntity;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/***
 * 应用程序控制实体类
 * 
 * @author ssz
 *
 */
@Getter
@Setter
public class ProgramVo extends BaseVo {
	@Transient
	private static final long serialVersionUID = 2262903467689488348L;
	/**属性名称  名称*/
    @NotEmpty
	private String name;
	/**属性名称   图标路径*/
    @Length(max=64)
	private String iconPath;
	/**属性名称  父节点id*/
    @NotEmpty
	private String parentId;
	/**属性名称   原始文件名称*/
	private String primaryFile;
	/**是否是配置*/
	private Integer isConfig;
	/**属性名称   节点名称*/
	private String nodeName;
	/**属性名称  当前节点中的内容*/
	private String nodeInsideContent;
	/**属性名称  当前节点外的内容*/
	private String nodeOutsideContent;

    private Set<ControlledStrategyEntity> contrStrategy=new HashSet<ControlledStrategyEntity>();
}
