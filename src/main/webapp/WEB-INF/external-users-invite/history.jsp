<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${portal.toolkit()}

<div class="page-header">
  <h1><spring:message code='title.invites'/></h1>
</div>
<p><spring:message code='external.invites.list.well'/></p>

<h4><spring:message code='label.invites.historic'/> <span class="badge">${invites.size()}</span></a></h4>
<c:if test="${empty invites}">
  <div class="panel panel-default">
    <div class="panel-body">
      <spring:message code='label.completed.invites.empty'/> 
    </div>
  </div>
</c:if>
<c:if test="${! empty invites}">
  <table class="table">
    <colgroup>
     <col></col>
     <col></col>
     <col></col>
     <col></col>
     <col></col>
     <col></col>
     <col></col>
    </colgroup>
      <thead>
        <tr>
          <th><spring:message code='label.inviter'/></th>
          <th><spring:message code='label.creation.time'/></th>
          <th><spring:message code='label.invited'/></th>
          <th><spring:message code='label.reason'/></th>
          <th><spring:message code='label.period'/></th>
          <th colspan="2"><spring:message code='label.state'/></th>
        </tr>
      </thead>
    <tbody>
      <c:forEach items="${invites}" var="invite">
        <tr>
          <td>${invite.creator.profile.fullName}</td>
          <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
          <td>${invite.fullName} (${invite.email})</td>
          <td>${invite.reasonName}</td>
          <td>${invite.periodFormatted}</td>
          <td>${invite.state.localizedName}</td>
          <td>
            <div class="btn-group btn-group-xs">
              <a href="${pageContext.request.contextPath}/external-users-invite/inviteDetails/${invite.externalId}" type="button" class="btn btn-default details-button">
                  <spring:message code='button.details'/>
              </a>
            </div>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>