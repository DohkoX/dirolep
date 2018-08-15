package com.dirolep.Service.impl;

import com.dirolep.Utils.JSONUtils;
import com.dirolep.VO.PersonConsumptionHistoryVO;
import com.dirolep.VO.ResultVO;
import com.dirolep.Dao.PersonSpendingDao;
import com.dirolep.Domain.Level;
import com.dirolep.Domain.Person;
import com.dirolep.Domain.PersonSpending;
import com.dirolep.DTO.SalesTicket;
import com.dirolep.Service.LevelService;
import com.dirolep.Service.PersonSpendingService;
import com.dirolep.Service.PersonService;
import com.dirolep.Utils.PrintSalesTicket;
import com.dirolep.Utils.ResultVOUtil;
import com.dirolep.Utils.StringRandom;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.awt.print.PrinterException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 个人消费历史ServiceImpl
 * Created by Administrator on 2018\5\1 0001.
 */
@Service
public class PersonSpendingServiceImpl implements PersonSpendingService {

    private final PersonService personService;
    private final LevelService levelService;
    private final PersonSpendingDao personSpendingDao;

    @Autowired
    public PersonSpendingServiceImpl (PersonService personService, LevelService levelService, PersonSpendingDao personSpendingDao) {
        this.personService = personService;
        this.levelService = levelService;
        this.personSpendingDao = personSpendingDao;
    }

    @Override
    @Transactional
    public String save(PersonSpending personSpending, Integer personId) {

        SalesTicket salesTicket = new SalesTicket();    // 小票布局对象
        Boolean result = false; // 能否出票
        ResultVO resultVO;

        BigDecimal totalCount;
        BigDecimal effectiveDays;
        Level level;
        BigDecimal xfTotalCount; // 已消费次数

        Person person = personService.findOne(personId);  // 从会员表中查询会员
        personSpending.setPerson(person);
        personSpending.setXfTime(new Date());
        if(person != null){

            /* 判断是否能够正常出票 */
            Integer levelId = person.getLevel().getId();
            level = levelService.findOne(levelId);
            xfTotalCount = findAllXfCountByPersonId(person.getId());
            totalCount = level == null ? null : level.getEffectiveCount();       // 可以消费的总次数
            effectiveDays = level == null ? null : level.getEffectiveDays();     // 有效天数

            if(effectiveDays != null){ // 会员卡次数为空，则判断时间是否超期
                Date makeCardTime = person.getMakeCardTime();
                Calendar c1 = Calendar.getInstance();
                c1.setTime(makeCardTime);
                c1.set(Calendar.DATE, effectiveDays.intValue());
                Calendar c2 = Calendar.getInstance();
                c2.setTime(new Date());
                result = c1.after(c2);
            }else if (totalCount != null && totalCount.subtract(xfTotalCount).compareTo(personSpending.getXfNum()) >= 0){   // 会员卡次数不为空，判断剩余次数是否足够
                result = true;
            }

            /* 如果可以正常出票 */
            if(result){
                PersonSpending personSpending1 = personSpendingDao.save(personSpending);
                // 随机生成一组编码 单据号
                salesTicket.setDanjuhao("DLN" + StringRandom.getStringRandom(12));
                // 单次划掉次数
                salesTicket.setXfNum(personSpending1.getXfNum());
                // 剩余次数
                xfTotalCount = findAllXfCountByPersonId(person.getId());
                salesTicket.setShengyuNum(totalCount != null ? totalCount.subtract(xfTotalCount).toString() : "");
                // 会员卡号
                salesTicket.setCardNum(person.getCardNum());
                // 真实姓名
                salesTicket.setPersonRealName(person.getRealName());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                // 消费日期
                salesTicket.setXfDate(sdf.format(new Date()));
                // 开卡日期
                salesTicket.setMakeCardDate(sdf.format(person.getMakeCardTime()));
                // 卡类
                salesTicket.setCardCaregory(level.getLevelName());

                try {
                    PrintSalesTicket.PrintSale(salesTicket);
                    resultVO = ResultVOUtil.success(salesTicket);
                } catch (PrinterException e) {
                    resultVO = ResultVOUtil.fail(e.hashCode(), e.getMessage());
                }
            }else {
                resultVO = ResultVOUtil.fail(1, "该卡次数不足或者已到期!");
            }
        }else {
            resultVO = ResultVOUtil.fail(2, "找不到该会员！");
        }

        return JSONUtils.beanToJson(resultVO);
    }

    @Override
    public BigDecimal findAllXfCountByPersonId(Integer personId) {
        List<PersonSpending> personSpendingList = personSpendingDao.findByPersonId(personId);

        BigDecimal xfNum = new BigDecimal("0");
        for (PersonSpending p : personSpendingList) {
            xfNum = xfNum.add(p.getXfNum());
        }

        return xfNum;
    }

    @Override
    public String findByPersonId(Integer personId) {
        List<PersonSpending> personSpendingList = personSpendingDao.findByPersonId(personId);

        List<PersonConsumptionHistoryVO> personConsumptionHistoryVOList = new ArrayList<>();
        for (PersonSpending p : personSpendingList) {
            PersonConsumptionHistoryVO personConsumptionHistoryVO = new PersonConsumptionHistoryVO();
            BeanUtils.copyProperties(p, personConsumptionHistoryVO);
            // 会员姓名
            Person person = p.getPerson();
            personConsumptionHistoryVO.setPersonName(person.getRealName());
            personConsumptionHistoryVOList.add(personConsumptionHistoryVO);
        }
        ResultVO resultVO = ResultVOUtil.success(personConsumptionHistoryVOList);

        return JSONUtils.beanToJson(resultVO, "yyyy-MM-dd HH:mm");
    }

}
