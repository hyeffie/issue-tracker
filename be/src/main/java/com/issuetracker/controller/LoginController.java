package com.issuetracker.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.issuetracker.domain.User;
import com.issuetracker.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class LoginController {

    private final UserRepository userRepository;

    @GetMapping("/api/oauth/login")
    public User githubLogin(@RequestParam String code) throws JsonProcessingException {
        String accessToken = getAccessToken(code);
        User user = getAuthLoginId(accessToken);
        if (userRepository.isJoinedUser(user.getLoginId()) > 0) {
            return userRepository.findByLoginId(user.getLoginId());
        }
        return userRepository.save(User.of(user.getLoginId(), user.getProfileUrl()));
    }

    private String getAccessToken(String code) throws JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded");

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("client_id", "cc0d42e5a617611e325a");
        params.add("client_secret", "d7ca1f3354707d0dcb23ba4ecdee292d16f4d416");
        params.add("code", code);
        params.add("grant_type", "authorization_code");
        params.add("redirect_uri", "http://localhost:3000/oauth");

        HttpEntity<MultiValueMap<String, String>> accessTokenRequest = new HttpEntity<>(params, headers);

        ResponseEntity<String> accessTokenResponse = restTemplate.exchange(
                "https://github.com/login/oauth/access_token",
                HttpMethod.POST,
                accessTokenRequest,
                String.class
        );

        String pattern = "access_token=([^&]+)";

        // 패턴 매칭
        Pattern regex = Pattern.compile(pattern);
        Matcher matcher = regex.matcher(accessTokenResponse.getBody());

        String accessToken = "";
        // 매칭된 결과 가져오기
        if (matcher.find()) {
            accessToken = matcher.group(1);
        }

        return accessToken;
    }

    private User getAuthLoginId(String accessToken) throws JsonProcessingException {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);

        RestTemplate restTemplate = new RestTemplate();

        HttpEntity userResourceRequest = new HttpEntity(headers);
        ResponseEntity<String> userResourceResponse = restTemplate.exchange(
                "https://api.github.com/user",
                HttpMethod.GET,
                userResourceRequest,
                String.class
        );
        JsonNode json = new ObjectMapper().readTree(userResourceResponse.getBody());
        return User.of(json.get("login").asText(), json.get("avatar_url").asText());
    }
}
