package com.atos.lms.common.service;

import java.util.ArrayList;
import java.util.List;

import com.atos.lms.common.model.CategoryVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class CategoryService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CategoryService.class);

	private final CategoryDAO categorydao;

	@Autowired
    public CategoryService(CategoryDAO categorydao) {
        this.categorydao = categorydao;
    }

    public List<CategoryVO> selectCodeList(CategoryVO categoryVO) {
		return categorydao.selectCategoryCodeAll(categoryVO);
	}

	public List<CategoryVO> selectCodeMain(CategoryVO categoryVO) {
		
		// 집합과정운영
		List<String> typelist = new ArrayList<String>();
		typelist.add("A001"); // 관리감독자 정기교육
		typelist.add("A002"); // 근로자 정기교육
		typelist.add("A003"); // 위험성 평가교육
		
		categoryVO = CategoryVO.builder().mtype(typelist).build();
		
		
		return categorydao.selectCategoryCodeMain(categoryVO);
	}

	public List<CategoryVO> selectCodeSub(CategoryVO categoryVO) {
		return categorydao.selectCategoryCodeSub(categoryVO);
	}

}
