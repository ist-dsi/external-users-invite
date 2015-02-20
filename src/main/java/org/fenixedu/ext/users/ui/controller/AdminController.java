package org.fenixedu.ext.users.ui.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.ui.service.ExternalInviteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@SpringFunctionality(app = InviteController.class, title = "title.invites.admin", accessGroup = "logged")
@RequestMapping("/admin-external-invite")
public class AdminController {

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @Autowired
    ExternalInviteService service;

    @RequestMapping
    public String listInvites(Model model) {

        List<Invite> invites =
                Bennu.getInstance().getInviteSet().stream().sorted(Invite.COMPARATOR_BY_CREATION_TIME)
                        .collect(Collectors.toList());

        model.addAttribute("action", "/admin-external-invite");
        model.addAttribute("admin", true);
        model.addAttribute("invites", invites);

        return "external-users-invite/list";
    }

    @RequestMapping(value = "/confirmInvite/{oid}", method = RequestMethod.GET)
    public String confirmInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

        //TODO: check creator = auth.getUser
        //TODO: check state

        Person person = service.confirmInvite(invite, true);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.confirm", new String[] {
                        invite.getGivenName(), invite.getEmail(), person.getUsername() })));

        return "redirect:/admin-external-invite";
    }

    @RequestMapping(value = "/rejectInvite/{oid}", method = RequestMethod.GET)
    public String rejectInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

        //TODO: check creator = auth.getUser
        //TODO: check state

        service.rejectInvite(invite, true);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.reject", new String[] { invite.getGivenName(),
                        invite.getEmail() })));

        return "redirect:/admin-external-invite";
    }

}
