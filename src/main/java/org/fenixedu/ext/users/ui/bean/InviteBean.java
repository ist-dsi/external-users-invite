package org.fenixedu.ext.users.ui.bean;

import org.fenixedu.academic.domain.organizationalStructure.Unit;
import org.fenixedu.academic.domain.person.Gender;
import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.domain.Reason;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

public class InviteBean {

    private String givenName;
    private String familyNames;
    private Gender gender;
    private String email;
    private String startDate;
    private String endDate;
    private String idDocumentNumber;
    private IDDocumentType idDocumentType;
    private String invitedInstitutionName;
    private String invitedInstitutionAddress;
    private String contact;
    private String contactSOS;
    private User creator;
    private Invite invite;
    private Reason reason;
    private String otherReason;
    private String reasonName;
    private String reasonDescription;
    private Unit unit;

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdDocumentNumber() {
        return idDocumentNumber;
    }

    public void setIdDocumentNumber(String idDocumentNumber) {
        this.idDocumentNumber = idDocumentNumber;
    }

    public IDDocumentType getIdDocumentType() {
        return idDocumentType;
    }

    public void setIdDocumentType(IDDocumentType idDocumentType) {
        this.idDocumentType = idDocumentType;
    }

    public String getInvitedInstitutionName() {
        return invitedInstitutionName;
    }

    public void setInvitedInstitutionName(String invitedInstitutionName) {
        this.invitedInstitutionName = invitedInstitutionName;
    }

    public String getInvitedInstitutionAddress() {
        return invitedInstitutionAddress;
    }

    public void setInvitedInstitutionAddress(String invitedInstitutionAddress) {
        this.invitedInstitutionAddress = invitedInstitutionAddress;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactSOS() {
        return contactSOS;
    }

    public void setContactSOS(String contactSOS) {
        this.contactSOS = contactSOS;
    }

    public String getStartDate() {
        return startDate;
    }

    public DateTime getStartDateTime() {
        return startDate != null ? ISODateTimeFormat.dateTime().parseDateTime(startDate) : null;
    }

    public String getStartDateFormatted() {
        DateTime dateTime = getStartDateTime();
        return dateTime != null ? dateTime.toString("dd/MM/YYY") : null;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public DateTime getEndDateTime() {
        return endDate != null ? ISODateTimeFormat.dateTime().parseDateTime(endDate) : null;
    }

    public String getEndDateFormatted() {
        DateTime dateTime = getEndDateTime();
        return dateTime != null ? dateTime.toString("dd/MM/YYY") : null;
    }

    public User getCreator() {
        return creator;
    }

    public String getCreatorFullName() {
        return creator.getProfile().getFullName();
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public Invite getInvite() {
        return invite;
    }

    public void setInvite(Invite invite) {
        this.invite = invite;
    }

    public String getFamilyNames() {
        return familyNames;
    }

    public void setFamilyNames(String familyNames) {
        this.familyNames = familyNames;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Reason getReason() {
        return reason;
    }

    public void setReason(Reason reason) {
        this.reason = reason;
    }

    public String getOtherReason() {
        return otherReason;
    }

    public void setOtherReason(String otherReason) {
        this.otherReason = otherReason;
    }

    public String getReasonName() {
        return this.reasonName;
    }

    public String getReasonDescription() {
        return this.reasonDescription;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public String getFullName() {
        return String.join(" ", getGivenName(), getFamilyNames());
    }

    public InviteBean() {

    }

    public InviteBean(Invite invite) {
        this.givenName = (invite.getGivenName());
        this.familyNames = invite.getFamilyNames();
        this.gender = invite.getGender();
        this.email = invite.getEmail();
        this.creator = invite.getCreator();
        this.otherReason = invite.getOtherReason();
        this.reasonName = invite.getReasonName();
        this.reasonDescription = invite.getReasonDescription();
        this.unit = invite.getUnit();
        this.setInvite(invite);

        Interval period = invite.getPeriod();
        DateTimeFormatter formatter = ISODateTimeFormat.dateTime();
        this.startDate = period.getStart().toString(formatter);
        this.endDate = period.getEnd().toString(formatter);

        this.idDocumentType = invite.getIdDocumentType();
        this.idDocumentNumber = invite.getIdDocumentNumber();
        this.invitedInstitutionName = invite.getInvitedInstitutionName();
        this.invitedInstitutionAddress = invite.getInvitedInstitutionAddress();
        this.contact = invite.getContact();
        this.contactSOS = invite.getContactSOS();
    }

    public static class Builder {
        private final String givenName;
        private final String familyNames;
        private final Gender gender;
        private final String email;
        private final String startDate;
        private final String endDate;
        private final String idDocumentNumber;
        private final IDDocumentType idDocumentType;
        private final String invitedInstitutionName;
        private final String invitedInstitutionAddress;
        private final String contact;
        private final String contactSOS;
        private final User creator;
        private final Reason reason;
        private final String otherReason;
        private final Unit unit;

        public Builder(InviteBean inviteBean) {

            this.givenName = inviteBean.getGivenName();
            this.familyNames = inviteBean.getFamilyNames();
            this.gender = inviteBean.getGender();
            this.email = inviteBean.getEmail();
            this.startDate = inviteBean.getStartDate();
            this.endDate = inviteBean.getEndDate();
            this.reason = inviteBean.getReason();
            this.otherReason = inviteBean.getOtherReason();
            this.creator = inviteBean.getCreator();
            this.unit = inviteBean.getUnit();

            this.idDocumentType = inviteBean.getIdDocumentType();
            this.idDocumentNumber = inviteBean.getIdDocumentNumber();
            this.invitedInstitutionName = inviteBean.getInvitedInstitutionName();
            this.invitedInstitutionAddress = inviteBean.getInvitedInstitutionAddress();
            this.contact = inviteBean.getContact();
            this.contactSOS = inviteBean.getContactSOS();
        }

        @Atomic(mode = TxMode.WRITE)
        public Invite build() {

            DateTimeFormatter formatter = ISODateTimeFormat.date();

            DateTime startDateDT = formatter.parseDateTime(startDate);
            DateTime endDateDT = formatter.parseDateTime(endDate).withTime(23, 59, 59, 999);

            Interval period = new Interval(startDateDT, endDateDT);

            return new Invite(creator, givenName, familyNames, gender, email, period, reason, otherReason, unit,
                    idDocumentNumber, idDocumentType, invitedInstitutionName, invitedInstitutionAddress, contact, contactSOS);
        }
    }
}
