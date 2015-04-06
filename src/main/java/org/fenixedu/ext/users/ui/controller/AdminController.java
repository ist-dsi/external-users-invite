package org.fenixedu.ext.users.ui.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.fenixedu.academic.domain.Person;
import org.fenixedu.academic.domain.exceptions.DomainException;
import org.fenixedu.bennu.core.domain.Bennu;
import org.fenixedu.bennu.core.i18n.BundleUtil;
import org.fenixedu.bennu.spring.portal.SpringFunctionality;
import org.fenixedu.ext.users.ExternalInviteConfiguration;
import org.fenixedu.ext.users.domain.Invite;
import org.fenixedu.ext.users.domain.Reason;
import org.fenixedu.ext.users.ui.bean.ReasonBean;
import org.fenixedu.ext.users.ui.service.ExternalInviteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@SpringFunctionality(app = InviteController.class, title = "title.invites.admin", accessGroup = "#managers")
@RequestMapping("/admin-external-invite")
public class AdminController {

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @Autowired
    ExternalInviteService service;

    @RequestMapping
    public String listInvites(Model model) {

        Bennu bennu = Bennu.getInstance();

        List<Invite> invites =
                bennu.getInviteSet().stream().sorted(Invite.COMPARATOR_BY_CREATION_TIME).collect(Collectors.toList());
        model.addAttribute("invites", invites);

        Set<Reason> reasons = bennu.getReasonSet();
        model.addAttribute("reasons", reasons);
        model.addAttribute("expirationDays", ExternalInviteConfiguration.getConfiguration().getExpirationDays());

        return "admin/list";
    }

    @RequestMapping(value = "/confirmInvite/{oid}", method = RequestMethod.GET)
    public String confirmInvite(@PathVariable("oid") Invite invite, RedirectAttributes redirectAttrs) {

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

        //TODO: check state

        service.rejectInvite(invite, true);

        redirectAttrs.addFlashAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.creator.reject", new String[] { invite.getGivenName(),
                        invite.getEmail() })));

        return "redirect:/admin-external-invite";
    }

    @RequestMapping(value = "/prepareAddReason", method = RequestMethod.GET)
    public String prepareAddReason(Model model) {

        model.addAttribute("reasonBean", new ReasonBean());

        return "admin/createReason";
    }

    @RequestMapping(value = "/addReason", method = RequestMethod.POST)
    public String addReason(@ModelAttribute ReasonBean reasonBean, RedirectAttributes redirectAttrs) {

        ArrayList<String> errors = new ArrayList<String>();

        if (reasonBean.getName().isEmpty()) {
            errors.add("reason.name.required");
        }
        if (reasonBean.getDescription().isEmpty()) {
            errors.add("reason.description.required");
        }

        if (!errors.isEmpty()) {
            redirectAttrs.addFlashAttribute("errors", errors);
            return "redirect:/admin-external-invite/prepareAddReason";
        }

        service.addReason(reasonBean);

        return "redirect:/admin-external-invite";
    }

    @RequestMapping(value = "/deleteReason/{oid}")
    public String deleteReason(@PathVariable("oid") Reason reason, RedirectAttributes redirectAttrs) {
        try {
            service.deleteReason(reason);
        } catch (DomainException e) {
            redirectAttrs.addFlashAttribute("errors", Arrays.asList(e.getLocalizedMessage()));
        }

        return "redirect:/admin-external-invite";
    }

    @RequestMapping(value = "/disableReason/{oid}")
    public String disableReason(@PathVariable("oid") Reason reason) {

        service.disableReason(reason);

        return "redirect:/admin-external-invite";
    }

    @RequestMapping(value = "/enableReason/{oid}")
    public String enableReason(@PathVariable("oid") Reason reason) {

        service.enableReason(reason);

        return "redirect:/admin-external-invite";
    }
}
