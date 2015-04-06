<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${portal.toolkit()}

<div class="page-header">
  <h1><spring:message code='title.invites.new'/></h1>
</div>
<div class="well">
  <p><spring:message code='external.invites.new.well'/></p>
</div>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach var="message" items="${messages}">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<spring:message code='label.given.name' var='givenName'/>
<spring:message code='label.email' var='email'/>
<spring:message code='label.date.start' var='startDate'/>
<spring:message code='label.date.end' var='endDate'/>
<spring:message code='label.reason' var='reason'/>
<spring:message code='label.reason.other' var='otherReason'/>
<spring:message code='label.gender' var='gender'/>
<spring:message code='label.family.names' var='familyNames'/>
<spring:message code='label.unit' var='unit'/>
<spring:message code='button.submit' var='submitButton'/>

<c:if test="${! empty inviteBean}">
  <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/external-users-invite/sendInvite">

    <input type="hidden" class="form-control" id="creator" name="creator" value="${inviteBean.creator}"/>

    <div class="form-group">
      <label for="givenName" class="col-sm-2 control-label">${givenName}</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="givenName" name="givenName" placeholder="${givenName}" required="required" value="${inviteBean.givenName}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="familyNames" class="col-sm-2 control-label">${familyNames}</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="familyNames" name="familyNames" placeholder="${familyNames}" required="required" value="${inviteBean.familyNames}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="email" class="col-sm-2 control-label">${email}</label>
      <div class="col-sm-10">
        <input type="email" class="form-control" id="email" name="email" placeholder="${email}" required="required" value="${inviteBean.email}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="startDate" class="col-sm-2 control-label">${startDate}</label>
      <div class="col-sm-10">
        <input type="text" bennu-datetime class="form-control" id="startDate" name="startDate" placeholder="${startDate}" required="required" value="${inviteBean.startDate}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="endDate" class="col-sm-2 control-label">${endDate}</label>
      <div class="col-sm-10">
        <input type="text" bennu-datetime class="form-control" id="endDate" name="endDate" placeholder="${endDate}" required="required" value="${inviteBean.endDate}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="reason" class="col-sm-2 control-label">${reason}</label>
      <div class="col-sm-10">
        <select id="reason" name="reason">
          <option value=""><spring:message code='label.option.select'/></option>
          <c:forEach var="reason" items="${reasons}">
            <option value="${reason.externalId}">${reason.name} - ${reason.description}</option>
          </c:forEach>
        </select>
      </div>
    </div>

    <div class="form-group">
      <label for="otherReason" class="col-sm-2 control-label">${otherReason}</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="otherReason" name="otherReason" placeholder="${otherReason}" value="${inviteBean.otherReason}"/>
      </div>
    </div>

    <div class="form-group">
      <label for="unit" class="col-sm-2 control-label">${unit}</label>
      <div class="col-sm-10">
        <select id="unit" name="unit">
          <option value=""><spring:message code='label.option.select'/></option>
          <c:forEach var="unit" items="${units}">
            <option value="${unit.externalId}">${unit.name} <c:if test="${! empty unit.acronym}">(${unit.acronym})</c:if></option>
          </c:forEach>
        </select>
      </div>
    </div>

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-primary" id="submitButton">${submitButton}</button>
      </div>
    </div>

  </form>
</c:if>
