package com.dirolep.Domain;

import lombok.Data;
import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Set;

@Entity
@Data
public class Level implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  @GeneratedValue(strategy= GenerationType.IDENTITY)
  private Integer id;

  private String levelName;  // 会员级别名称

  private BigDecimal levelPrice; // 会员价格

  private BigDecimal effectiveCount; // 有效次数

  private BigDecimal effectiveDays;  // 有效天数

  private String remark;  // 备注

  @Transient
  private Set<Person> personSet;

  @Override
  public String toString() {
    return "Level{" +
            "id=" + id +
            ", levelName='" + levelName + '\'' +
            ", levelPrice=" + levelPrice +
            ", effectiveCount=" + effectiveCount +
            ", effectiveDays=" + effectiveDays +
            ", remark='" + remark + '\'' +
            '}';
  }
}
