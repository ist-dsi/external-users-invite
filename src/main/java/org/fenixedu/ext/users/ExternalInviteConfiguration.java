package org.fenixedu.ext.users;

import org.fenixedu.commons.configuration.ConfigurationInvocationHandler;
import org.fenixedu.commons.configuration.ConfigurationManager;
import org.fenixedu.commons.configuration.ConfigurationProperty;

public class ExternalInviteConfiguration {

    @ConfigurationManager(description = "FenixEdu External invites Configuration")
    public interface ConfigurationProperties {

        @ConfigurationProperty(key = "external.invite.expiration.days", description = "External invite expiration time in days",
                defaultValue = "30")
        public Integer getExpirationDays();

        @ConfigurationProperty(key = "external.invite.recovery.password.link",
                description = "URL for getting password after the user has confirmed the invite",
                defaultValue = "https://id.ist.utl.pt")
        public String getPassRecoveryLink();
    }

    public static ConfigurationProperties getConfiguration() {
        return ConfigurationInvocationHandler.getConfiguration(ConfigurationProperties.class);
    }
}
