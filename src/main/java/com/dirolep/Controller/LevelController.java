package com.dirolep.Controller;

import com.dirolep.Domain.Level;
import com.dirolep.Service.LevelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 *
 * Created by Administrator on 2018\4\29 0029.
 */
@RestController
@RequestMapping("/level")
public class LevelController {

    private final LevelService levelService;

    @Autowired
    public LevelController (LevelService levelService) {
        this.levelService = levelService;
    }

    @GetMapping("/findAll")
    public String findAll(){
        return levelService.findAll();
    }

    @PostMapping("/save")
    public String save(Level level){
        return levelService.save(level);
    }

}
