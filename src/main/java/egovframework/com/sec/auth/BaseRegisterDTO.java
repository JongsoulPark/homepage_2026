package egovframework.com.sec.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BaseRegisterDTO {

    private String userId;
    private String password;
    private String passwordHint;
    private String passwordAnswer;
    private String name;
    private String email;
    private String phone;
    private String statusCode;
    private String id;

}
