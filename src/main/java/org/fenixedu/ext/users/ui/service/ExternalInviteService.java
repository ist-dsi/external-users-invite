package org.fenixedu.ext.users.ui.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.academic.domain.organizationalStructure.Unit;
import org.fenixedu.academic.domain.util.email.Message;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.domain.UserLoginPeriod;
import org.fenixedu.bennu.core.domain.UserProfile;
import org.fenixedu.bennu.core.groups.DynamicGroup;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.bennu.core.util.CoreConfiguration;
import org.fenixedu.commons.i18n.I18N;
import org.fenixedu.ext.users.ExternalInviteConfiguration;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.domain.InviteState;
import org.fenixedu.ext.users.domain.Reason;
import org.fenixedu.ext.users.ui.bean.InviteBean;
import org.fenixedu.ext.users.ui.bean.ReasonBean;
import org.fenixedu.ext.users.ui.exception.ChangeInviteFinalStateException;
import org.fenixedu.ext.users.ui.exception.ExpiredInviteException;
import org.fenixedu.ext.users.ui.exception.ExternalInviteException;
import org.fenixedu.ext.users.ui.exception.NonUniqueInviteHashException;
import org.fenixedu.ext.users.ui.exception.UnauthorisedUserException;
import org.fenixedu.ext.users.ui.exception.UnexistentInviteHashException;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;

@Service
public class ExternalInviteService {

    @Autowired
    MessageSource messageSource;

    private String getInstitutionName() {
        return Bennu.getInstance().getInstitutionUnit().getPresentationName();
    }

    private List<Invite> filterInvitesByState(List<Invite> invites, InviteState st) {
        return invites.stream().filter(i -> i.getState().equals(st)).sorted(Invite.COMPARATOR_BY_CREATION_TIME)
                .collect(Collectors.toList());
    }

    public List<Invite> getUserInvites(User user) {

        boolean isManager = DynamicGroup.get("managers").isMember(user);

        if (isManager) {
            return Bennu.getInstance().getInviteSet().stream().sorted(Invite.COMPARATOR_BY_CREATION_TIME)
                    .collect(Collectors.toList());
        } else {
            return Bennu.getInstance().getInviteSet().stream()
                    .filter(i -> i.getCreator() != null && i.getCreator().equals(Authenticate.getUser()))
                    .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
        }
    }

