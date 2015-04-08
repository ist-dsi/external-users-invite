package org.fenixedu.ext.users.domain;

import java.util.Collection;

import org.fenixedu.academic.domain.exceptions.DomainException;
import org.fenixedu.bennu.core.domain.Bennu;

public class Reason extends Reason_Base {

    public Reason(String name, String description) {
        super();
        setName(name);
        setDescription(description);
        setActive(true);
        setBennu(Bennu.getInstance());
    }

    @Override
    protected void checkForDeletionBlockers(Collection<String> blockers) {
        super.checkForDeletionBlockers(blockers);

        if (!getInviteSet().isEmpty()) {
            blockers.add("cant.delete.reason.existent.invites");
        }
    }

    public void delete() {

        DomainException.throwWhenDeleteBlocked(getDeletionBlockers());

        this.getInviteSet().clear();
        this.setName(null);
        this.setDescription(null);

        this.setBennu(null);

        deleteDomainObject();
    }

}
