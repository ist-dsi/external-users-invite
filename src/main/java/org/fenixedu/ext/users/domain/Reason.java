package org.fenixedu.ext.users.domain;


public class Reason extends Reason_Base {

    public Reason(String name, String description) {
        super();
        setName(name);
        setDescription(description);
        setInviteConfiguration(InviteConfiguration.getInstance());
    }

}
