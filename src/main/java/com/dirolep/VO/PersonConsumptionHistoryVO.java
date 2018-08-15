package com.dirolep.VO;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * Created by xieyao on 2018/5/2.
 */
@Data
public class PersonConsumptionHistoryVO {

    private Integer id;

    private Integer personId; // 会员id *

    private String personName; // 会员姓名

    private BigDecimal xfNum; // 消费人数/ 划掉的次数 *

    private Date xfTime;  //消费时间*
}
