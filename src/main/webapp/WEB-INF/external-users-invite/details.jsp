<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-header">
  <h1><spring:message code='title.invite.details'/></h1>
  <small><spring:message code='title.invites'/></small>
</div>

<dl class="dl-horizontal">
  <dt><spring:message code='label.inviter'/></dt><dd>${invite.creator.profile.fullName}</dd>
  <dt><spring:message code='label.creation.time'/></dt><dd>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</dd>
  <dt><spring:message code='label.unit'/></dt><dd>${invite.unit.name} (${invite.unit.acronym})</dd>
  <dt><spring:message code='label.date.start'/></dt><dd>${invite.period.start.toString('dd/MM/YYY HH:mm')}</dd>
  <dt><spring:message code='label.date.end'/></dt><dd>${invite.period.end.toString('dd/MM/YYY HH:mm')}</dd>
  <dt><spring:message code='label.reason'/></dt><dd>${invite.reasonName} - ${invite.reasonDescription}</dd>
  <dt><spring:message code='label.name'/></dt><dd>${invite.givenName}</dd>
  <dt><spring:message code='label.family.names'/></dt><dd>${invite.familyNames}</dd>
  <dt><spring:message code='label.gender'/></dt><dd>${invite.gender}</dd>
  <dt><spring:message code='label.email'/></dt><dd>${invite.email}</dd>
  <dt><spring:message code='label.id.document.type'/></dt><dd>${invite.idDocumentType}</dd>
  <dt><spring:message code='label.id.document.number'/></dt><dd>${invite.idDocumentNumber}</dd>
  <dt><spring:message code='label.invited.institution.name'/></dt><dd>${invite.invitedInstitutionName}</dd>
  <dt><spring:message code='label.invited.institution.address'/></dt><dd>${invite.invitedInstitutionAddress}</dd>
  <dt><spring:message code='label.contact'/></dt><dd>${invite.contact}</dd>
  <dt><spring:message code='label.contact.sos'/></dt><dd>${invite.contactSOS}</dd>
  <dt><spring:message code='label.state'/></dt><dd>${invite.state.localizedName}</dd>
</dl>