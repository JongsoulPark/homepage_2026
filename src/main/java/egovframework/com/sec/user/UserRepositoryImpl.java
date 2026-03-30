package egovframework.com.sec.user;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository("userRepository")
public class UserRepositoryImpl extends EgovComAbstractDAO implements UserRepository {

    @Override
    public Optional<User> findByUserId(String userId) {
        User user = selectOne("userDAO.findByUserId", userId);
        return Optional.ofNullable(user);
    }

    @Override
    public void save(User user) {
        insert("userDAO.save", user);
    }
}