    public List<Invite> filterUnfinishedInvites(List<Invite> invites) {
        return Stream
                .concat(filterInvitesByState(invites, InviteState.COMPLETED).stream(),
                        filterInvitesByState(invites, InviteState.NOT_COMPLETED).stream()).distinct()
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterFinishedInvites(List<Invite> invites) {
        return Lists
                .newArrayList(
                        Iterables.concat(filterInvitesByState(invites, InviteState.CONFIRMED),
                                filterInvitesByState(invites, InviteState.REJECTED))).stream().distinct()
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterConfirmedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.CONFIRMED).stream().distinct()
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterRejectedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.REJECTED).stream().distinct().sorted(Invite.COMPARATOR_BY_CREATION_TIME)
                .collect(Collectors.toList());
    }

    public List<Invite> filterCompletedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.COMPLETED);
    }

    public List<Invite> filterNotCompletedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.NOT_COMPLETED);
    }

    @Atomic(mode = TxMode.WRITE)
    public void sendInvite(Invite invite) {

        String bcc = invite.getEmail();

        String subject =
                messageSource.getMessage("external.user.invite.message.subject", new Object[] { getInstitutionName(),
                        Authenticate.getUser().getProfile().getFullName() }, I18N.getLocale());

        String link =
                CoreConfiguration.getConfiguration().applicationUrl() + "/public-external-invite/completeInvite/"
                        + invite.getHash();

        String body =
                messageSource.getMessage("external.user.invite.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), getInstitutionName(), invite.getReasonName(), link,
                        invite.getPeriod().getStart().toString("dd-MM-YYY"), invite.getPeriod().getEnd().toString("dd-MM-YYY") },
                        I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);
    }

    @Atomic(mode = TxMode.WRITE)
    public Invite updateCompletedInvite(InviteBean inviteBean) {
        Invite invite = inviteBean.getInvite();

        //TODO: check if best code pattern for editing partially filled bean
        invite.setGivenName(inviteBean.getGivenName());
        invite.setFamilyNames(inviteBean.getFamilyNames());
        invite.setGender(inviteBean.getGender());
        invite.setIdDocumentType(inviteBean.getIdDocumentType());
        invite.setIdDocumentNumber(inviteBean.getIdDocumentNumber());
        invite.setInvitedInstitutionAddress(inviteBean.getInvitedInstitutionAddress());
        invite.setInvitedInstitutionName(inviteBean.getInvitedInstitutionName());
        invite.setContact(inviteBean.getContact());
        invite.setContactSOS(inviteBean.getContactSOS());
        invite.setState(InviteState.COMPLETED);
        return invite;
    }

    @Atomic(mode = TxMode.WRITE)
    public Person confirmInvite(Invite invite) throws ChangeInviteFinalStateException {

        if (inFinalState(invite)) {
            throw new ChangeInviteFinalStateException();
        }

        invite.setState(InviteState.CONFIRMED);

        UserProfile userProfile = new UserProfile(invite.getGivenName(), invite.getFamilyNames(), null, invite.getEmail(), null);
        User user = new User(userProfile);
        new UserLoginPeriod(user, invite.getPeriod().getStart().toLocalDate(), invite.getPeriod().getEnd().toLocalDate());
        Person person = new Person(userProfile);
        person.setIdentification(invite.getIdDocumentNumber(), invite.getIdDocumentType());
        person.setGender(invite.getGender());
        invite.setInvited(userProfile);

        sendConfirmationMessage(invite, person);

        return person;
    }

    private boolean inFinalState(Invite invite) {
        return invite.getState() == InviteState.CONFIRMED || invite.getState() == InviteState.REJECTED;
    }

    private void sendConfirmationMessage(Invite invite, Person person) {
        String bcc = invite.getEmail();

        String subject =
                messageSource.getMessage("external.user.confirmation.message.subject", new Object[] {}, I18N.getLocale());

        String passRecoveryLink = ExternalInviteConfiguration.getConfiguration().getPassRecoveryLink();

        String body =
                messageSource.getMessage("external.user.confirmation.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), getInstitutionName(), invite.getReasonName(),
                        passRecoveryLink, invite.getPeriod().getStart().toString("dd-MM-YYY"),
                        invite.getPeriod().getEnd().toString("dd-MM-YYY"), person.getUsername() }, I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);

    }

    @Atomic(mode = TxMode.WRITE)
    public void rejectInvite(Invite invite) throws ChangeInviteFinalStateException {

        if (inFinalState(invite)) {
            throw new ChangeInviteFinalStateException();
        }

        invite.setState(InviteState.REJECTED);
        sendRejectionMessage(invite);
    }

    private void sendRejectionMessage(Invite invite) {
        String bcc = invite.getEmail();

        String subject = messageSource.getMessage("external.user.rejection.message.subject", new Object[] {}, I18N.getLocale());

        String body =
                messageSource.getMessage("external.user.rejection.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), getInstitutionName(), invite.getReasonName(),
                        invite.getPeriod().getStart().toString("dd-MM-YYY"), invite.getPeriod().getEnd().toString("dd-MM-YYY") },
                        I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);
    }

    public Invite getInviteFromHash(String hash) throws ExternalInviteException {
        Set<Invite> matchingInvites =
                Bennu.getInstance().getInviteSet().stream().filter(i -> i.getHash().equals(hash)).collect(Collectors.toSet());

        if (matchingInvites.size() > 1) {
            throw new NonUniqueInviteHashException();
        }

        if (matchingInvites.size() == 0) {
            throw new UnexistentInviteHashException();
        }

        Invite hit = matchingInvites.iterator().next();

        if (hasExpired(hit)) {
            throw new ExpiredInviteException();
        }

        return hit;
    }

    private boolean hasExpired(Invite invite) {
        return DateTime.now().isAfter(
                invite.getCreationTime().plusDays(ExternalInviteConfiguration.getConfiguration().getExpirationDays()));
    }

    public List<Unit> getUnits() {
        List<Unit> units = getDepartmentUnits();
        List<Unit> researchUnits = getResearchUnits();

        units.addAll(researchUnits);

        return units;
    }

    private List<Unit> getResearchUnits() {

        Set<Unit> researchUnitsRoot =
                Bennu.getInstance().getInstitutionUnit().getSubUnits().stream()
                .filter(u -> u.getName().equals("Unidades Investigação")).collect(Collectors.toSet());

        if (researchUnitsRoot.size() == 1) {
            return researchUnitsRoot.iterator().next().getAllSubUnits().stream()
                    .filter(u -> u.getSubUnits().isEmpty() && !u.getChildParties(Person.class).isEmpty()).distinct()
                    .sorted(Unit.COMPARATOR_BY_NAME).collect(Collectors.toList());
        } else {
            return new ArrayList<Unit>();
        }
    }

    private List<Unit> getDepartmentUnits() {
        return Bennu.getInstance().getDepartmentsSet().stream().map(d -> d.getDepartmentUnit()).distinct()
                .collect(Collectors.toList());
    }

    @Atomic(mode = TxMode.WRITE)
    public void addReason(ReasonBean reasonBean) {
        Bennu.getInstance().getReasonSet().add(new ReasonBean.Builder(reasonBean).build());
    }

    @Atomic(mode = TxMode.WRITE)
    public void deleteReason(Reason reason) {
        reason.delete();
    }

    @Atomic(mode = TxMode.WRITE)
    public void desactivateReason(Reason reason) {
        reason.setActive(false);
    }

    @Atomic(mode = TxMode.WRITE)
    public void activateReason(Reason reason) {
        reason.setActive(true);
    }

    public Set<Reason> getReasons() {
        return Bennu.getInstance().getReasonSet().stream().filter(r -> r.getActive()).collect(Collectors.toSet());
    }

    public void checkInviteAccess(Invite invite) throws UnauthorisedUserException {
        if (!Authenticate.getUser().equals(invite.getCreator())) {
            throw new UnauthorisedUserException();
        }
    }

}
