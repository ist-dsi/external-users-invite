package org.fenixedu.ext.users.ui.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.bennu.core.domain.User;
import org.fenixedu.bennu.core.groups.DynamicGroup;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.core.security.Authenticate;
import org.fenixedu.bennu.spring.portal.SpringApplication;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.ExternalInviteConfiguration;
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

        User user = Authenticate.getUser();

        List<Invite> invites = service.getUserInvites(user);

        List<Invite> unfinishedInvites = service.filterUnfinishedInvites(invites);
        List<Invite> finishedInvites = service.filterFinishedInvites(invites);
        model.addAttribute("unfinishedInvites", unfinishedInvites);
        model.addAttribute("finishedInvites", finishedInvites);

        model.addAllAttributes(redirectAttr.getFlashAttributes());

        boolean isManager = DynamicGroup.get("managers").isMember(user);
        model.addAttribute("isManager", isManager);
        if (isManager) {
            model.addAttribute("action", "/admin-external-invite");
        } else {
            model.addAttribute("action", "/external-users-invite");
        }

        model.addAttribute("reasons", service.getReasons());
        model.addAttribute("units", service.getUnits());

        model.addAttribute("expirationDays", ExternalInviteConfiguration.getConfiguration().getExpirationDays());

        return "external-users-invite/list";
    }

    @RequestMapping(value = "/inviteDetails/{oid}", method = RequestMethod.GET)
    public String inviteDetails(@PathVariable("oid") Invite invite, Model model) {

        model.addAttribute("invite", invite);

        return "external-users-invite/details";
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
            return "redirect:/external-users-invite";
        }

        Invite invite = new InviteBean.Builder(inviteBean).build();

        service.sendInvite(invite);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.send.successfully",
                        new String[] { invite.getFullName(), invite.getEmail() })));

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
                            new String[] { invite.getFullName(), invite.getEmail(), person.getUsername() })));

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
                            new String[] { invite.getFullName(), invite.getEmail() })));

            return "redirect:/external-users-invite";
        } catch (UnauthorisedUserException e) {
            redirectAttrs.addFlashAttribute("errors", Arrays.asList(e.getClass().getSimpleName()));
            return "redirect:/external-users-invite";
        }
    }
}
