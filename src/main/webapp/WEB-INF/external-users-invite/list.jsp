<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

${portal.toolkit()}

<div class="page-header">
  <h1><spring:message code='title.invites'/></h1>
</div>
<p><spring:message code='external.invites.list.well'/></p>

<c:if test="${! empty errors}">
  <div class="alert alert-danger" role="alert">
    <c:forEach items="${errors}" var="error">
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

<p>
  <div class="row">
    <div class="col-sm-8">
      <!-- Button trigger modal -->
      <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#new-invite-modal"><i class="icon icon-plus"></i><spring:message code='button.new'/></button>
      <c:if test="${isManager}">
        <a href="${pageContext.request.contextPath}/external-users-invite/admin-external-invite" type="button" class='btn btn-default'><spring:message code='button.reasons.manage'/></a>
      </c:if>
      <a href="${pageContext.request.contextPath}/external-users-invite/historic" type="button" class='btn btn-default'><spring:message code='button.invites.historic'/></a>
    </div>
  </div>
</p>

<!-- Modal -->
<div class="modal fade" id="new-invite-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form class="form-horizontal" method="POST" action="${pageContext.request.contextPath}/external-users-invite/sendInvite" id='new-invite-form'>
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h3 class="modal-title" id="modal-label"><spring:message code='title.invites.new'/></h3>
          <small><spring:message code='external.invites.new.well'/></small>
        </div>
        <div class="modal-body">

          <div id='modal-errors' class="alert alert-danger alert-dismissible fade in" role="alert" hidden>
            <button type="button" class="close" onclick="hideModalErrors()"><span aria-hidden="true">&times</span></button>
            <p><spring:message code='error.modal.fill.fields'/></p>
          </div>

          <div class="alert alert-info" role="alert"><spring:message code='external.invites.new.info' arguments="${expirationDays}"/></div>

          <div class="form-group">
            <label for="givenName" class="col-sm-2 control-label"><spring:message code='label.given.name'/></label>
            <div class="col-sm-10">
              <input type="text" class="form-control required" id="givenName" name="givenName" placeholder="${givenName}" required="required" value="${inviteBean.givenName}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="familyNames" class="col-sm-2 control-label"><spring:message code='label.family.names'/></label>
            <div class="col-sm-10">
              <input type="text" class="form-control required" id="familyNames" name="familyNames" placeholder="${familyNames}" required="required" value="${inviteBean.familyNames}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="email" class="col-sm-2 control-label"><spring:message code='label.email'/></label>
            <div class="col-sm-10">
              <input type="email" class="form-control required" id="email" name="email" placeholder="${email}" required="required"  value="${inviteBean.email}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="startDate" class="col-sm-2 control-label"><spring:message code='label.date.start'/></label>
            <div class="col-sm-10">
              <input type="text" bennu-date class="form-control required" id="startDate" name="startDate" placeholder="${startDate}" value="${inviteBean.startDate}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="endDate" class="col-sm-2 control-label"><spring:message code='label.date.end'/></label>
            <div class="col-sm-10">
              <input type="text" bennu-date class="form-control required" id="endDate" name="endDate" placeholder="${endDate}" value="${inviteBean.endDate}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="reason" class="col-sm-2 control-label"><spring:message code='label.reason'/></label>
            <div class="col-sm-10">
              <select id="reason" name="reason" onchange="unblockOtherReason()">
                <option value="" id='reason-select-default'><spring:message code='label.option.select'/></option>
                <c:forEach var="reason" items="${reasons}">
                  <option value="${reason.externalId}">${reason.name} - ${reason.description}</option>
                </c:forEach>
                <option id='other-reason-option' value=""><spring:message code='label.option.other'/></option>
              </select>
            </div>
          </div>

          <div class="form-group">
            <label for="otherReason" class="col-sm-2 control-label"><spring:message code='label.reason.other'/></label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="otherReason" name="otherReason" placeholder="${otherReason}" value="${inviteBean.otherReason}"/>
            </div>
          </div>

          <div class="form-group">
            <label for="unit" class="col-sm-2 control-label"><spring:message code='label.unit'/></label>
            <div class="col-sm-10">
              <select id="unit" name="unit"  required="required" class="required">
                <option value=""><spring:message code='label.option.select'/></option>
                <c:forEach var="unit" items="${units}">
                  <option value="${unit.externalId}">${unit.name} <c:if test="${! empty unit.acronym}">(${unit.acronym})</c:if></option>
                </c:forEach>
              </select>
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
  $( document ).ready(function() {
    unblockOtherReason();
  });

  function unblockOtherReason() {
    if($('#reason').children(":selected").attr("id") == 'other-reason-option') {
      $('#otherReason').prop('disabled', false);
    }
    else {
      $('#otherReason').prop('disabled', true);
    }
  }

  function hideModalErrors() {
      $('#modal-errors').hide();
  }

  $(function() {
    $('#new-invite-form').submit(function() {
        var hasError = false;
        //TODO: fix invalid date comparison. Issue: https://jira.fenixedu.org/browse/BNN-227
        $(this).find('.required').each(function(index, input) {
          if( (! $(input).val()) || (($(input).attr("bennu-date") !== undefined) && ($(input).val() == "Invalid date"))) {
            hasError = true;
            $('#modal-errors').show();
            $(input).closest('.form-group').addClass('has-error');
          } 
          else {
            $(input).closest('.form-group').removeClass('has-error');
          } 
        });

        hasError = !checkReasonFilled() || hasError;

        return ! hasError;
    });
  });

  function checkReasonFilled() {
      var reasonInput = $('#reason')
      var otherReasonInput = $('#otherReason')

      if($(reasonInput).children(":selected").attr("id") == 'reason-select-default') {
        $('#modal-errors').show();
        $(reasonInput).closest('.form-group').addClass('has-error');
        return false;
      }
      else {
        $(reasonInput).closest('.form-group').removeClass('has-error');
      }

      if(($(reasonInput).children(":selected").attr("id") == 'other-reason-option') && (!$(otherReasonInput).val())) {
        $('#modal-errors').show();
        $(otherReasonInput).closest('.form-group').addClass('has-error');
        return false;
      }
      else {
        $(otherReasonInput).closest('.form-group').removeClass('has-error');
      }

      return true;
  }
