package org.fenixedu.ext.users;

import org.fenixedu.commons.configuration.ConfigurationInvocationHandler;
import org.fenixedu.commons.configuration.ConfigurationManager;
import org.fenixedu.commons.configuration.ConfigurationProperty;

public class ExternalInviteConfiguration {

    @ConfigurationManager(description = "FenixEdu External invites Configuration")
    public interface ConfigurationProperties {

        @ConfigurationProperty(key = "external.invite.expiration.days", description = "External invite expiration time in days",
                defaultValue = "1")
        public Integer getExpirationDays();
    }

    public static ConfigurationProperties getConfiguration() {
        return ConfigurationInvocationHandler.getConfiguration(ConfigurationProperties.class);
    }
}
