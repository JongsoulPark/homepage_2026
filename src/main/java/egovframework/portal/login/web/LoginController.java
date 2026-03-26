package egovframework.portal.login.web;

import egovframework.portal.login.service.LoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;

    @GetMapping("/portal/login/view.do")
    public String loginView() {
        return "/portal/login/view";
    }

    /*@GetMapping("/portal/login/")*/
}
