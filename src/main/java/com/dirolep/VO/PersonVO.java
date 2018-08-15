package com.dirolep.VO;

import com.dirolep.Domain.Level;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * Created by xieyao on 2018/5/2.
 */
@Data
public class PersonVO {

    private Integer id;

    private String realName; // 真实姓名 *

    private String phone; // 电话 *

    private Level level; // 会员级别id *

    private String levelName; // 会员级别名称

    private String cardNum; // 会员卡号 *

    private Integer status;  // 状态 0：有效 1：禁用 *

    private String statusName;  // 状态名称

    private BigDecimal xfNum;  // 已消费次数

    private BigDecimal shengyuNum;  // 剩余次数

    private Date endDate;  // 停用日期

    private Date makeCardTime;  // 办卡时间 *

    private String parentNames;  // 父母姓名 *

    private Date birthday;  // 生日 *

    private String remark;  // 备注 *
}
