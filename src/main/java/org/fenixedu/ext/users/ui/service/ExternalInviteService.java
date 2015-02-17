package org.fenixedu.ext.users.ui.service;

import org.fenixedu.academic.domain.util.email.Message;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.commons.i18n.I18N;
import org.fenixedu.ext.users.domain.Invite;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

@Service
public class ExternalInviteService {

    @Autowired
    MessageSource messageSource;

    @Atomic(mode = TxMode.WRITE)
    public void sendInvite(Invite invite) {

        String bcc = invite.getEmail();

        String subject =
                messageSource.getMessage("external.user.invite.message.subject", new Object[] {
                        invite.getInvitationInstitution(), Authenticate.getUser().getProfile().getFullName() }, I18N.getLocale());

        String link = "http://localhost:8080/fenix/external-users-invite/completeInvite/" + invite.getExternalId();

        String body =
                messageSource.getMessage("external.user.invite.message.body",
                        new Object[] { Authenticate.getUser().getProfile().getFullName(), invite.getInvitationInstitution(),
                                invite.getReason(), link, invite.getPeriod().getStart().toString("dd-MM-YYY HH:mm"),
                                invite.getPeriod().getEnd().toString("dd-MM-YYY HH:mm") }, I18N.getLocale());

        System.out.println("Bcc: " + bcc);
        System.out.println("Subj: " + subject);
        System.out.println("Body: " + body);
        new Message(Bennu.getInstance().getSystemSender(), null, null, subject, body, bcc);
    }

}
