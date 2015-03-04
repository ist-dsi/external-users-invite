package org.fenixedu.ext.users.domain;

import org.fenixedu.bennu.core.domain.Bennu;

public class Reason extends Reason_Base {

    public Reason(String name, String description) {
        super();
        setName(name);
        setDescription(description);
        setBennu(Bennu.getInstance());
    }

}
