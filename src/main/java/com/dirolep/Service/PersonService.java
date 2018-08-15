package com.dirolep.Service;

import com.dirolep.VO.PersonVO;
import com.dirolep.Domain.Person;
import org.springframework.data.domain.Page;
import java.util.List;

/**
 *
 * Created by Administrator on 2018\4\30 0030.
 */
public interface PersonService {

    /* 保存 修改用户信息 */
    Person save(Person person);

    /* 通过 姓名或电话或卡号，模糊查询PersonList */
    Page<Person> findPersonList(String realNameOrPhoneOrCardNum, Integer page, Integer limit);

    /* 将查询PersonList转换成查询PersonVOList */
    List<PersonVO> personListToPersonVOList(List<Person> personList);

    /* 通过id查询Person */
    Person findOne(Integer personId);

    /* 将Person对象转换成PersonVO */
    PersonVO personToPersonVO(Person person);

    /* 分页查询所有Person */
    Page<Person> findAll(Integer page, Integer limit);

    void delete(Integer[] ids);
}
