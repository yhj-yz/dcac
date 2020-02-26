package com.huatusoft.dcac.systemsetting.vo;

import com.huatusoft.dcac.base.vo.BaseVo;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * @author: Vamtoo.Java.Cao
 *
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SystemParamVo extends BaseVo {

	private static final long serialVersionUID = 3843230996772036937L;

	/**基础平台地址*/
	private String basisPlatformIP;
	/**连接端口*/
	private String basisPlatformPort;
	/**平台注册后，返回的app_id*/
	private String basisPlatformAppId;
	/**平台注册后，返回的app_secret*/
	private String basisPlatformSecret;

}
