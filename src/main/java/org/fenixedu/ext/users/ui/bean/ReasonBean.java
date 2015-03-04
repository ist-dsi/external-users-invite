package org.fenixedu.ext.users.ui.bean;

import org.fenixedu.ext.users.domain.Reason;

import pt.ist.fenixframework.Atomic;
import pt.ist.fenixframework.Atomic.TxMode;

public class ReasonBean {

    private String name;
    private String description;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ReasonBean() {

    }

    public static class Builder {

        private final String name;
        private final String description;

        public Builder(ReasonBean reasonBean) {
            this.name = reasonBean.getName();
            this.description = reasonBean.getDescription();
        }

        @Atomic(mode = TxMode.WRITE)
        public Reason build() {
            return new Reason(name, description);
        }
    }
}
