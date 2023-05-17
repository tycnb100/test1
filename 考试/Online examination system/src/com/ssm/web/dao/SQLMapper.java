package com.ssm.web.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface SQLMapper {

	@Select("select count(*) from t_student_exam where finished='已阅卷' and courseId=#{courseId} and zong>=#{min} and zong<#{max}")
	Long getScoreCount(@Param(value = "courseId") Integer courseId, @Param(value = "min") int min, @Param(value = "max") int max);
	//	@Update("update t_user set type='已激活' where id=#{id}")
	//	public void updateActivity(SimpleUser user);

	//	@Update("update t_user set userMoney=userMoney+ #{orderMoney} where id=#{userId}")
	//	public void updateUserMoney(@Param(value = "orderMoney") Double orderMoney, @Param(value = "userId") Integer userId);
}
