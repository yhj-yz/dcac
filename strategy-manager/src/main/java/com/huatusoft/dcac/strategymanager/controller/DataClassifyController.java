package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;
import com.huatusoft.dcac.strategymanager.service.DataClassifyService;
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

import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Controller
@RequestMapping("/admin/data/classify")
public class DataClassifyController extends BaseController {

    @Autowired
    private DataClassifyService dataClassifyService;
    /**
     * 跳转到数据分类界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/data/classify/list.ftl";
    }

    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<DataClassifyBigEntity> search(Integer pageSize, Integer pageNumber, String bigClassifyName, String smallClassifyName, String createUserAccount, String classifyDesc){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<DataClassifyBigEntity> page = dataClassifyService.findAllByPage(pageable,bigClassifyName,smallClassifyName,createUserAccount,classifyDesc);
        return new PageVo<DataClassifyBigEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 获取所有分类数据
     * @return
     */
    @GetMapping(value = "/getClassify")
    @ResponseBody
    public List<DataClassifyBigEntity> getClassify(){
        return dataClassifyService.findAll();
    }

    /**
     * 根据id获取软件对象
     * @param id
     * @return
     */
    @GetMapping(value = "/showClassify")
    @ResponseBody
    public DataClassifyBigEntity showClassify(String id){
        if(id == null){
            return null;
        }
        return dataClassifyService.find(id);
    }

    /**
     * 添加数据分类大类
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    @PostMapping(value = "addBigClassify")
    @ResponseBody
    public Result addBigClassify(String classifyName,String classifyDesc){
        if(classifyName == null || "".equals(classifyName)){
            return new Result("一级分类名称为必填字段!");
        }
        return dataClassifyService.addBigClassify(classifyName,classifyDesc);
    }

    @PostMapping(value = "deleteBigClassify")
    @ResponseBody
    public Result deleteBigClassify(String ids){
        if(ids == null){
            return  new Result("请勾选一级分类");
        }
        String[] classifyIds = ids.split(",");
        return dataClassifyService.deleteBigClassify(classifyIds);
    }

    @PostMapping(value = "addSmallClassify")
    @ResponseBody
    public Result addSmallClassify(String classifyId,String classifyName,String classifyDesc){
        if(classifyId == null || "".equals(classifyId) || classifyName == null || "".equals(classifyName)){
            return new Result("请输入必要字段!");
        }
        return dataClassifyService.addSmallClassify(classifyId,classifyName,classifyDesc);
    }

    /**
     * 删除二级分类
     * @param ids
     * @return
     */
    @PostMapping(value = "/deleteSmallClassify")
    @ResponseBody
    public Result deleteSmallClassify(String ids){
        if(ids == null){
            return new Result("请勾选删除的二级分类!");
        }
        String[] classifyIds = ids.split(",");
        return dataClassifyService.deleteSmallClassify(classifyIds);
    }
    /**
     * 根据小类ID获取小类
     * @param id
     * @return

     */
    @GetMapping(value = "/getSmallClassify")
    @ResponseBody
    public DataClassifySmallEntity getSmallClassify(String id){
        if(id == null){
            return null;
        }
        return dataClassifyService.getSmallClassify(id);
    }

    /**
     * 修改一级分类
     * @param classifyId
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    @PostMapping(value = "/updateBigClassify")
    @ResponseBody
    public Result updateBigClassify(String classifyId,String classifyName,String classifyDesc){
        return dataClassifyService.updateBigClassify(classifyId,classifyName,classifyDesc);
    }

    /**
     * 修改二级分类
     * @param classifyId
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    @PostMapping(value = "/updateSmallClassify")
    @ResponseBody
    public Result updateSmallClassify(String classifyId,String classifyName,String classifyDesc){
        return dataClassifyService.updateSmallClassify(classifyId,classifyName,classifyDesc);
    }
}
