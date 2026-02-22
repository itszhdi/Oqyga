package com.oqyga.OqygaBackend.db.migration;

import com.oqyga.OqygaBackend.entities.Organisator;
import com.oqyga.OqygaBackend.entities.Role;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.OrganisatorRepository;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class R__Sync_Organisators extends BaseJavaMigration {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrganisatorRepository organisatorRepository;

    @Override
    public void migrate(Context context) throws Exception {

        List<User> organisatorUsers = userRepository.findByRole(Role.ORGANISATOR);

        int addedCount = 0;
        for (User user : organisatorUsers) {

            if (!organisatorRepository.existsByUser(user)) {
                Organisator newOrganisator = Organisator.builder()
                        .user(user)
                        .build();

                organisatorRepository.save(newOrganisator);
                addedCount++;
                System.out.println("Synchronized new Organisator for user ID: " + user.getUserId());
            }
        }

        System.out.println("Repeatable Java Migration (R-type) completed. Total new organisators added: " + addedCount);
    }
}