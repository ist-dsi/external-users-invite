<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<div class="page-header">
  <h2><spring:message code='title.invites'/></h2>
  <small><spring:message code='title.configurations'/></small>
</div>
  <p><spring:message code='external.invites.admin.well'/></p>

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

<h4><spring:message code='title.reasons'/> <span class="badge">${reasons.size()}</span></a></h4>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#new-reason-modal">
  <spring:message code='button.create'/>
</button>

<!-- Modal -->
<div class="modal fade" id="new-reason-modal" tabindex="-1" role="dialog" aria-labelledby="modal-label" aria-hidden="true">
  <div class="modal-dialog">
    <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/admin-external-invite/addReason" id='new-reason-form'>
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h3 class="modal-title" id="modal-label"><spring:message code='title.reason.create'/></h3>
          <small><spring:message code='external.invite.reason.create.well'/></small>
        </div>
        <div class="modal-body">

          <div id='modal-errors' class="alert alert-danger alert-dismissible fade in" role="alert" hidden>
            <button type="button" class="close" onclick="hideModalErrors()"><span aria-hidden="true">&times</span></button>
            <p><spring:message code='error.modal.fill.fields'/></p>
          </div>

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

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code='button.cancel'/></button>
          <button type="submit" class="btn btn-primary"><spring:message code='button.submit'/></button>
        </div>
      </div>
    </form>      
  </div>
</div>

<script type="text/javascript">
  function hideModalErrors() {
      $('#modal-errors').hide();
  }

  $(function() {
    $('#new-reason-form').submit(function() {
        var hasError = false;

        $(this).find('input').each(function(index, input) {
          if(! $(input).val()) {
            hasError = true;
            $('#modal-errors').show();
            $(input).closest('.form-group').addClass('has-error');
          }
          else {
            $(input).closest('.form-group').removeClass('has-error');
          } 
        });

        return ! hasError;
    });
});
</script>

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
      <col></col>
    </colgroup>
    <thead>
      <tr>
        <th><spring:message code='label.name'/></th>
        <th><spring:message code='label.description'/></th>
        <th><spring:message code='label.active'/></th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${reasons}" var="reason">
        <tr>
          <td>${reason.name}</td>
          <td>${reason.description}</td>
          <td><spring:message code='${reason.active ? "label.yes" : "label.no"}'/></td>
          <td class="pull-right">
            <c:if test="${reason.active}">
              <a href="${pageContext.request.contextPath}/admin-external-invite/disableReason/${reason.externalId}" class="btn btn-default"><spring:message code='label.deactivate'/></a>
            </c:if>
            <c:if test="${! reason.active}">
              <a href="${pageContext.request.contextPath}/admin-external-invite/enableReason/${reason.externalId}" class="btn btn-default"><spring:message code='label.activate'/></a>
            </c:if>
            <a href="${pageContext.request.contextPath}/admin-external-invite/deleteReason/${reason.externalId}" class="btn btn-default">&times</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</c:if>