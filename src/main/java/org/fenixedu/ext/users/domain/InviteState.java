package org.fenixedu.ext.users.domain;

//TODO: comparator
//TODO: toString

public enum InviteState {

    NOT_COMPLETED, //after creator submits first step

    COMPLETED, //after invited person completes data

    CONFIRMED_BY_CREATOR, //invite creator confirms data

    REJECTED_BY_CREATOR, //invite creator rejects data

    CONFIRMED_BY_MANAGER, //system manager accepts invite

    REJECTED_BY_MANAGER //system manager rejects invite
}
