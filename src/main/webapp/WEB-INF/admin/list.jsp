<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<div class="page-header">
  <h1><spring:message code='title.invites'/></h1>
</div>
<div class="well">
  <p><spring:message code='external.invites.admin.well'/></p>
</div>

<c:if test="${! empty errors}">
  <div class="alert alert-danger" role="alert">
    <c:forEach items="${errors}" var="error">
      <p><spring:message code="error.external.invite.${error}"/></p>
    </c:forEach>
  </div>
</c:if>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach items="${messages}" var="message">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>


<h4><spring:message code='title.expiration.days'/></h4>

<dl class="dl-horizontal">
  <dt><spring:message code='title.expiration.days'/></dt>
  <dd>${expirationDays}</dd>
</dl>

<br><br>

<h4><spring:message code='title.reasons'/> <span class="badge">${reasons.size()}</span></a></h4>

<!-- <a href="${pageContext.request.contextPath}/admin-external-invite/prepareAddReason" type="button" class="btn btn-primary" data-toggle="modal" data-target="new-reason-modal"><spring:message code='button.create'/></a> -->

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#new-reason-modal">
  <spring:message code='button.create'/>
</button>

<!-- Modal -->
<div class="modal fade" id="new-reason-modal" tabindex="-1" role="dialog" aria-labelledby="modal-label" aria-hidden="true">
  <div class="modal-dialog">
    <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/admin-external-invite/addReason">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="modal-label">Modal title</h4>
        </div>
        <div class="modal-body">

          <div class="form-group">
            <label for="name" class="col-sm-2 control-label"><spring:message code='label.name'/></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="name" name="name" placeholder="<spring:message code='label.name'/>" required="required" value="${reasonBean.name}">
            </div>
          </div>

          <div class="form-group">
            <label for="description" class="col-sm-2 control-label"><spring:message code='label.description'/></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="description" name="description" placeholder="<spring:message code='label.description'/>" required="required" value="${reasonBean.description}">
            </div>
          </div>

          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-default"><spring:message code='label.create'/></button>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code='button.cancel'/></button>
          <button type="submit" class="btn btn-primary"><spring:message code='button.submit'/></button>
        </div>
      </div>
    </form>      
  </div>
</div>



<c:if test="${empty reasons}">
  <div class="panel panel-default">
    <div class="panel-body">
      <spring:message code='label.reasons.empty'/>
    </div>
  </div>
  </c:if>

<c:if test="${! empty reasons}">
  <table class="table">
    <colgroup>
      <col></col>
      <col></col>
      <col></col>
    </colgroup>
    <thead>
      <tr>
        <th><spring:message code='label.name'/></th>
        <th><spring:message code='label.description'/></th>
        <th><spring:message code='label.active'/></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${reasons}" var="reason">
        <tr>
          <td>${reason.name}</td>
          <td>${reason.description}</td>
          <td><spring:message code='${reason.active ? "label.yes" : "label.no"}'/></td>
          <td>
            <c:if test="${reason.active}">
              <a href="${pageContext.request.contextPath}/admin-external-invite/disableReason/${reason.externalId}" class="btn btn-default"><spring:message code='label.deactivate'/></a>
            </c:if>
            <c:if test="${! reason.active}">
              <a href="${pageContext.request.contextPath}/admin-external-invite/enableReason/${reason.externalId}" class="btn btn-default"><spring:message code='label.activate'/></a>
            </c:if>
            <a href="${pageContext.request.contextPath}/admin-external-invite/deleteReason/${reason.externalId}" class="btn btn-default pull-right">&times</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>