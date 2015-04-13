<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-header">
  <h1><spring:message code='title.reason.create'/></h1>
</div>
<div class="well">
  <p><spring:message code='external.invite.reason.create.well'/></p>
</div>

<c:if test="${! empty errors}">
  <div class="alert alert-danger" role="alert">
    <c:forEach var="error" items="${errors}">
      <p><spring:message code='error.external.invite.${error}'/></p>
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

<c:if test="${! empty reasonBean}">
  <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/admin-external-invite/addReason">

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

  </form>
</c:if>