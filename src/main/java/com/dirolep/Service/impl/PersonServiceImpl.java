package com.dirolep.Service.impl;

import com.dirolep.Utils.SpecificationUtils;
import com.dirolep.VO.PersonVO;
import com.dirolep.Dao.PersonSpendingDao;
import com.dirolep.Dao.PersonDao;
import com.dirolep.Domain.Level;
import com.dirolep.Domain.Person;
import com.dirolep.Domain.PersonSpending;
import com.dirolep.Service.PersonService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Administrator on
 * 2018\4\30 0030.
 */
@Service
public class PersonServiceImpl implements PersonService {

    private final PersonDao personDao;
    private final PersonSpendingDao personSpendingDao;

    @Autowired
    public PersonServiceImpl(PersonDao personDao, PersonSpendingDao personSpendingDao) {
        this.personDao = personDao;
        this.personSpendingDao = personSpendingDao;
    }

    @Override
    @Transactional
    public Person save(Person person) {
        personDao.save(person);
        return person;
    }

    @Override
    public Page<Person> findPersonList(String realNameOrPhoneOrCardNum, Integer page, Integer limit) {
        if (StringUtils.isEmpty(realNameOrPhoneOrCardNum)) {
            return findAll(page, limit);
        }else {
            Pageable pageable = new PageRequest(page, limit);
            Specification<Person> specification = SpecificationUtils.findPerson(realNameOrPhoneOrCardNum);
            return personDao.findAll(specification, pageable);
        }
    }

    @Override
    public List<PersonVO> personListToPersonVOList(List<Person> personList) {
        List<PersonVO> personVOList = new ArrayList<>();
        for (Person p : personList) {
            PersonVO personVO = personToPersonVO(p);
            personVOList.add(personVO);
        }
        return personVOList;
    }

    @Override
    public Person findOne(Integer personId) {
        return personDao.findOne(personId);
    }

    @Override
    public PersonVO personToPersonVO(Person person) {
        PersonVO personVO = new PersonVO();
        BeanUtils.copyProperties(person, personVO);

        Level level = personVO.getLevel();  // 会员级别名称
        personVO.setLevelName(level.getLevelName());
        List<PersonSpending> personSpendingList = personSpendingDao.findByPersonId(person.getId());
        BigDecimal xfNum = new BigDecimal("0");    // 消费次数
        for (PersonSpending p1 : personSpendingList) {
            xfNum = xfNum.add(p1.getXfNum());
        }
        personVO.setXfNum(xfNum);

        /* 判断会员办卡类型为 按次数还是按时间 */
        Boolean effective = true;
        if(level.getEffectiveCount() != null){
            BigDecimal shengyuNum = level.getEffectiveCount().subtract(xfNum);
            // 剩余次数
            personVO.setShengyuNum(shengyuNum);
            if(shengyuNum.compareTo(new BigDecimal("0")) <= 0){
                effective = false;
            }
        } else {
            // 停用日期
            Date makeCardTime = person.getMakeCardTime();
            Calendar c = Calendar.getInstance();
            c.setTime(makeCardTime);
            c.add(Calendar.DATE, level.getEffectiveDays().intValue());
            personVO.setEndDate(c.getTime());

            Calendar c2 = Calendar.getInstance();
            c2.setTime(new Date());
            if(!c.after(c2)){    // 如果停用日期晚于当前时间
                effective = false;
            }
        }

        if (effective) {
            String statusName = "有效";    // 状态名称
            personVO.setStatusName(statusName);
        } else {
            personVO.setStatus(1);
            String statusName = "失效";    // 状态名称
            personVO.setStatusName(statusName);

            person.setStatus(1);
            personDao.save(person);
        }

        return personVO;
    }

    @Override
    public Page<Person> findAll(Integer page, Integer limit) {
        PageRequest pageRequest = new PageRequest(page, limit);
        return personDao.findAll(pageRequest);
    }

    @Override
    @Transactional
    public void delete(Integer[] ids) {
        Person person;
        for (Integer id : ids) {
            person = personDao.findOne(id);
            if (person != null) {
                personDao.delete(person);
            }
        }
    }
}
