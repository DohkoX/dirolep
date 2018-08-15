package com.dirolep.Dao;

import com.dirolep.Domain.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 *
 * Created by Administrator on 2018\4\30 0030.
 */
public interface PersonDao extends JpaRepository<Person, Integer>, JpaSpecificationExecutor<Person>{

}
