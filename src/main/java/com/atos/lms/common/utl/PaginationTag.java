package com.atos.lms.common.utl;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;

public class PaginationTag extends SimpleTagSupport {

    private PaginationInfo paginationInfo;
    private String jsFunction;
    private String formId;

    // Setter methods
    public void setPaginationInfo(PaginationInfo paginationInfo) {
        this.paginationInfo = paginationInfo;
    }

    public void setJsFunction(String jsFunction) {
        this.jsFunction = jsFunction;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    @Override
    public void doTag() throws JspException, IOException {
        int currentPage = paginationInfo.getCurrentPageNo();
        int totalPages = (int) Math.ceil((double) paginationInfo.getTotalRecordCount() / paginationInfo.getRecordCountPerPage());

        StringBuilder html = new StringBuilder();
        html.append("<ul class=\"pagination\">");

        // Previous button
        if (currentPage > 1) {
            html.append("<li class=\"page-item\">")
                    .append("<a class=\"page-link\" href=\"javascript:")
                    .append(jsFunction)
                    .append("(\'")
                    .append(formId)
                    .append("\', ")
                    .append(currentPage - 1)
                    .append(")\">이전</a></li>");
        } else {
            html.append("<li class=\"page-item disabled\"><span class=\"page-link\">이전</span></li>");
        }

        // Page numbers
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                html.append("<li class=\"page-item active\"><span class=\"page-link\">")
                        .append(i)
                        .append("</span></li>");
            } else {
                html.append("<li class=\"page-item\">")
                        .append("<a class=\"page-link\" href=\"javascript:")
                        .append(jsFunction)
                        .append("(\'")
                        .append(formId)
                        .append("\', ")
                        .append(i)
                        .append(")\">")
                        .append(i)
                        .append("</a></li>");
            }
        }

        // Next button
        if (currentPage < totalPages) {
            html.append("<li class=\"page-item\">")
                    .append("<a class=\"page-link\" href=\"javascript:")
                    .append(jsFunction)
                    .append("(\'")
                    .append(formId)
                    .append("\', ")
                    .append(currentPage + 1)
                    .append(")\">다음</a></li>");
        } else {
            html.append("<li class=\"page-item disabled\"><span class=\"page-link\">다음</span></li>");
        }

        html.append("</ul>");

        getJspContext().getOut().write(html.toString());
    }

}
