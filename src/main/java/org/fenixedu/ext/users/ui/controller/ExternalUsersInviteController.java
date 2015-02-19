package org.fenixedu.ext.users.ui.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.academic.domain.person.Gender;
import org.fenixedu.academic.domain.person.IDDocumentType;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.bennu.spring.portal.SpringApplication;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.ui.bean.InviteBean;
import org.fenixedu.ext.users.ui.service.ExternalInviteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RequestMapping("/external-users-invite")
@SpringApplication(group = "logged", path = "external-users-invite", title = "title.ExternalUsersInvite")
@SpringFunctionality(app = ExternalUsersInviteController.class, title = "title.invites", accessGroup = "logged")
public class ExternalUsersInviteController {

    @Autowired
    ExternalInviteService service;

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @RequestMapping
    public String listInvites(Model model, RedirectAttributes redirectAttr) {

        List<Invite> invites =
                Bennu.getInstance().getInviteSet().stream()
                        .filter(i -> i.getCreator() != null && i.getCreator().equals(Authenticate.getUser()))
                        .sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());

        model.addAllAttributes(redirectAttr.getFlashAttributes());
        model.addAttribute("action", "/external-users-invite");
        model.addAttribute("admin", false);
        model.addAttribute("invites", invites);

        return "external-users-invite/list";
    }

    @RequestMapping(value = "/newInvite", method = RequestMethod.GET)
    public String startInvite(Model model) {

        InviteBean bean = new InviteBean();
        model.addAttribute("inviteBean", bean);

        return "external-users-invite/create";
    }

    @RequestMapping(value = "/sendInvite", method = RequestMethod.POST)
    public String sendInvite(@ModelAttribute InviteBean inviteBean, RedirectAttributes redirectAttrs) {

        inviteBean.setCreator(Authenticate.getUser());

        //TODO: validate fields

        Invite invite = new InviteBean.Builder(inviteBean).build();

        service.sendInvite(invite);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.send.successfully",
                        new String[] { invite.getGivenName(), invite.getEmail() })));

        return "redirect:/external-users-invite";
    }

    @RequestMapping(value = "/confirmInvite/{oid}", method = RequestMethod.GET)
    public String confirmInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

        //TODO: check creator = auth.getUser
        //TODO: check state

        Person person = service.confirmInvite(invite, false);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.confirm", new String[] {
                        invite.getGivenName(), invite.getEmail(), person.getUsername() })));

        return "redirect:/external-users-invite";
    }

    @RequestMapping(value = "/rejectInvite/{oid}", method = RequestMethod.GET)
    public String rejectInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

        //TODO: check creator = auth.getUser
        //TODO: check state

        service.rejectInvite(invite, false);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.reject", new String[] { invite.getGivenName(),
                        invite.getEmail() })));

        return "redirect:/external-users-invite";
    }

    ///////////////////////////////////////////////////////////////////////////////////////
    //                              TODO: remove from here                               //
    //                                  invited API                                      //
    //                                      hash                                         //
    ///////////////////////////////////////////////////////////////////////////////////////

    @RequestMapping(value = "/completeInvite/{oid}", method = RequestMethod.GET)
    public String completeInvite(@PathVariable("oid") Invite invite, Model model) {

        if (invite != null) {
            InviteBean inviteBean = new InviteBean(invite);
            model.addAttribute("inviteBean", inviteBean);
            model.addAttribute("genderEnum", Gender.values());
            model.addAttribute("IDDocumentTypes", IDDocumentType.values());
        } else {
            model.addAttribute("error", BundleUtil.getString(BUNDLE, "error.complete.invite.not.found"));
        }

        return "external-users-invite/complete";
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

        return "external-users-invite/complete";
    }
}
