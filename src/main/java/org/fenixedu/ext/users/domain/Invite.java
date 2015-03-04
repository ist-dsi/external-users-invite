package org.fenixedu.ext.users.domain;

import java.nio.charset.StandardCharsets;
import java.util.Comparator;
import java.util.UUID;

import org.fenixedu.academic.domain.organizationalStructure.Unit;
import org.fenixedu.academic.domain.person.Gender;
import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.joda.time.DateTime;
import org.joda.time.Interval;

import com.google.common.hash.Hashing;

public class Invite extends Invite_Base {

    public final static Comparator<Invite> COMPARATOR_BY_CREATION_TIME = new Comparator<Invite>() {

        @Override
        public int compare(Invite arg0, Invite arg1) {

            return arg1.getCreationTime().compareTo(arg0.getCreationTime());
        }
    };

    public Invite(User creator, String givenName, String familyNames, Gender gender, String email, Interval period,
            Reason reason, String otherReason, Unit unit, String idDocumentNumber, IDDocumentType idDocumentType,
            String invitedInstitutionAddress, String invitedInstitutionName, String contact, String contactSOS) {

        setCreator(creator);
        setBennu(Bennu.getInstance());
        setGivenName(givenName);
        setFamilyNames(familyNames);
        setGender(gender);
        setEmail(email);
        setPeriod(period);
        setReason(reason);
        setOtherReason(otherReason);
        setUnit(unit);
        setInvitedInstitutionAddress(invitedInstitutionAddress);
        setInvitedInstitutionName(invitedInstitutionName);
        setContact(contact);
        setContactSOS(contactSOS);
        setState(InviteState.NOT_COMPLETED);
        setCreationTime(DateTime.now());
        setHash(Hashing.sha512().hashString(UUID.randomUUID().toString(), StandardCharsets.UTF_8).toString());
    }

    public String getCreatorFullName() {
        return getCreator().getProfile().getFullName();
    }

    public String getReasonName() {
        return this.getReason() != null ? this.getReason().getName() : "Other Reason"; //TODO: fix string
    }

    public String getReasonDescription() {
        return this.getReason() != null ? this.getReason().getDescription() : this.getOtherReason();
    }
}
