package com.dirolep.Domain;

import lombok.Data;
import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Data
public class PersonSpending implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  @GeneratedValue(strategy= GenerationType.IDENTITY)
  private Integer id;

  @ManyToOne
  @JoinColumn(name = "person_id")
  private Person person; // 会员

  private BigDecimal xfNum; // 消费人数/ 划掉的次数

  private Date xfTime;  //消费时间

}
