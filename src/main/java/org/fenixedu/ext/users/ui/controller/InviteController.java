package org.fenixedu.ext.users.ui.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.bennu.spring.portal.SpringApplication;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.ui.bean.InviteBean;
import org.fenixedu.ext.users.ui.exception.UnauthorisedUserException;
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
@SpringFunctionality(app = InviteController.class, title = "title.invites", accessGroup = "logged")
public class InviteController {

    @Autowired
    ExternalInviteService service;

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @RequestMapping
    public String listInvites(Model model, RedirectAttributes redirectAttr) {

        List<Invite> invites = service.getUserInvites();

        List<Invite> completedInvites = service.filterCompletedInvites(invites);
        List<Invite> notCompletedInvites = service.filterNotCompletedInvites(invites);
        List<Invite> confirmedInvites = service.filterConfirmedInvites(invites);
        List<Invite> rejectedInvites = service.filterRejectedInvites(invites);

        model.addAttribute("emptyInvites", invites.isEmpty());
        model.addAttribute("completedInvites", completedInvites);
        model.addAttribute("notCompletedInvites", notCompletedInvites);
        model.addAttribute("confirmedInvites", confirmedInvites);
        model.addAttribute("rejectedInvites", rejectedInvites);

        model.addAllAttributes(redirectAttr.getFlashAttributes());
        model.addAttribute("action", "/external-users-invite");

        return "external-users-invite/list";
    }

    @RequestMapping(value = "/newInvite", method = RequestMethod.GET)
    public String startInvite(Model model) {

        model.addAttribute("reasons", service.getReasons());
        model.addAttribute("units", service.getUnits());
        model.addAttribute("inviteBean", new InviteBean());

        return "external-users-invite/create";
    }

    @RequestMapping(value = "/sendInvite", method = RequestMethod.POST)
    public String sendInvite(@ModelAttribute InviteBean inviteBean, RedirectAttributes redirectAttrs) {

        inviteBean.setCreator(Authenticate.getUser());

        ArrayList<String> errors = new ArrayList<String>();

        if (inviteBean.getGivenName() == null || inviteBean.getGivenName().isEmpty()) {
            errors.add("given.name.required");
        }
        if (inviteBean.getFamilyNames() == null || inviteBean.getFamilyNames().isEmpty()) {
            errors.add("family.name.required");
        }
        if (inviteBean.getEmail() == null || inviteBean.getEmail().isEmpty()) {
            errors.add("email.required");
        }
        if (inviteBean.getStartDate() == null || inviteBean.getStartDate().isEmpty()) {
            errors.add("date.start.required");
        }
        if (inviteBean.getEndDate() == null || inviteBean.getEndDate().isEmpty()) {
            errors.add("date.end.required");
        }
        if (inviteBean.getUnit() == null) {
            errors.add("unit.required");
        }
        if (inviteBean.getReason() == null && (inviteBean.getOtherReason() == null || inviteBean.getOtherReason().isEmpty())) {
            errors.add("reason.required");
        }

        if (!errors.isEmpty()) {
            redirectAttrs.addFlashAttribute("errors", errors);
            return "redirect:/external-users-invite/newInvite";
        }

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

        try {
            service.checkInviteAccess(invite);

            //TODO: check state

            Person person = service.confirmInvite(invite, false);

            redirectAttrs.addFlashAttribute(
                    "messages",
                    Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.confirm",
                            new String[] { invite.getGivenName(), invite.getEmail(), person.getUsername() })));

            return "redirect:/external-users-invite";
        } catch (UnauthorisedUserException e) {
            redirectAttrs.addFlashAttribute("errors", Arrays.asList(e.getClass().getSimpleName()));
            return "redirect:/external-users-invite";
        }
    }

    @RequestMapping(value = "/rejectInvite/{oid}", method = RequestMethod.GET)
    public String rejectInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

        try {
            service.checkInviteAccess(invite);

            //TODO: check state

            service.rejectInvite(invite, false);

            redirectAttrs.addFlashAttribute(
                    "messages",
                    Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.reject",
                            new String[] { invite.getGivenName(), invite.getEmail() })));

            return "redirect:/external-users-invite";
        } catch (UnauthorisedUserException e) {
            redirectAttrs.addFlashAttribute("errors", Arrays.asList(e.getClass().getSimpleName()));
            return "redirect:/external-users-invite";
        }
    }
}
