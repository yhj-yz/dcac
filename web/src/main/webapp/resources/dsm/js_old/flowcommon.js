
function initModelType(type){
	switch (type) {
        case ("fileDecodeApprove"):
            return "文件解密审批";
            break;
        case ("fileOutsideApprove"):
            return "文件外发审批";
            break;
        case ("mailDecodeApprove"):
            return "邮件解密审批";
            break;
        case ("changeFileSecurityApprove"):
            return "调整文件安全域审批";
            break;
        case ("TerminalOfflineApprove"):
            return "终端离网审批";
            break;
        case ("OfflineAddTimeApprove"):
            return "离网补时审批";
            break;
        default:
           return "未定义";
    }
  
}