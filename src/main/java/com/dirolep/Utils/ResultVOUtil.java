package com.dirolep.Utils;

import com.dirolep.VO.ResultVO;

/**
 * 所有返回结果的Json格式
 * Created by xieyao on 2018/1/20.
 */
public class ResultVOUtil {

    public static ResultVO success(Object object){
        ResultVO<Object> resultVO = new ResultVO<>();
        resultVO.setCode(0);
        resultVO.setMsg("操作成功");
        resultVO.setData(object);
        return resultVO;
    }

    public static ResultVO success(){
        return success(null);
    }

    public static ResultVO fail(Integer code, String msg){
        ResultVO resultVO = new ResultVO();
        resultVO.setCode(code);
        resultVO.setMsg(msg);
        return resultVO;
    }
}
