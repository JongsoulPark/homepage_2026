package egovframework.com.sec.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {
    // 업무사용자ID : emplyr_id - NOT NULL
    private String userId;

    // 이메일주소 : email_adres
    private String email;

    // 사용자명 : user_nm - NOT NULL
    private String name;

    // 비밀번호 : password - NOT NULL
    private String password;

    // 비밀번호힌트 : password_hint
    private String passwordHint;

    // 비밀번호정답 : password_cnsr
    private String passwordCnsr;

    // 이동전화번호 : mbtlnum
    private String mbtlnum;

    // 사무실전화번호 : offm_telno
    private String offmTelno;

    // 직위명 : ofcps_nm
    private String ofcpsNm;

    // 소속기관코드 : pstinst_code
    private String pstinstCode;

    // 사용자 상태코드 : emplyrSttusCode
    private String emplyr_sttus_code;

    // 고유 ID : esntl_id
    private String esntlId;


    // DB 에서 넣어줄 값 : sbscrb_de(가입일자), lock_at(잠금여부), lock_cnt(잠금회수 X), lock_last_pnttm(잠금최종시점 X)

    // ihidnum, sexdstn_code, brthdy, fxnum, house_adres, house_end_telno, area_no, detail_adres, zip





}
