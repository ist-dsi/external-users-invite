<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-header">
  <h1>_ExternalInviteConfigurations </h1>
</div>
<div class="well">
  <p>_This section allows you to define some configurations for external invites.</p>
</div>
<h3>_ExpirationDays</h3>

<dl class="dl-horizontal">
  <dt>_expirationDays</dt>
  <dd>${expirationDays}</dd>
</dl>


<h3>_AvailableReasons</h3>
<c:if test="${empty reasons}">
  <div class="alert alert-warning">
    <p>_reasonsEmpty</p>
  </div>
</c:if>
<c:if test="${! empty reasons}">
<table class="table">
  <colgroup>
    <col></col>
    <col></col>
    <%-- <col></col> --%>
  </colgroup>
  <thead>
    <tr>
      <th>_name</th>
      <th>_desc</th>
      <%-- <th></th> --%>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${reasons}" var="reason">
      <tr>
        <td>${reason.name}</td>
        <td>${reason.description}</td>
        <%-- <td>
          <a href="${pageContext.request.contextPath}/admin-external-invite/deleteReason/${reason.externalId}" class="btn btn-default">_delete</a>
          <a href="${pageContext.request.contextPath}/admin-external-invite/editReason/${reason.externalId}" class="btn btn-default">_edit</a>
        </td> --%>
      </tr>
    </c:forEach>
  </tbody>
</table>
</c:if>

<h4>_CreateNewReason</h4> <%-- TODO: modal? --%>
<form method="POST" action="${pageContext.request.contextPath}/admin-external-invite/addReason" class="form-inline">

  <div class="form-group">
    <label for="name">_name</label>
    <input type="text" class="form-control" id="name" name="name" placeholder="_name" required="required" value="${reasonBean.name}"/>
  </div>

  <div class="form-group">
    <label for="description">_description</label>
    <input type="text" class="form-control" id="description" name="description" placeholder="_description" required="required" value="${reasonBean.description}"/>
  </div>

  <button type="submit" class="btn btn-default" id="submitButton">_createReason</button>
</form>
