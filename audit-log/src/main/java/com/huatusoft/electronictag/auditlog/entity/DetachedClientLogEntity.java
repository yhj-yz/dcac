/**
 * @author yhj
 * @date 2019-10-24
 */
package com.huatusoft.electronictag.auditlog.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DetachedClientLogEntity {
    /**1为告警日志，2 非告警日志*/
    private String logflag;
    /**告警进程 */
    private String logproc;
    /**告警等级  1一般  2严重 */
    private String loglevel;
    /**处理结果  1成功  2失败 */
    private String logresult;
    /**"文件ID" */
    private String file_id;
    /**ip */
    private String file_ip;
    /**"计算机名" */
    private String file_computer;
    /**终端ID */
    private String file_clinetid;
    /**操作时间,2015-8-19 */
    private String file_time;
    /**姓名 */
    private String file_userid;
    /**"操作类型" */
    private String file_oper;
    /**"操作进程名" */
    private String oper_proc;
    /**"操作内容" */
    private String oper_des;
    /**路径 */
    private String path;
    /**用户账号 */
    private String file_useraccount;
    /**读写 1。读 2。写 */
    private String logreadflag;
}
