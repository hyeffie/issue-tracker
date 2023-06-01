package com.issuetracker.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
public class LoginController {
    /**
     * 사용자의 허가를 얻은 후 Callback되는 URL
     */
    // @GetMapping("/login")
    // public ResponseEntity<String> getUserCode(@RequestParam String code) {
    //     String accessToken = getAccessToken(code);
    //     String userName = getUserName(accessToken);
    //     return ResponseEntity.ok(userName);
    // }

    public String getAccessToken(String code) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        // // headers.add("client_id", "cc0d42e5a617611e325a");
        // // headers.add("client_secret", "{G}")
        // return restTemplate.postForObject(
        //         "https://github.com/login/oauth/access_token",
        return null;

    }
}
