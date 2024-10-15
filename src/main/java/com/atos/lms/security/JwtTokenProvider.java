package com.atos.lms.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtTokenProvider {

    @Value("${jwt.secret}")
    private String JWT_SECRET;

    private final long JWT_EXPIRATION_MS = 86400000;    // JWT 만료 시간 (1일)

    // JWT 토큰 생성
    public String generateToken(String username) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + JWT_EXPIRATION_MS);

        return JWT.create()
                .withSubject(username)
                .withIssuedAt(now)
                .withExpiresAt(expiryDate)
                .sign(Algorithm.HMAC512(JWT_SECRET));  // HMAC512 알고리즘 사용
    }

    // JWT 토큰에서 사용자 정보 추출
    public String getUsernameFromJWT(String token) {
        DecodedJWT decodedJWT = JWT.decode(token);  // 토큰 디코딩
        return decodedJWT.getSubject();  // subject에서 사용자 이름 추출
    }

    // JWT 토큰 유효성 검증
    public boolean validateToken(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC512(JWT_SECRET);
            JWTVerifier verifier = JWT.require(algorithm).build();
            verifier.verify(token);  // 유효성 검증
            return true;
        } catch (JWTVerificationException exception) {
            // 유효성 검증 실패 시 예외 처리
            return false;
        }
    }

}
