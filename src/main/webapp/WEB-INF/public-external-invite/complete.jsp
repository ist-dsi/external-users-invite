<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">
  <div class="col-md-10">

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

    <c:if test="${! empty errors}">
      <div class="alert alert-danger" role="alert">
        <c:forEach var="error" items="${errors}">
          <p><spring:message code="error.external.invite.${error}"/></p>
        </c:forEach>
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

      <form method="POST" action="${pageContext.request.contextPath}/public-external-invite/submitCompletion" class="form-horizontal">

        <input type="hidden" class="form-control" id="invite" name="invite" required="required" value="${inviteBean.invite.externalId}"/>

        <div class="form-group">
          <label for="givenName" class="col-sm-2 control-label">${givenName}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="givenName" name="givenName" placeholder="${givenName}"  value="${inviteBean.givenName}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="familyNames" class="col-sm-2 control-label">${familyNames}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="familyNames" name="familyNames" placeholder="${familyNames}"  value="${inviteBean.familyNames}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="gender" class="col-sm-2 control-label">${gender}</label>
          <div class="col-sm-10">
            <select id="gender" name="gender">
              <option value=""><spring:message code='label.option.select'/></option>
              <c:forEach var="gender" items="${genderEnum}">
                <option value="${gender}">${gender}</option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="idDocumentType" class="col-sm-2 control-label">${idDocumentType}</label>
          <div class="col-sm-10">
            <select id="idDocumentType" name="idDocumentType">
              <option value=""><spring:message code='label.option.select'/></option>
              <c:forEach var="type" items="${IDDocumentTypes}">
                <option value="${type}">${type}</option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="idDocumentNumber" class="col-sm-2 control-label">${idDocumentNumber}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="idDocumentNumber" name="idDocumentNumber" placeholder="${idDocumentNumber}"  value="${inviteBean.idDocumentNumber}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="invitedInstitutionName" class="col-sm-2 control-label">${invitedInstitutionName}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="invitedInstitutionName" name="invitedInstitutionName" placeholder="${invitedInstitutionName}"  value="${inviteBean.invitedInstitutionName}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="invitedInstitutionAddress" class="col-sm-2 control-label">${invitedInstitutionAddress}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="invitedInstitutionAddress" name="invitedInstitutionAddress" placeholder="${invitedInstitutionAddress}"  value="${inviteBean.invitedInstitutionAddress}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="contact" class="col-sm-2 control-label">${contact}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="contact" name="contact" placeholder="${contact}"  value="${inviteBean.contact}"/>
          </div>
        </div>

        <div class="form-group">
          <label for="contactSOS" class="col-sm-2 control-label">${contactSOS}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="contactSOS" name="contactSOS" placeholder="${contactSOS}"  value="${inviteBean.contactSOS}"/>
          </div>
        </div>

        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-primary" id="submitButton"><spring:message code='label.submit'/></button>
          </div>
        </div>

      </form>
    </c:if>

  </div>
</div>
