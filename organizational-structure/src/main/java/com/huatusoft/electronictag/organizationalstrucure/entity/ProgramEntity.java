package com.huatusoft.electronictag.organizationalstrucure.entity;

import com.huatusoft.electronictag.base.entity.BaseEntity;
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
@Entity
@Getter
@Setter
@Table(name="HT_ELECTRONICTAG_PROGRAM")
public class ProgramEntity extends BaseEntity {
	@Transient
	private static final long serialVersionUID = 2262903467689488348L;
	/**属性名称  名称*/
    @NotEmpty
    @Column(length=2048,  name="PROGRAM_NAME")
	private String name;
	/**属性名称   图标路径*/
    @Length(max=64)
    @Column(length=64, name="PROGRAM_ICON_PATH")
	private String iconPath;
	/**属性名称  父节点id*/
    @NotEmpty
    @Column(name="PROGRAM_PID")
	private String parentId;
	/**属性名称   原始文件名称*/
    @Column(name = "PROGRAM_PRIMARY_FILE", length = 256)
	private String primaryFile;
	/**是否是配置*/
    @Column(name = "PROGRAM_IS_CONFIG", length=1)
	private Integer isConfig;
	/**属性名称   节点名称*/
    @Column(name = "PROGRAM_NODE_NAME", length=2048)
	private String nodeName;
	/**属性名称  当前节点中的内容*/
    @Column(name = "PROGRAM_NODE_INSIDE_CONTENT", length=2048)
	private String nodeInsideContent;
	/**属性名称  当前节点外的内容*/
    @Column(name = "PROGRAM_NODE_OUT_SIDECONTENT", length=2048)
	private String nodeOutsideContent;

    @ManyToMany(mappedBy = "programs")
    private Set<ControlledStrategyEntity> contrStrategy=new HashSet<ControlledStrategyEntity>();
}
