package com.atos.lms.common.service;


import java.util.List;

import com.atos.lms.common.model.CategoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Mapper
public interface CategoryDAO  {
	
	List<CategoryVO> selectCategoryCodeAll(CategoryVO categoryVO);
	
	List<CategoryVO> selectCategoryCodeMain(CategoryVO categoryVO);
	
	List<CategoryVO> selectCategoryCodeSub(CategoryVO categoryVO);


}
