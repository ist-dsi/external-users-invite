package org.fenixedu.ext.users.domain;

import java.util.Locale;

import org.fenixedu.academic.util.Bundle;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.commons.i18n.I18N;

public enum InviteState {

    NOT_COMPLETED(null), // after creator submits first step

    COMPLETED(null), // after invited person completes data

    CONFIRMED(Authenticate.getUser()), // data confirmed and accepted

    REJECTED(Authenticate.getUser()); // rejected invite

    private User user;

    private InviteState(User user) {
        setUser(user);
    }

    public String getQualifiedName() {
        return InviteState.class.getSimpleName() + "." + name();
    }

    public String getLocalizedName() {
        return getLocalizedName(I18N.getLocale());
    }

    public String getLocalizedName(Locale locale) {
        return BundleUtil.getString(Bundle.ENUMERATION, locale, getQualifiedName());
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
