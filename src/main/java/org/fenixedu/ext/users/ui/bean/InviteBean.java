package org.fenixedu.ext.users.ui.bean;

import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.ext.users.domain.Invite;
import org.joda.time.DateTime;
import org.joda.time.Interval;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

public class InviteBean {

    private String name;
    private String email;
    private String invitationInstitution;
    private String startDate;
    private String endDate;
    private String reason;
    private String idDocumentNumber;
    private IDDocumentType idDocumentType;
    private String originInstitutionName;
    private String originInstitutionAddress;
    private String contact;
    private String contactSOS;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getInvitationInstitution() {
        return invitationInstitution;
    }

    public void setInvitationInstitution(String invitationInstitution) {
        this.invitationInstitution = invitationInstitution;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

    public String getOriginInstitutionName() {
        return originInstitutionName;
    }

    public void setOriginInstitutionName(String originInstitutionName) {
        this.originInstitutionName = originInstitutionName;
    }

    public String getOriginInstitutionAddress() {
        return originInstitutionAddress;
    }

    public void setOriginInstitutionAddress(String originInstitutionAddress) {
        this.originInstitutionAddress = originInstitutionAddress;
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
        return ISODateTimeFormat.dateTime().parseDateTime(startDate);
    }

    public String getStartDateFormmated() {
        return getStartDateTime().toString("dd-MM-YYY HH:mm");
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
        return ISODateTimeFormat.dateTime().parseDateTime(endDate);
    }

    public String getEndDateFormmated() {
        return getEndDateTime().toString("dd-MM-YYY HH:mm");
    }

    public InviteBean() {

    }

    public InviteBean(Invite invite) {
        this.name = invite.getName();
        this.email = invite.getEmail();
        this.invitationInstitution = invite.getInvitationInstitution();
        this.reason = invite.getReason();

        Interval period = invite.getPeriod();
        DateTimeFormatter formatter = ISODateTimeFormat.dateTime();
        this.startDate = period.getStart().toString(formatter);
        this.endDate = period.getEnd().toString(formatter);

        this.idDocumentType = invite.getIdDocumentType();
        this.idDocumentNumber = invite.getIdDocumentNumber();
        this.originInstitutionName = invite.getOriginInstitutionName();
        this.originInstitutionAddress = invite.getOriginInstitutionAddress();
        this.contact = invite.getContact();
        this.contactSOS = invite.getContactSOS();
    }

    public static class Builder {
        private final String name;
        private final String email;
        private final String invitationInstitution;
        private final String startDate;
        private final String endDate;
        private final String reason;
        private final String idDocumentNumber;
        private final IDDocumentType idDocumentType;
        private final String originInstitutionName;
        private final String originInstitutionAddress;
        private final String contact;
        private final String contactSOS;

        public Builder(InviteBean inviteBean) {

            this.name = inviteBean.getName();
            this.email = inviteBean.getEmail();
            this.invitationInstitution = inviteBean.getInvitationInstitution();
            this.startDate = inviteBean.getStartDate();
            this.endDate = inviteBean.getEndDate();
            this.reason = inviteBean.getReason();

            this.idDocumentType = inviteBean.getIdDocumentType();
            this.idDocumentNumber = inviteBean.getIdDocumentNumber();
            this.originInstitutionName = inviteBean.getOriginInstitutionName();
            this.originInstitutionAddress = inviteBean.getOriginInstitutionAddress();
            this.contact = inviteBean.getContact();
            this.contactSOS = inviteBean.getContactSOS();
        }

        @Atomic(mode = TxMode.WRITE)
        public Invite build() {

            DateTimeFormatter formatter = ISODateTimeFormat.dateTime();

            DateTime startDateDT = formatter.parseDateTime(startDate);
            DateTime endDateDT = formatter.parseDateTime(endDate);

            Interval period = new Interval(startDateDT, endDateDT);

            return new Invite(name, email, invitationInstitution, period, reason, idDocumentNumber, idDocumentType,
                    originInstitutionName, originInstitutionAddress, contact, contactSOS);
        }
    }
}
