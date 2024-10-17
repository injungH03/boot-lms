package com.atos.lms.common.utl;

import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;


public class ExcelUtil {
	
    /**
     * 엑셀 데이터 목록 다운로드
     * @param <T>
     * @param response
     * @param dataList
     * @param sheetName
     * @param fileName
     * @param fieldToHeaderMap
     * @throws Exception
     */
    public static <T> void exportToExcel(HttpServletResponse response, List<T> dataList, String sheetName, String fileName, Map<String, String> fieldToHeaderMap) throws Exception {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(sheetName);

        if (dataList == null || dataList.isEmpty()) {
            workbook.write(response.getOutputStream());
            workbook.close();
            return;
        }

        // 헤더 생성 및 최대 길이 계산을 위한 배열 초기화
        Field[] fields = dataList.get(0).getClass().getDeclaredFields();
        int[] maxColumnWidths = new int[fields.length];

        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < fields.length; i++) {
            fields[i].setAccessible(true);
            Cell cell = headerRow.createCell(i);
            String headerName = fieldToHeaderMap.get(fields[i].getName());
            String headerValue = headerName != null ? headerName : fields[i].getName();
            cell.setCellValue(headerValue);

            // 헤더 길이를 초기값으로 설정
            maxColumnWidths[i] = headerValue.getBytes(StandardCharsets.UTF_8).length;
        }

        // 데이터 생성 및 최대 길이 계산
        int rowNum = 1;
        for (T data : dataList) {
            Row row = sheet.createRow(rowNum++);
            for (int i = 0; i < fields.length; i++) {
                Cell cell = row.createCell(i);
                try {
                    Object value = fields[i].get(data);
                    String cellValue = value != null ? value.toString() : "";
                    cell.setCellValue(cellValue);

                    // 현재 셀의 길이와 비교하여 최대 길이 갱신
                    maxColumnWidths[i] = Math.max(maxColumnWidths[i], cellValue.getBytes(StandardCharsets.UTF_8).length);
                } catch (IllegalAccessException e) {
                    cell.setCellValue("");
                }
            }
        }

        // 최대 길이에 따라 각 열의 너비 조정
        for (int i = 0; i < maxColumnWidths.length; i++) {
            sheet.setColumnWidth(i, maxColumnWidths[i] * 256); // POI에서 컬럼 너비는 1/256th of a character width로 설정됨
        }

        // 파일 다운로드를 위한 응답 설정
        String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment;filename*=UTF-8''" + encodedFileName + ".xlsx");

        // 엑셀 파일을 HTTP 응답으로 내보내기
        workbook.write(response.getOutputStream());
        workbook.close();
    }
    
    
    /**
     * 엑셀 양식 다운로드
     * @param response
     * @param sheetName
     * @param fileName
     * @param fieldToHeaderMap
     * @throws Exception
     */
    public static void exportTemplateToExcel(HttpServletResponse response, String sheetName, String fileName, Map<String, String> fieldToHeaderMap) throws Exception {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet(sheetName);

        // 헤더 생성
        Row headerRow = sheet.createRow(0);
        int[] maxColumnWidths = new int[fieldToHeaderMap.size()]; // 각 열의 최대 길이 기록용 배열
        int colIndex = 0;

        for (Map.Entry<String, String> entry : fieldToHeaderMap.entrySet()) {
            Cell cell = headerRow.createCell(colIndex);
            String headerName = entry.getValue(); // 헤더 값 가져오기
            cell.setCellValue(headerName);

            // 헤더 길이를 초기값으로 설정
            maxColumnWidths[colIndex] = headerName.getBytes(StandardCharsets.UTF_8).length;
            colIndex++;
        }

        // 최대 길이에 따라 각 열의 너비 조정
        for (int i = 0; i < maxColumnWidths.length; i++) {
            sheet.setColumnWidth(i, maxColumnWidths[i] * 256); // 너비 조정
        }

        // 파일 다운로드를 위한 응답 설정
        String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment;filename*=UTF-8''" + encodedFileName + ".xlsx");

        // 엑셀 파일을 HTTP 응답으로 내보내기
        workbook.write(response.getOutputStream());
        workbook.close();
    }
    
    /**
     * 셀처리
     * @param cell
     * @return
     */
    public static String getCellValue(Cell cell) {
        if (cell == null) {
            return "";  // 빈 셀 처리
        }

        // 셀 타입에 따른 값 가져오기
        CellType cellType = cell.getCellType();
        switch (cellType) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                // 숫자형 셀인 경우 날짜 포맷일 수도 있으므로 추가 처리
                if (DateUtil.isCellDateFormatted(cell)) {
                    // 날짜일 경우 날짜 형식으로 반환
                    return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                } else {
                    // 숫자일 경우 소수점 없이 반환
                    return String.valueOf((long) cell.getNumericCellValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                return cell.getCellFormula();
            default:
                return "";
        }
    }

}
