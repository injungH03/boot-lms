package com.atos.lms.common.utl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource("classpath:atos/props/globals.properties")
public class GlobalsProperties {

    // 파일 업로드 이미지 확장자
    @Value("${Globals.fileUpload.Extensions.Images}")
    private String fileUploadImageExtensions;

    // 파일 업로드 확장자
    @Value("${Globals.fileUpload.Extensions}")
    private String fileUploadExtensions;

    // 파일 업로드 최대 크기
    @Value("${Globals.fileUpload.maxSize}")
    private long fileUploadMaxSize;

    // 파일 다운로드 확장자
    @Value("${Globals.fileDownload.Extensions}")
    private String fileDownloadExtensions;

    // 동기화 서버 경로
    @Value("${Globals.SynchrnServerPath}")
    private String synchrnServerPath;

    // 파일 저장 경로
    @Value("${Globals.fileStorePath}")
    private String fileStorePath;

    @Value("${local.boot.url}")
    private String localBootUrl;

    @Value("${local.react.url}")
    private String localReactUrl;

    // Getter methods
    public String getFileUploadImageExtensions() {
        return fileUploadImageExtensions;
    }

    public String getFileUploadExtensions() {
        return fileUploadExtensions;
    }

    public long getFileUploadMaxSize() {
        return fileUploadMaxSize;
    }

    public String getFileDownloadExtensions() {
        return fileDownloadExtensions;
    }

    public String getSynchrnServerPath() {
        return synchrnServerPath;
    }

    public String getFileStorePath() {
        return fileStorePath;
    }

    public String getLocalBootUrl() {
        return localBootUrl;
    }

    public String getLocalReactUrl() {
        return localReactUrl;
    }
}
