package org.fenixedu.ext.users.ui.service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.academic.domain.util.email.Message;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.domain.UserLoginPeriod;
import org.fenixedu.bennu.core.domain.UserProfile;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.commons.i18n.I18N;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.domain.InviteState;
import org.fenixedu.ext.users.domain.Reason;
import org.fenixedu.ext.users.ui.bean.InviteBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

@Service
public class ExternalInviteService {

    @Autowired
    MessageSource messageSource;

    private List<Invite> filterInvitesByState(List<Invite> invites, InviteState st) {
        return invites.stream().filter(i -> i.getState().equals(st)).sorted(Invite.COMPARATOR_BY_CREATION_TIME)
                .collect(Collectors.toList());
    }

    @Atomic(mode = TxMode.WRITE)
    public void sendInvite(Invite invite) {

        String bcc = invite.getEmail();

        String subject =
                messageSource.getMessage("external.user.invite.message.subject", new Object[] {
                        invite.getInvitationInstitution(), Authenticate.getUser().getProfile().getFullName() }, I18N.getLocale());

        //TODO: fix link
        String link = "http://localhost:8080/fenix/public-external-invite/completeInvite/" + invite.getHash();

        String body =
                messageSource.getMessage("external.user.invite.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), invite.getInvitationInstitution(),
                        invite.getReasonName(), link, invite.getPeriod().getStart().toString("dd-MM-YYY HH:mm"),
                        invite.getPeriod().getEnd().toString("dd-MM-YYY HH:mm") }, I18N.getLocale());

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
    public Person confirmInvite(Invite invite, boolean admin) {

        invite.setState(admin ? InviteState.CONFIRMED_BY_CREATOR : InviteState.CONFIRMED_BY_MANAGER);

        UserProfile userProfile = new UserProfile(invite.getGivenName(), invite.getFamilyNames(), null, invite.getEmail(), null);
        User user = new User(userProfile);
        new UserLoginPeriod(user, invite.getPeriod().getStart().toLocalDate(), invite.getPeriod().getEnd().toLocalDate());
        Person person = new Person(userProfile);
        person.setIdentification(invite.getIdDocumentNumber(), invite.getIdDocumentType());
        person.setGender(invite.getGender());
        invite.setInvited(userProfile);

        sendConfirmationMessage(invite);

        return person;
    }

    private void sendConfirmationMessage(Invite invite) {
        String bcc = invite.getEmail();

        String subject =
                messageSource.getMessage("external.user.confirmation.message.subject", new Object[] {}, I18N.getLocale());

        //TODO: fix link
        String link = "https://id.ist.utl.pt";

        String body =
                messageSource.getMessage("external.user.confirmation.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), invite.getInvitationInstitution(),
                        invite.getReasonName(), link, invite.getPeriod().getStart().toString("dd-MM-YYY HH:mm"),
                        invite.getPeriod().getEnd().toString("dd-MM-YYY HH:mm") }, I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);

    }

    @Atomic(mode = TxMode.WRITE)
    public void rejectInvite(Invite invite, boolean admin) {
        invite.setState(admin ? InviteState.REJECTED_BY_MANAGER : InviteState.REJECTED_BY_CREATOR);
        sendRejectionMessage(invite);
    }

    private void sendRejectionMessage(Invite invite) {
        String bcc = invite.getEmail();

        String subject = messageSource.getMessage("external.user.rejection.message.subject", new Object[] {}, I18N.getLocale());

        String body =
                messageSource.getMessage("external.user.rejection.message.body", new Object[] {
                        invite.getCreator().getProfile().getFullName(), invite.getInvitationInstitution(),
                        invite.getReasonName(), invite.getPeriod().getStart().toString("dd-MM-YYY HH:mm"),
                        invite.getPeriod().getEnd().toString("dd-MM-YYY HH:mm") }, I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);
    }

    //TODO: remove this little hack very soon
    @Atomic(mode = TxMode.WRITE)
    public void populateReasonsHACK() {
        Set<Reason> reasons = Bennu.getInstance().getReasonSet();
        if (reasons.isEmpty()) {
            System.out.println("adding reasons because yes");
            reasons.add(new Reason("thesis", "descThesis"));
            reasons.add(new Reason("class", "descClass"));
            reasons.add(new Reason("lunch", "descLunch"));
            reasons.add(new Reason("other", "descOther"));
        }
    }

    public List<Invite> getUserInvites() {
        return Bennu.getInstance().getInviteSet().stream()
                .filter(i -> i.getCreator() != null && i.getCreator().equals(Authenticate.getUser()))
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterConfirmedInvites(List<Invite> invites) {
        return Stream
                .concat(filterInvitesByState(invites, InviteState.CONFIRMED_BY_CREATOR).stream(),
                        filterInvitesByState(invites, InviteState.CONFIRMED_BY_MANAGER).stream()).distinct()
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterRejectedInvites(List<Invite> invites) {
        return Stream
                .concat(filterInvitesByState(invites, InviteState.REJECTED_BY_CREATOR).stream(),
                        filterInvitesByState(invites, InviteState.REJECTED_BY_MANAGER).stream()).distinct()
                .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
    }

    public List<Invite> filterCompletedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.COMPLETED);
    }

    public List<Invite> filterNotCompletedInvites(List<Invite> invites) {
        return filterInvitesByState(invites, InviteState.NOT_COMPLETED);
    }

    public Invite getInviteFromHash(String hash) {
        Set<Invite> matchingInvites =
                Bennu.getInstance().getInviteSet().stream().filter(i -> i.getHash().equals(hash)).collect(Collectors.toSet());

        if (matchingInvites.size() > 1) {
            //TODO: throw exception?
            System.out.println("more than one");
        }

        if (matchingInvites.size() == 1) {
            return matchingInvites.iterator().next();
        }

        return null;
    }
}
