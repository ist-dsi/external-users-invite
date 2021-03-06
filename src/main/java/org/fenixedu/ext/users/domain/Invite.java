package org.fenixedu.ext.users.domain;

import java.nio.charset.StandardCharsets;
import java.util.Comparator;
import java.util.UUID;

import org.fenixedu.academic.domain.organizationalStructure.Unit;
import org.fenixedu.academic.domain.person.Gender;
import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.joda.time.DateTime;
import org.joda.time.Interval;

import com.google.common.hash.Hashing;

public class Invite extends Invite_Base {

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    public final static Comparator<Invite> COMPARATOR_BY_CREATION_TIME = (arg0, arg1) -> arg1.getCreationTime().compareTo(
            arg0.getCreationTime());

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
        setIdDocumentNumber(idDocumentNumber);
        setIdDocumentType(idDocumentType);
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
        return getReason() != null ? getReason().getName() : BundleUtil.getString(BUNDLE, "reason.other.name");
    }

    public String getReasonDescription() {
        return getReason() != null ? getReason().getDescription() : getOtherReason();
    }

    public String getFullName() {
        return String.join(" ", getGivenName(), getFamilyNames());
    }

    public String getPeriodFormatted() {
        return getPeriod().getStart().toString("dd/MM/YYY") + " - " + getPeriod().getEnd().toString("dd/MM/YYY");
    }
}
