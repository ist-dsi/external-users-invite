package org.fenixedu.ext.users.ui.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String submitCompletion(InviteBean inviteBean, Model model, RedirectAttributes redirectAttrs) {

        ArrayList<String> errors = new ArrayList<String>();

        if (inviteBean.getGivenName() == null || inviteBean.getGivenName().isEmpty()) {
            errors.add("public.given.name.required");
        }

        if (inviteBean.getFamilyNames() == null || inviteBean.getFamilyNames().isEmpty()) {
            errors.add("public.family.names.required");
        }

        if (inviteBean.getGender() == null) {
            errors.add("public.gender.required");
        }

        if (inviteBean.getIdDocumentType() == null) {
            errors.add("public.document.type.required");
        }

        if (inviteBean.getIdDocumentNumber() == null || inviteBean.getIdDocumentNumber().isEmpty()) {
            errors.add("public.document.number.required");
        }

        if (inviteBean.getInvitedInstitutionName() == null || inviteBean.getInvitedInstitutionName().isEmpty()) {
            errors.add("public.institution.name.required");
        }

        if (inviteBean.getInvitedInstitutionAddress() == null || inviteBean.getInvitedInstitutionAddress().isEmpty()) {
            errors.add("public.institution.address.required");
        }

        if (inviteBean.getContact() == null || inviteBean.getContact().isEmpty()) {
            errors.add("public.contact.required");
        }

        if (inviteBean.getContactSOS() == null || inviteBean.getContactSOS().isEmpty()) {
            errors.add("public.contact.sos.required");
        }

        if (!errors.isEmpty()) {
            redirectAttrs.addFlashAttribute("errors", errors);
            return "redirect:/public-external-invite/completeInvite/" + inviteBean.getInvite().getHash();
        }

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
