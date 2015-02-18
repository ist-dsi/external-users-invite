package org.fenixedu.ext.users.domain;

import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.joda.time.Interval;

public class Invite extends Invite_Base {

    public Invite(User creator, String name, String email, String invitationInstitution, Interval period, String reason,
            String idDocumentNumber, IDDocumentType idDocumentType, String invitedInstitutionAddress,
            String invitedInstitutionName, String contact, String contactSOS) {

        setCreator(creator);
        setBennu(Bennu.getInstance());
        setName(name);
        setEmail(email);
        setInvitationInstitution(invitationInstitution);
        setPeriod(period);
        setReason(reason);
        setInvitedInstitutionAddress(invitedInstitutionAddress);
        setInvitedInstitutionName(invitedInstitutionName);
        setContact(contact);
        setContactSOS(contactSOS);
        setState(InviteState.NOT_COMPLETED);
    }

    public String getCreatorFullName() {
        return getCreator().getProfile().getFullName();
    }
}
