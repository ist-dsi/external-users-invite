package org.fenixedu.ext.users.domain;

import java.util.Locale;

import org.fenixedu.academic.util.Bundle;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.commons.i18n.I18N;

public enum InviteState {

    NOT_COMPLETED, //after creator submits first step

    COMPLETED, //after invited person completes data

    CONFIRMED_BY_CREATOR, //invite creator confirms data

    REJECTED_BY_CREATOR, //invite creator rejects data

    CONFIRMED_BY_MANAGER, //system manager accepts invite

    REJECTED_BY_MANAGER; //system manager rejects invite

    public String getQualifiedName() {
        return InviteState.class.getSimpleName() + "." + name();
    }

    public String getLocalizedName() {
        return getLocalizedName(I18N.getLocale());
    }

    public String getLocalizedName(Locale locale) {
        return BundleUtil.getString(Bundle.ENUMERATION, locale, getQualifiedName());
    }
}
