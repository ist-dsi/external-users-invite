<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${portal.toolkit()}

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach var="message" items="${messages}">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<spring:message code='label.given.name' var='givenName'/>
<spring:message code='label.email' var='email'/>
<spring:message code='label.invitation.institution' var='invitationInstitution'/>
<spring:message code='label.date.start' var='startDate'/>
<spring:message code='label.date.end' var='endDate'/>
<spring:message code='label.reason' var='reason'/>
<spring:message code='label.reason.other' var='otherReason'/>
<spring:message code='label.gender' var='gender'/>
<spring:message code='label.family.names' var='familyNames'/>


<c:if test="${! empty inviteBean}">
  <form method="POST" action="${pageContext.request.contextPath}/external-users-invite/sendInvite">

    <input type="hidden" class="form-control" id="creator" name="creator" value="${inviteBean.creator}"/>

    <div class="form-group">
      <label for="givenName">${givenName}</label>
      <input type="text" class="form-control" id="givenName" name="givenName" placeholder="${givenName}" required="required" value="${inviteBean.givenName}"/>
    </div>

    <div class="form-group">
      <label for="familyNames">${familyNames}</label>
      <input type="text" class="form-control" id="familyNames" name="familyNames" placeholder="${familyNames}" required="required" value="${inviteBean.familyNames}"/>
    </div>

    <div class="form-group">
      <label for="email">${email}</label>
      <input type="email" class="form-control" id="email" name="email" placeholder="${email}" required="required" value="${inviteBean.email}"/>
    </div>

    <div class="form-group">
      <label for="invitationInstitution">${invitationInstitution}</label>
      <input type="text" class="form-control" id="invitationInstitution" name="invitationInstitution" placeholder="${invitationInstitution}" required="required" value="${inviteBean.invitationInstitution}"/>
    </div>

    <div class="form-group">
      <label for="startDate">${startDate}</label>
      <input type="text" bennu-datetime class="form-control" id="startDate" name="startDate" placeholder="${startDate}" required="required" value="${inviteBean.startDate}"/>
    </div>

    <div class="form-group">
      <label for="endDate">${endDate}</label>
      <input type="text" bennu-datetime class="form-control" id="endDate" name="endDate" placeholder="${endDate}" required="required" value="${inviteBean.endDate}"/>
    </div>

    <div class="form-group">
      <label for="reason">${reason}</label>
      <select id="reason" name="reason">
        <option value="" label="--Please Select"/>
        <c:forEach var="reason" items="${reasons}">
          <option value="${reason.externalId}">${reason.name} - ${reason.description}</option>
        </c:forEach>
      </select>

    </div>

    <div class="form-group">
      <label for="otherReason">${otherReason}</label>
      <input type="text" class="form-control" id="otherReason" name="otherReason" placeholder="${otherReason}" value="${inviteBean.otherReason}"/>
    </div>

    <button type="submit" class="btn btn-primary" id="submitButton">submitButton</button>
  </form>
</c:if>
