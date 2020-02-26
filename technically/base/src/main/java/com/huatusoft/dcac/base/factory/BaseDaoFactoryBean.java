package com.huatusoft.dcac.base.factory;
import com.huatusoft.dcac.base.dao.BaseDaoImpl;
import com.huatusoft.dcac.base.entity.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactory;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactoryBean;
import org.springframework.data.repository.core.RepositoryInformation;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.core.support.RepositoryFactorySupport;
import javax.persistence.EntityManager;
import java.io.Serializable;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/26 15:55
 */
public class BaseDaoFactoryBean<R extends JpaRepository<E, ID>, E extends BaseEntity, ID extends Serializable>
        extends JpaRepositoryFactoryBean<R, E, ID> {

    public BaseDaoFactoryBean(Class<? extends R> repositoryInterface) {
        super(repositoryInterface);
    }

    /**
     * 接到factory之后，把factory扔进spring data jpa
     */
    @Override
    protected RepositoryFactorySupport createRepositoryFactory(EntityManager em) {
        return new BaseDaoFactory(em);
    }

    /**
     * 创建一个内部类，该类不用在外部访问
     * 他的作用是将我们的baseRepository的实现类扔给factoryBean
     *
     * @param <E>
     * @param <ID>
     */

    private class BaseDaoFactory<E extends BaseEntity, ID extends Serializable>
            extends JpaRepositoryFactory {

        private final EntityManager em;

        public BaseDaoFactory(EntityManager em) {
            super(em);
            this.em = em;
        }

        /**
         * 通过这两个方法来确定具体的实现类，也就是Spring Data Jpa具体实例化一个接口的时候会去创建的实现类。
         */
        //设置具体的实现类是BaseRepositoryImpl
        @Override
        protected Object getTargetRepository(RepositoryInformation information) {
            return new BaseDaoImpl<E, ID>((Class<E>) information.getDomainType(), em);
        }

        //设置具体的实现类的class
        @Override
        protected Class<?> getRepositoryBaseClass(RepositoryMetadata metadata) {
            return BaseDaoImpl.class;
        }
    }
}