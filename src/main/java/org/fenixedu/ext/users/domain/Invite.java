package org.fenixedu.ext.users.domain;

import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.Bennu;
import org.joda.time.Interval;

public class Invite extends Invite_Base {

    public Invite(String name, String email, String invitationInstitution, Interval period, String reason,
            String idDocumentNumber, IDDocumentType idDocumentType, String originInstitutionName,
            String originInstitutionAddress, String contact, String contactSOS) {

        super();
        setBennu(Bennu.getInstance());
        setName(name);
        setEmail(email);
        setInvitationInstitution(invitationInstitution);
        setPeriod(period);
        setReason(reason);
        setOriginInstitutionAddress(originInstitutionAddress);
        setOriginInstitutionName(originInstitutionName);
        setContact(contact);
        setContactSOS(contactSOS);
    }

}
