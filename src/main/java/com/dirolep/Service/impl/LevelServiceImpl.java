package com.dirolep.Service.impl;

import com.dirolep.Utils.JSONUtils;
import com.dirolep.VO.ResultVO;
import com.dirolep.Dao.LevelDao;
import com.dirolep.Domain.Level;
import com.dirolep.Service.LevelService;
import com.dirolep.Utils.ResultVOUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
 *
 * Created by Administrator on 2018\4\29 0029.
 */
@Service
public class LevelServiceImpl implements LevelService{

    private final LevelDao levelDao;

    @Autowired
    public LevelServiceImpl(LevelDao levelDao) {
        this.levelDao = levelDao;
    }

    @Override
    public String findAll() {
        List<Level> levelList = levelDao.findAll();
        ResultVO levelResultVO = ResultVOUtil.success(levelList);
        return JSONUtils.beanToJson(levelResultVO);
    }

    @Override
    @Transactional
    public String save(Level level) {
        levelDao.save(level);
        ResultVO resultVO = ResultVOUtil.success();
        return JSONUtils.beanToJson(resultVO);
    }

    @Override
    public Level findOne(Integer id) {
        return levelDao.findById(id);
    }


}
