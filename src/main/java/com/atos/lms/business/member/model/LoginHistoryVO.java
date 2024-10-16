package com.atos.lms.business.member.model;

import lombok.Data;

@Data
public class LoginHistoryVO {
    private Long historyCode;               // 이력의 고유 ID
    private String memberId;        // 로그인한 사용자 ID
    private String roleName;          // 로그인한 사용자의 권한 정보
    private String loginTime; // 로그인한 시간
    private String ipAddress;       // 로그인 시 IP 주소
    private String userAgent;       // 로그인 시 사용한 브라우저 정보
    private String deviceType;      // 로그인한 기기 타입
    private String loginStatus;     // 로그인 상태 (성공, 실패 등)
    private String loginFailReason; // 로그인 실패 시 실패 이유
    private String location;        // 로그인한 위치 (IP 기반)
    private String createTime; // 레코드 생성 시간
}
