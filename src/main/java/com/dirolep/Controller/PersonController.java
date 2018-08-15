package com.dirolep.Controller;

import com.dirolep.Utils.JSONUtils;
import com.dirolep.VO.PersonVO;
import com.dirolep.VO.ResultVO;
import com.dirolep.Domain.Level;
import com.dirolep.Domain.Person;
import com.dirolep.DTO.PersonTicket;
import com.dirolep.Service.LevelService;
import com.dirolep.Service.PersonService;
import com.dirolep.Utils.PrintSalesTicket;
import com.dirolep.Utils.ResultVOUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;
import java.awt.print.PrinterException;
import java.util.List;

/**
 *
 * Created by Administrator on 2018\4\30 0030.
 */
@RestController
@RequestMapping("/person")
public class PersonController {

    private final PersonService personService;
    private final LevelService levelService;

    @Autowired
    public PersonController (PersonService personService, LevelService levelService) {
        this.personService = personService;
        this.levelService = levelService;
    }

    @PostMapping("/save")
    public String save(Person person){
        ResultVO resultVO;
        try {
            personService.save(person);
            resultVO = ResultVOUtil.success();
        }catch (RuntimeException e) {
            resultVO = ResultVOUtil.fail(e.hashCode(), e.getMessage());
        }
        return JSONUtils.beanToJson(resultVO);
    }

    @GetMapping("/findPerson")
    public String findPerson(String realNameOrPhoneOrCardNum,
                             @RequestParam(required = false, defaultValue = "1", name = "page") Integer page,
                             @RequestParam(required = false, defaultValue = "10", name = "limit") Integer limit){
        Page<Person> personPage = personService.findPersonList(realNameOrPhoneOrCardNum, page - 1, limit);
        List<PersonVO> personVOList = personService.personListToPersonVOList(personPage.getContent());
        ResultVO resultVO = ResultVOUtil.success(personVOList);
        resultVO.setCount(personPage.getTotalElements());
        return JSONUtils.beanToJson(resultVO, "yyyy-MM-dd HH:mm");
    }

    @GetMapping("/findPersonById")
    public String findPerson(Integer id){
        Person person = personService.findOne(id);
        ResultVO resultVO;
        if (person != null) {
            PersonVO personVO = personService.personToPersonVO(person);
            resultVO = ResultVOUtil.success(personVO);
        }else {
            resultVO = ResultVOUtil.fail(1, "找不到该用户");
        }
        return JSONUtils.beanToJson(resultVO, "yyyy-MM-dd HH:mm");
    }

    @GetMapping("/findAll")
    public String findAll(Integer page, Integer limit){
        Page<Person> personPage = personService.findAll(page - 1, limit);
        List<PersonVO> personVOList = personService.personListToPersonVOList(personPage.getContent());
        ResultVO resultVO = ResultVOUtil.success(personVOList);
        resultVO.setCount(personPage.getTotalElements());
        return JSONUtils.beanToJson(resultVO, "yyyy-MM-dd HH:mm");
    }

    @PostMapping("/delete")
    public String delete(Integer[] ids){
        ResultVO resultVO;
        try {
            personService.delete(ids);
            resultVO = ResultVOUtil.success();
        }catch (RuntimeException e) {
            resultVO = ResultVOUtil.fail(e.hashCode(), e.getMessage());
        }
        return JSONUtils.beanToJson(resultVO);
    }

    /* 打印办理会员卡票据 */
    @PostMapping("/printPersonCard")
    public String printPersonCard(PersonTicket personTicket){
        ResultVO resultVO;
        try {
            Level level = levelService.findOne(personTicket.getLevel());
            personTicket.setCardCaregory(level.getLevelName());
            personTicket.setDanjuhao(personTicket.getCardCaregory() + personTicket.getCardNum());

            PrintSalesTicket.PrintSale(personTicket);
            resultVO = ResultVOUtil.success();
        } catch (PrinterException e) {
            resultVO = ResultVOUtil.fail(e.hashCode(), e.getMessage());
        }
        return JSONUtils.beanToJson(resultVO, "yyyy-MM-dd HH:mm");
    }


}
