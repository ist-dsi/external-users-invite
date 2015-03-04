<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">
  <div class="col-md-10">

<c:if test="${! empty error}">
  <div class="alert alert-danger" role="alert">
    <p><spring:message code="error.external.invite.${error}"/></p>
  </div>
</c:if>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach var="message" items="${messages}">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<spring:message code='label.inviter' var='inviter'/>
<spring:message code='label.unit' var='unit'/>
<spring:message code='label.reason' var='reason'/>
<spring:message code='label.date.start' var='startDate'/>
<spring:message code='label.date.end' var='endDate'/>

<spring:message code='label.given.name' var='givenName'/>
<spring:message code='label.family.names' var='familyNames'/>
<spring:message code='label.email' var='email'/>
<spring:message code='label.invited.institution.name' var='invitedInstitutionName'/>
<spring:message code='label.invited.institution.address' var='invitedInstitutionAddress'/>
<spring:message code='label.contact' var='contact'/>
<spring:message code='label.contact.sos' var='contactSOS'/>
<spring:message code='label.id.document.type' var='idDocumentType'/>
<spring:message code='label.id.document.number' var='idDocumentNumber'/>
<spring:message code='label.gender' var='gender'/>
<spring:message code='label.unit' var='unit'/>

    <c:if test="${empty error}">
      <div class="alert alert-info" role="alert">
        <spring:message code='label.complete.info'/>
      </div>
    </c:if>

    <c:if test="${! empty inviteBean}">
      <div class="well">
        <p><b>${inviter}:</b> ${inviteBean.getCreatorFullName()}</p>
        <p><b>${unit}:</b> ${inviteBean.unit.name} (${inviteBean.unit.acronym})</p>
        <p><b>${reason}:</b> ${inviteBean.reasonName} - ${inviteBean.reasonDescription}</p>
        <p><b>${startDate}:</b> ${inviteBean.getStartDateFormatted()}</p>
        <p><b>${endDate}:</b> ${inviteBean.getEndDateFormatted()}</p>
      </div>

      <form method="POST" action="${pageContext.request.contextPath}/public-external-invite/submitCompletion">

        <input type="hidden" class="form-control" id="invite" name="invite" required="required" value="${inviteBean.invite.externalId}"/>

        <div class="form-group">
          <label for="givenName">${givenName}</label>
          <input type="text" class="form-control" id="givenName" name="givenName" placeholder="${givenName}" required="required" value="${inviteBean.givenName}"/>
        </div>

        <div class="form-group">
          <label for="familyNames">${familyNames}</label>
          <input type="text" class="form-control" id="familyNames" name="familyNames" placeholder="${familyNames}" required="required" value="${inviteBean.familyNames}"/>
        </div>

        <div class="form-group">
          <label for="gender">${gender}</label>
          <select id="gender" name="gender">
            <option value=""><spring:message code='label.option.select'/></option>
            <c:forEach var="gender" items="${genderEnum}">
              <option value="${gender}">${gender}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="idDocumentType">${idDocumentType}</label>
          <select id="idDocumentType" name="idDocumentType">
            <option value=""><spring:message code='label.option.select'/></option>
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

  </div>
</div>
