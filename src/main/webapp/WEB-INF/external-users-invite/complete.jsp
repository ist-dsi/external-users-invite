<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${! empty error}">
  <div class="alert alert-danger" role="alert">
    <p>${error}</p>
  </div>
</c:if>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach var="message" items="${messages}">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<spring:message code='label.name' var='name'/>
<spring:message code='label.email' var='email'/>
<spring:message code='label.invited.institution.name' var='invitedInstitutionName'/>
<spring:message code='label.invited.institution.address' var='invitedInstitutionAddress'/>
<spring:message code='label.contact' var='contact'/>
<spring:message code='label.contact.sos' var='contactSOS'/>
<spring:message code='label.id.document.type' var='idDocumentType'/>
<spring:message code='label.id.document.number' var='idDocumentNumber'/>



<c:if test="${! empty inviteBean}">
  <div class="well">
    <p><b><spring:message code='label.inviter'/>:</b> ${inviteBean.getCreatorFullName()}</p>
    <p><b><spring:message code='label.invitation.institution'/>:</b> ${inviteBean.invitationInstitution}</p>
    <p><b><spring:message code='label.reason'/>:</b> ${inviteBean.reason}</p>
    <p><b><spring:message code='label.date.start'/>:</b> ${inviteBean.getStartDateFormatted()}</p>
    <p><b><spring:message code='label.date.end'/>:</b> ${inviteBean.getEndDateFormatted()}</p>
  </div>

  <form method="POST" action="${pageContext.request.contextPath}/external-users-invite/submitCompletion">

    <input type="hidden" class="form-control" id="invite" name="invite" required="required" value="${inviteBean.invite.externalId}"/>

    <div class="form-group">
      <label for="name">${name}</label>
      <input type="text" class="form-control" id="name" name="name" placeholder="${name}" required="required" value="${inviteBean.name}"/>
    </div>

    <div class="form-group">
      <label for="email">${email}</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="${email}" required="required" value="${inviteBean.email}"/>
    </div>

    <div class="form-group">
      <label for="idDocumentType">${idDocumentType}</label>
      <select id="idDocumentType" name="idDocumentType">
        <option value="" label="--Please Select"/>
        <c:forEach var="type" items="${IDDocumentTypes}">
          <option value="${type}">${type}</option>
        </c:forEach>
      </select>
    </div>
    <div class="form-group">
      <label for="idDocumentNumber">${idDocumentNumber}</label>
      <input type="text" class="form-control" id="idDocumentNumber" name="idDocumentNumber" placeholder="${idDocumentNumber}" required="required" value="${inviteBean.idDocumentNumber}"/>
    </div>

    <div class="form-group">
      <label for="invitedInstitutionName">${invitedInstitutionName}</label>
      <input type="text" class="form-control" id="invitedInstitutionName" name="invitedInstitutionName" placeholder="${invitedInstitutionName}" required="required" value="${inviteBean.invitedInstitutionName}"/>
    </div>

    <div class="form-group">
      <label for="invitedInstitutionAddress">${invitedInstitutionAddress}</label>
      <input type="text" class="form-control" id="invitedInstitutionAddress" name="invitedInstitutionAddress" placeholder="${invitedInstitutionAddress}" required="required" value="${inviteBean.invitedInstitutionAddress}"/>
    </div>

    <div class="form-group">
      <label for="contact">${contact}</label>
      <input type="text" class="form-control" id="contact" name="contact" placeholder="${contact}" required="required" value="${inviteBean.contact}"/>
    </div>

    <div class="form-group">
      <label for="contactSOS">${contactSOS}</label>
      <input type="text" class="form-control" id="contactSOS" name="contactSOS" placeholder="${contactSOS}" required="required" value="${inviteBean.contactSOS}"/>
    </div>

    <button type="submit" class="btn btn-primary" id="submitButton">submitButton</button>
  </form>
</c:if>
