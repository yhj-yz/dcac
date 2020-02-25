/**
 * @author yhj
 * @date 2019-10-31
 */
package com.huatusoft.dcac.addresslist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin/circulation")
public class CirculationAddressController {

    @GetMapping(value = "/list")
    public String toReportList() {
        return "/circulation/address/list.ftl";
    }

}
