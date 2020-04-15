package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import com.huatusoft.dcac.strategymanager.service.DataGradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Controller
@RequestMapping("/admin/data/grade")
public class DataGradeController extends BaseController {

    @Autowired
    private DataGradeService dataGradeService;
    /**
     * 跳转到数据分级界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/data/grade/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param gradeName
     * @param createUserAccount
     * @param gradeDesc
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<DataGradeEntity> search(Integer pageSize, Integer pageNumber, String gradeName, String createUserAccount, String gradeDesc){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<DataGradeEntity> page = dataGradeService.findAllByPage(pageable,gradeName,createUserAccount,gradeDesc);
        return new PageVo<DataGradeEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     *
     * @param gradeName
     * @param gradeDesc
     * @return
     */
    @PostMapping(value = "/addGrade")
    @ResponseBody
    public Result addGrade(String gradeName,String gradeDesc){
        if(gradeName == null || "".equals(gradeName)){
            return new Result("分级名称为必填项!");
        }
        return dataGradeService.addGrade(gradeName,gradeDesc);
    }

    /**
     * 删除数据分级
     * @param ids
     * @return
     */
    @PostMapping(value = "deleteGrade")
    @ResponseBody
    public Result deleteGrade(String ids){
        if(ids == null){
            return new Result("请勾选删除的数据分级!");
        }
        try {
            String[] gradeIds = ids.split(",");
            dataGradeService.delete(DataGradeEntity.class,gradeIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍候再试!");
        }
        return new Result("200","删除数据分级成功!",null);
    }

    /**
     * 根据ID获取数据分级
     * @param id
     * @return
     */
    @GetMapping(value = "/getDataGrade")
    @ResponseBody
    public DataGradeEntity getDataGrade(String id){
        if(id == null){
            return null;
        }
        return dataGradeService.find(id);
    }

    /**
     * 修改数据分级
     * @param gradeId
     * @param gradeName
     * @param gradeDesc
     * @return
     */
    @PostMapping(value = "/updateGrade")
    @ResponseBody
    public Result updateGrade(String gradeId,String gradeName,String gradeDesc){
        return dataGradeService.updateGrade(gradeId,gradeName,gradeDesc);
    }
}
