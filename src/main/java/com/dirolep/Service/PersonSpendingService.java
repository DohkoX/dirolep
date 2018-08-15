package com.dirolep.Service;

import com.dirolep.Domain.PersonSpending;
import java.math.BigDecimal;

/**
 *
 * Created by Administrator on 2018\5\1 0001.
 */
public interface PersonSpendingService {

    String save(PersonSpending personSpending, Integer personId);

    BigDecimal findAllXfCountByPersonId(Integer personId);

    String findByPersonId(Integer personId);

}
