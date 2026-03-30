package egovframework.com.sec.auth;

import egovframework.com.cmm.LoginVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

/*@Component
public class EgovAuthenticationProvider implements AuthenticationProvider {

    @Resource(name = "loginService")
    private EgovLoginService loginService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        String password = authentication.getCredentials() == null ? "" : authentication.getCredentials().toString();

        LoginVO loginRequest = new LoginVO();
        loginRequest.setId(username);
        loginRequest.setPassword(password);
        loginRequest.setUserSe("USR");

        LoginVO loginVO;
        try {
            loginVO = loginService.actionLogin(loginRequest);
        } catch (Exception ex) {
            throw new BadCredentialsException("Authentication failed", ex);
        }

        if (loginVO == null || loginVO.getId() == null || loginVO.getId().isEmpty()) {
            throw new BadCredentialsException("Invalid username or password");
        }

        return new UsernamePasswordAuthenticationToken(loginVO, null, createAuthorities(loginVO));
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }

    private List<GrantedAuthority> createAuthorities(LoginVO loginVO) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

        if (loginVO.getUserSe() != null && !loginVO.getUserSe().isEmpty()) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + loginVO.getUserSe()));
        }

        return authorities;
    }
}*/
