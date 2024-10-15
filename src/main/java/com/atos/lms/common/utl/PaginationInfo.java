package com.atos.lms.common.utl;

public class PaginationInfo {

    private int currentPageNo = 1;          // 현재 페이지 번호
    private int recordCountPerPage = 10;    // 페이지당 레코드 수
    private int pageSize = 10;              // 페이징 사이즈 (한 번에 표시할 페이지 번호 수)
    private int totalRecordCount;           // 전체 레코드 수

    // 계산된 필드
    private int firstRecordIndex;
    private int lastRecordIndex;

    // Getter and Setter methods

    public int getCurrentPageNo() {
        return currentPageNo;
    }

    public void setCurrentPageNo(int currentPageNo) {
        this.currentPageNo = currentPageNo;
        calculate();
    }

    public int getRecordCountPerPage() {
        return recordCountPerPage;
    }

    public void setRecordCountPerPage(int recordCountPerPage) {
        this.recordCountPerPage = recordCountPerPage;
        calculate();
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
        calculate();
    }

    public int getTotalRecordCount() {
        return totalRecordCount;
    }

    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
        calculateTotal();
    }

    public int getFirstRecordIndex() {
        return firstRecordIndex;
    }

    public int getLastRecordIndex() {
        return lastRecordIndex;
    }

    // 현재 페이지 번호과 레코드 수를 기반으로 첫 번째 인덱스와 마지막 인덱스를 계산
    private void calculate() {
        this.firstRecordIndex = (currentPageNo - 1) * recordCountPerPage;
        this.lastRecordIndex = firstRecordIndex + recordCountPerPage;
    }

    // 전체 레코드 수를 기반으로 추가적인 계산이 필요할 경우 사용
    private void calculateTotal() {
        // 예를 들어, 마지막 인덱스가 전체 레코드 수를 초과하지 않도록 조정
        if (lastRecordIndex > totalRecordCount) {
            this.lastRecordIndex = totalRecordCount;
        }
    }
}
