package com.dirolep.Controller;

import com.dirolep.Domain.PersonSpending;
import com.dirolep.Service.PersonSpendingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * Created by Administrator on 2018\5\1 0001.
 */
@RestController
@RequestMapping("/personSpending")
public class PersonSpendingController {

    private final PersonSpendingService personSpendingService;

    @Autowired
    public PersonSpendingController (PersonSpendingService personSpendingService) {
        this.personSpendingService = personSpendingService;
    }

    @RequestMapping("/save")
    public String save(PersonSpending personSpending, Integer personId){
        return personSpendingService.save(personSpending, personId);
    }

    @RequestMapping("/findByPersonId")
    public String findByPersonId(Integer personId){
        return personSpendingService.findByPersonId(personId);
    }


}
