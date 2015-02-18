<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<c:if test="${! empty inviteBean}">
  <div class="alert alert-info" role="alert">
    <p><b><spring:message code='label.inviter'/>:</b> ${inviteBean.getCreatorFullName()}</p>
    <p><b><spring:message code='label.invitation.institution'/>:</b> ${inviteBean.invitationInstitution}</p>
    <p><b><spring:message code='label.reason'/>:</b> ${inviteBean.reason}</p>
    <p><b><spring:message code='label.period'/>:</b> ${inviteBean.getStartDateFormatted()} - ${inviteBean.getEndDateFormatted()}</p>

    <br><br>

    <p><b><spring:message code='label.name'/>:</b> ${inviteBean.name}</p>
    <p><b><spring:message code='label.email'/>:</b> ${inviteBean.email}</p>
    <p><b><spring:message code='label.id.document.number'/>:</b> ${inviteBean.idDocumentNumber} (${inviteBean.idDocumentType})</p>
    <p><b><spring:message code='label.invited.institution.name'/>:</b> ${inviteBean.invitedInstitutionName}</p>
    <p><b><spring:message code='label.invited.institution.address'/>:</b> ${inviteBean.invitedInstitutionAddress}</p>
    <p><b><spring:message code='label.contact'/>:</b> ${inviteBean.contact}</p>
    <p><b><spring:message code='label.contact.sos'/>:</b> ${inviteBean.contactSOS}</p>

  </div>

  <a href="" type="button" class="btn btn-success" id="accept">Accept</a>
  <a href="" type="button" class="btn btn-danger" id="reject">Reject</a>

</c:if>
