<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-header">
  <h1><spring:message code='title.invite.details'/></h1>
  <small><spring:message code='title.invites'/></small>
</div>

<h3>
  <spring:message code='title.invite'/>: ${invite.fullName}
  <c:if test="${invite.state == 'NOT_COMPLETED'}">
    <span class="label label-default">${invite.state.localizedName}</span>
  </c:if>
  <c:if test="${invite.state == 'COMPLETED'}">
    <span class="label label-warning"> ${invite.state.localizedName}</span>
  </c:if>
  <c:if test="${invite.state == 'CONFIRMED'}">
    <span class="label label-success"> ${invite.state.localizedName}</span>
  </c:if>
  <c:if test="${invite.state == 'REJECTED'}">
    <span class="label label-danger"> ${invite.state.localizedName}</span>
  </c:if>

</h3>

<br>
<p><spring:message code='external.invites.details.well'/></p>
<br>
 <div class="btn-group btn-group-xs">
              <a href="${pageContext.request.contextPath}/external-users-invite/confirmInvite/${invite.externalId}" class="btn btn-default" id='accept-btn'><spring:message code='button.accept'/></a>
              <a href="${pageContext.request.contextPath}/external-users-invite/rejectInvite/${invite.externalId}" class="btn btn-default" id='reject-btn'><spring:message code='button.reject'/></a>
</div>
<h4><spring:message code='label.details.invite'/></h4>
<dl class="dl-horizontal">
  <dt><spring:message code='label.inviter'/></dt><dd>${invite.creator.profile.fullName}</dd>
  <dt><spring:message code='label.creation.time'/></dt><dd>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</dd>
  <dt><spring:message code='label.unit'/></dt><dd>${invite.unit.name} (${invite.unit.acronym})</dd>
  <dt><spring:message code='label.invite.expiration'/></dt><dd>${invite.periodFormatted}</dd>
  <dt><spring:message code='label.reason'/></dt><dd>${invite.reasonName} - ${invite.reasonDescription}</dd>
</dl>

<br>
<h4><spring:message code='label.details.person'/></h4>
<dl class="dl-horizontal">
  <dt><spring:message code='label.name'/></dt><dd>${invite.fullName}</dd>
  <dt><spring:message code='label.email'/></dt><dd>${invite.email}</dd>
  <dt><spring:message code='label.gender'/></dt><dd>${invite.gender.toLocalizedString()}</dd>
  <dt><spring:message code='label.contact'/></dt><dd>${invite.contact}</dd>
  <dt><spring:message code='label.contact.sos'/></dt><dd>${invite.contactSOS}</dd>
  <dt><spring:message code='label.id.document.type'/></dt><dd>${invite.idDocumentType.localizedName}</dd>
  <dt><spring:message code='label.id.document.number'/></dt><dd>${invite.idDocumentNumber}</dd>
  <dt><spring:message code='label.invited.institution.name.public'/></dt><dd>${invite.invitedInstitutionName}</dd>
  <dt><spring:message code='label.invited.institution.address.public'/></dt><dd>${invite.invitedInstitutionAddress}</dd>
</dl>