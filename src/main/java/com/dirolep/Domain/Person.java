package com.dirolep.Domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;
import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Entity
@Data
@EqualsAndHashCode(of = {"id"})
public class Person implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;

    private String realName; // 真实姓名

    private String phone; // 电话

    @ManyToOne
    @JoinColumn(name = "level_id")
    private Level level; // 会员级别

    private String cardNum; // 会员卡号

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date makeCardTime;  // 办卡时间

    private Integer status;  // 状态 0：有效 1：禁用

    private String remark;  // 备注

    @OneToMany(mappedBy = "person", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
    private Set<PersonSpending> personSpending;  // 消费历史

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", realName='" + realName + '\'' +
                ", phone='" + phone + '\'' +
                ", level=" + level +
                ", cardNum='" + cardNum + '\'' +
                ", makeCardTime=" + makeCardTime +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                '}';
    }
}
