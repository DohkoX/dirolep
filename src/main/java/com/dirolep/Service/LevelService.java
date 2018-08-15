package com.dirolep.Service;

import com.dirolep.Domain.Level;

/**
 *
 * Created by Administrator on 2018\4\29 0029.
 */
public interface LevelService {

    String findAll();

    String save(Level level);

    Level findOne(Integer id);
}
