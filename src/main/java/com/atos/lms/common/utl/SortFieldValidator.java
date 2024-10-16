package com.atos.lms.common.utl;

import java.util.Collections;
import java.util.Map;
import java.util.Set;


import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SortFieldValidator {

	private final SortFieldProperties sortFieldProperties;

	private Map<String, Set<String>> allowedSortFields;
    private Map<String, String> defaultSortFields;

    // 정렬 순서 허용 값 (오름차순, 내림차순)
    private static final Set<String> ALLOWED_SORT_ORDERS = Set.of("ASC", "DESC");

    // 기본 정렬 순서
    private static final String DEFAULT_SORT_ORDER = "DESC";

	@Autowired
    public SortFieldValidator(SortFieldProperties sortFieldProperties) {
        this.sortFieldProperties = sortFieldProperties;
    }

    @PostConstruct
    public void init() {
        this.allowedSortFields = sortFieldProperties.getAllowedSortFields();
        this.defaultSortFields = sortFieldProperties.getDefaultSortFields();
    }



    /**
     * 정렬 필드를 검증하고, 허용된 값이면 반환, 그렇지 않으면 기본값 반환
     *
     * @param tableName 테이블 이름
     * @param sortField 사용자가 입력한 정렬 필드
     * @return 검증된 정렬 필드 또는 기본값
     */
    public String validateSortField(String tableName, String sortField) {
        Set<String> allowedFields = allowedSortFields.getOrDefault(tableName, Collections.emptySet());

        if (sortField != null && allowedFields.contains(sortField)) {
            return sortField;
        }

        return defaultSortFields.getOrDefault(tableName, "REG_DATE");
    }

    /**
     * 정렬 순서를 검증하고, 허용된 값이면 반환, 그렇지 않으면 기본값 반환
     *
     * @param sortOrder 사용자가 입력한 정렬 순서
     * @return 검증된 정렬 순서 또는 기본값
     */
    public String validateSortOrder(String sortOrder) {
        if (sortOrder != null) {
            String upperSortOrder = sortOrder.toUpperCase();
            if (ALLOWED_SORT_ORDERS.contains(upperSortOrder)) {
                return upperSortOrder;
            }
        }
        return DEFAULT_SORT_ORDER;
    }
}
