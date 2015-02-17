package org.fenixedu.ext.users.ui.controller;

import java.util.Arrays;

import org.fenixedu.bennu.core.i18n.BundleUtil;
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

@RequestMapping("/external-users-invite")
@SpringApplication(group = "logged", path = "external-users-invite", title = "title.ExternalUsersInvite")
@SpringFunctionality(app = ExternalUsersInviteController.class, title = "title.StartInvite")
public class ExternalUsersInviteController {

    @Autowired
    ExternalInviteService service;

    static String BUNDLE = "resources.ExternalUsersInviteResources";

    @RequestMapping
    public String startInvite(Model model) {

        InviteBean bean = new InviteBean();
        model.addAttribute("inviteBean", bean);

        return "external-users-invite/home";
    }

    @RequestMapping(value = "/sendInvite", method = RequestMethod.POST)
    public String sendInvite(@ModelAttribute InviteBean inviteBean, Model model) {

        System.out.println(inviteBean != null);
        //TODO: validate fields
        /*
         * name != null/empty
         * email contains @ 
         * inst != null/empty
         * dates != null/empty && valid dates
         * reason != null/empty
         */

        Invite invite = new InviteBean.Builder(inviteBean).build();

        service.sendInvite(invite);

        model.addAttribute(
                "messages",
                Arrays.asList(BundleUtil.getString(BUNDLE, "message.invite.send.successfully", new String[] { invite.getName(),
                        invite.getEmail() })));
        return "external-users-invite/home";
    }

    @RequestMapping(value = "/completeInvite/{oid}", method = RequestMethod.GET)
    public String completeInvite(@PathVariable("oid") Invite invite, Model model) {

        if (invite != null) {
            InviteBean inviteBean = new InviteBean(invite);
            model.addAttribute("inviteBean", inviteBean);
        } else {
            model.addAttribute("error", BundleUtil.getString(BUNDLE, "error.complete.invite.not.found"));
        }

        return "external-users-invite/complete";
    }
}
