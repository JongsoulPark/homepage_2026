package egovframework.com.sec.config;

import egovframework.com.sec.auth.EgovAuthenticationProvider;
import egovframework.com.sec.handler.EgovAuthenticationFailureHandler;
import egovframework.com.sec.handler.EgovAuthenticationSuccessHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final EgovAuthenticationProvider authenticationProvider;
    private final EgovAuthenticationSuccessHandler successHandler;
    private final EgovAuthenticationFailureHandler failureHandler;

    public SecurityConfig(EgovAuthenticationProvider authenticationProvider,
            EgovAuthenticationSuccessHandler successHandler,
            EgovAuthenticationFailureHandler failureHandler) {
        this.authenticationProvider = authenticationProvider;
        this.successHandler = successHandler;
        this.failureHandler = failureHandler;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authenticationProvider(authenticationProvider)
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers(publicMatchers()).permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/uat/uia/egovLoginUsr.do")
                .loginProcessingUrl("/uat/uia/actionLogin.do")
                .usernameParameter("id")
                .passwordParameter("password")
                .successHandler(successHandler)
                .failureHandler(failureHandler)
                .permitAll()
            )
            .logout(logout -> logout
                .logoutRequestMatcher(new AntPathRequestMatcher("/uat/uia/actionLogout.do"))
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .logoutSuccessUrl("/cmm/main/mainPage.do")
            );

        return http.build();
    }

    private RequestMatcher[] publicMatchers() {
        return new RequestMatcher[] {
            new AntPathRequestMatcher("/"),
            new AntPathRequestMatcher("/index.jsp"),
            new AntPathRequestMatcher("/common/**"),
            new AntPathRequestMatcher("/css/**"),
            new AntPathRequestMatcher("/js/**"),
            new AntPathRequestMatcher("/images/**"),
            new AntPathRequestMatcher("/uat/uia/egovLoginUsr.do"),
            new AntPathRequestMatcher("/uat/uia/actionLogin.do"),
            new AntPathRequestMatcher("/EgovPageLink.do"),
            new AntPathRequestMatcher("/cmm/main/mainPage.do")
        };
    }
}
