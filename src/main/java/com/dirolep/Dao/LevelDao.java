package com.dirolep.Dao;

import com.dirolep.Domain.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 *
 * Created by Administrator on 2018\4\29 0029.
 */
@Repository
public interface LevelDao extends JpaRepository<Level, Integer>, JpaSpecificationExecutor<Level> {

    List<Level> findAll();

    Level findById(Integer id);
}
