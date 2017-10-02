package org.jiahao.qa.dao;

import org.apache.ibatis.annotations.Param;
import org.jiahao.qa.pojo.View;

/**
 * Created by Alvin on 2016/11/19.
 */
public interface ViewMapper {

    View selectTodayView(@Param("userid") String userid, @Param("questionid") String questionid);

    int insertView(@Param("userid") String userid, @Param("questionid") String questionid);
}
