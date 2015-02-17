<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${! empty error}">
  <div class="alert alert-danger" role="alert">
    <p>${error}</p>
  </div>
</c:if>

<spring:message code='label.name' var='name'/>
<spring:message code='label.email' var='email'/>
<spring:message code='label.origin.institution.name' var='originInstitutionName'/>
<spring:message code='label.origin.institution.address' var='originInstitutionAddress'/>
<spring:message code='label.contact' var='contact'/>
<spring:message code='label.contactSOS' var='contactSOS'/>


<c:if test="${! empty inviteBean}">
  <div class="well">
    <p>Invitor: ### updating dml ###</p>
    <p><spring:message code='label.invitation.institution'/>: ${inviteBean.invitationInstitution}</p>
    <p><spring:message code='label.reason'/>: ${inviteBean.reason}</p>
    <p><spring:message code='label.date.start'/>: ${inviteBean.startDateFormatted}</p>
    <p><spring:message code='label.date.end'/>: ${inviteBean.endDateFormatted}</p>
  </div>

  <form method="POST" action="${pageContext.request.contextPath}/external-users-invite/confirmInvite">

    <div class="form-group">
      <label for="name">${name}</label>
      <input type="text" class="form-control" id="name" name="name" placeholder="${name}" required="required" value="${inviteBean.name}"/>
    </div>

    <div class="form-group">
      <label for="email">${email}</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="${email}" required="required" value="${inviteBean.email}"/>
    </div>

    <div class="form-group">
      <label for="email">ID !!</label>
    </div>

    <div class="form-group">
      <label for="originInstitutionName">${originInstitutionName}</label>
      <input type="text" class="form-control" id="originInstitutionName" name="originInstitutionName" placeholder="${originInstitutionName}" required="required" value="${inviteBean.originInstitutionName}"/>
    </div>

    <div class="form-group">
      <label for="originInstitutionAddress">${originInstitutionAddress}</label>
      <input type="text" class="form-control" id="originInstitutionAddress" name="originInstitutionAddress" placeholder="${originInstitutionAddress}" required="required" value="${inviteBean.originInstitutionAddress}"/>
    </div>

    <div class="form-group">
      <label for="reason">${reason}</label>
      <input type="text" class="form-control" id="reason" name="reason" placeholder="${reason}" required="required" value="${inviteBean.reason}"/>
    </div>

    <button type="submit" class="btn btn-primary" id="submitButton">submitButton</button>
  </form>
</c:if>
