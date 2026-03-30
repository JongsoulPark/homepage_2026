package egovframework.com.sec.user;

import java.util.Optional;

public interface UserRepository {
    Optional<User> findByUserId(String userId);

    void save(User user);
}
