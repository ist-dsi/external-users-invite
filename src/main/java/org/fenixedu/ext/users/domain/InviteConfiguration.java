package org.fenixedu.ext.users.domain;

import org.fenixedu.bennu.core.domain.Bennu;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

public class InviteConfiguration extends InviteConfiguration_Base {

    private InviteConfiguration() {
        super();
        setBennu(Bennu.getInstance());
        setExpirationDays(365);
    }

    public static InviteConfiguration getInstance() {
        if (Bennu.getInstance().getInviteConfiguration() == null) {
            return initialize();
        }
        return Bennu.getInstance().getInviteConfiguration();
    }

    @Atomic(mode = TxMode.WRITE)
    private static InviteConfiguration initialize() {
        if (Bennu.getInstance().getInviteConfiguration() == null) {
            return new InviteConfiguration();
        }
        return Bennu.getInstance().getInviteConfiguration();
    }
}