</script>

<c:if test="${! empty finishedInvites}">
<h4><spring:message code='title.invites.completed'/> <span class="badge">${finishedInvites.size()}</span></a></h4>
  <table class="table">
    <colgroup>
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
      <c:forEach items="${finishedInvites}" var="invite">
        <tr>
          <td>${invite.creator.profile.fullName}</td>
          <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
          <td>${invite.fullName} (${invite.email})</td>
          <td>${invite.reasonName}</td>
          <td>${invite.periodFormatted}</td>
          <td>${invite.state.localizedName}</td>
          <td>
            <div class="btn-group btn-group-xs">
              <a href="${pageContext.request.contextPath}${action}/confirmInvite/${invite.externalId}" class="btn btn-default" id='accept-btn'><spring:message code='button.accept'/></a>
              <a href="${pageContext.request.contextPath}${action}/rejectInvite/${invite.externalId}" class="btn btn-default" id='reject-btn'><spring:message code='button.reject'/></a>
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

<h4><spring:message code='title.invites.incomplete'/> <span class="badge">${unfinishedInvites.size()}</span></a></h4>
<c:if test="${empty unfinishedInvites}">
  <div class="panel panel-default">
    <div class="panel-body">
      <spring:message code='label.completed.invites.empty'/> 
    </div>
  </div>
</c:if>
<c:if test="${! empty unfinishedInvites}">
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
      <c:forEach items="${unfinishedInvites}" var="invite">
        <tr>
          <td>${invite.creator.profile.fullName}</td>
          <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
          <td>${invite.fullName} (${invite.email})</td>
          <td>${invite.reasonName}</td>
          <td>${invite.periodFormatted}</td>
          <td>${invite.state.localizedName}</td>
          <td>
            <div class="btn-group btn-group-xs">
              <a href="${pageContext.request.contextPath}${action}/confirmInvite/${invite.externalId}" class="btn btn-default" id='accept-btn'><spring:message code='button.accept'/></a>
              <a href="${pageContext.request.contextPath}${action}/rejectInvite/${invite.externalId}" class="btn btn-default" id='reject-btn'><spring:message code='button.reject'/></a>
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