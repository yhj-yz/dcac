/**
 * @author yhj
 * @date 2019-10-30
 */
package com.huatusoft.dcac.common.constant;

public class TableOpera {

    public static String UPDATE_USER = "update ht_electronictag_user t set t.login_time = null , t.online_status =2;";

    public static String [] COPY_TABLE ={
            "ht_electronictag_alarm",
            "ht_electronictag_authorize_code",
            "ht_electronictag_authorize_code_ht_electronictag_user",
            "ht_electronictag_backup_manager",
            "ht_electronictag_cert",
            "ht_electronictag_circulation_operation",
            "ht_electronictag_contr_stratrgy",
            "ht_electronictag_control_manager",
            "ht_electronictag_department",
            "ht_electronictag_department_ht_electronictag_user",
            "ht_electronictag_electronictag_list",
            "ht_electronictag_file_log",
            "ht_electronictag_group",
            "ht_electronictag_license",
            "ht_electronictag_license_product",
            "ht_electronictag_login_image",
            "ht_electronictag_mag_log",
            "ht_electronictag_permission_set",
            "ht_electronictag_plugin_config",
            "ht_electronictag_plugin_config_attribute",
            "ht_electronictag_role",
            "ht_electronictag_role_authority",
            "ht_electronictag_system_set",
            "ht_electronictag_user",
            "ht_electronictag_user_ht_electronictag_group",
            "ht_electronictag_level_mag",
            "ht_electronictag_circulation_address",
            "ht_electronictag_circulation_manage",
            "ht_electronictag_help_search",
            "ht_dcac_data_grade",
            "ht_dcac_data_big_classify",
            "ht_dcac_data_small_classify",
            "ht_dcac_strategy",
            "HT_DCAC_DATA_IDENTIFIER",
            "HT_DCAC_DATA_LEVEL",
            "HT_DCAC_DATA_LEVEL_RULE",
            "HT_DCAC_DATA_LEVEL_RULE_SCOPE",
            "HT_DCAC_STRATEGY_RULE_CONTENT",
            "HT_DCAC_STRATEGY_RULE",
            "HT_DCAC_STRATEGY_RULE_TYPE",
            "HT_DCAC_STRATEGY_MASK_RULE",
            "HT_DCAC_STRATEGY_MASK_TYPE",
            "HT_DCAC_STRATEGY_RESPONSE",
            "HT_DCAC_STRATEGY_SCAN",
            "HT_DCAC_STRATEGY_GROUP",
            "STRATEGY_GROUP",
            "HT_DCAC_SYSTEM_PARAM",
            "HT_DCAC_STRATEGY_SCAN"
    };

    public static String []  IGNORE_TABLE ={
            "xx_navigation",
    };
}
