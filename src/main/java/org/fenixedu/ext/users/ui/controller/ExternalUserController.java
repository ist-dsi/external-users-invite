package org.fenixedu.ext.users.ui.controller;

import java.util.Arrays;

import org.fenixedu.academic.domain.person.Gender;
import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.ui.bean.InviteBean;
import org.fenixedu.ext.users.ui.exception.ExternalInviteException;
import org.fenixedu.ext.users.ui.service.ExternalInviteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@SpringFunctionality(app = InviteController.class, title = "title.invites.public", accessGroup = "anyone")
@RequestMapping("/public-external-invite")
public class ExternalUserController {

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @Autowired
    ExternalInviteService service;

    @RequestMapping(value = "/completeInvite/{hash}", method = RequestMethod.GET)
    public String completeInvite(@PathVariable("hash") String hash, Model model) {

        try {
            Invite invite = service.getInviteFromHash(hash);
            InviteBean inviteBean = new InviteBean(invite);
            model.addAttribute("inviteBean", inviteBean);
            model.addAttribute("genderEnum", Gender.values());
            model.addAttribute("IDDocumentTypes", IDDocumentType.values());
        } catch (ExternalInviteException e) {
            model.addAttribute("error", e.getClass().getSimpleName());
        }

        return "public-external-invite/complete";
    }

    @RequestMapping(value = "/submitCompletion", method = RequestMethod.POST)
    public String submitCompletion(InviteBean inviteBean, Model model) {

        //TODO: validate fields
        Invite invite = service.updateCompletedInvite(inviteBean);

        model.addAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.completion.successfully", new String[] { invite
                        .getCreator().getProfile().getFullName() })));

        inviteBean = new InviteBean(invite);
        model.addAttribute("inviteBean", inviteBean);

        return "public-external-invite/complete";
    }

}
