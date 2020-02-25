package com.huatusoft.dcac.basicplatforminteraction.vo;

import lombok.Data;

import java.util.List;

/**
 * @author WangShun
 */

@Data
public class StatusReportVo {
	private String appid;
	private String appname;
	private String access_token;
	private String ip;
	private String cpu;
	private MemoryVO memory;
	private MemoryVO disk;
	private String network;
	private List<ServiceVo> services;
}
