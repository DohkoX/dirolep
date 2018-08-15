package com.dirolep.Dao;

import com.dirolep.Domain.PersonSpending;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 *
 * Created by Administrator on 2018\5\1 0001.
 */
public interface PersonSpendingDao extends JpaRepository<PersonSpending, Integer>, JpaSpecificationExecutor<PersonSpending> {

    @Query(value = "select * from person_spending WHERE person_id = ?1", nativeQuery = true)
    List<PersonSpending> findByPersonId(Integer personId);

}
