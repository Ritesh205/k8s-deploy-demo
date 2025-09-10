package com.technovator.k8s_deploy_demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.technovator.k8s_deploy_demo.config.AppConfig;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class WelcomeController {

    private final AppConfig appConfig;

    @GetMapping("/welcome")
    public String welcome() {
        return appConfig.getDescription();
    }
}
