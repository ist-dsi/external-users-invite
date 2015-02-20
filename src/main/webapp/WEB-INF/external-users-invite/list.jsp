<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<div class="page-header">
  <h1>_Example page header </h1>
</div>
<div class="well">
  <p>___This is an ordinary paragraph that is long enough to wrap to multiple lines so that you can see how the line spacing looks. This is an ordinary paragraph that is long enough to wrap to multiple lines so that you can see how the line spacing looks.</p>
</div>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach items="${messages}" var="message">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<c:if test="${empty admin || action}">
  <div class="alert alert-danger" role="alert">
    <p>__MISSING ADMIN || ACTION MODEL ATTRIBUTE</p>
  </div>
</c:if>

<h3>_Contextual title</h3>
<p>
  <div class="row">
    <div class="col-sm-8">
      <a href="${pageContext.request.contextPath}/external-users-invite/newInvite" type="button" class="btn btn-primary">_Create</a>
    </div>
  </div>
</p>

<c:if test="${emptyInvites}">
  <div class="alert alert-warning">
    <p><spring:message code='label.invites.empty'/></p>
  </div>
</c:if>

<c:if test="${! emptyInvites}">

  <c:if test="${empty completedInvites}">
    <div class="alert alert-success">
      <p>__You dont' have invites needing confirmation</p>
    </div>
  </c:if>
  <c:if test="${! empty completedInvites}">
    <div class="panel panel-warning">
      <!-- Default panel contents -->
      <div class="panel-heading">__Needing confirmation</div>
      <div class="panel-body">
        <p>__This invites require your confirmation</p>
      </div>

      <!-- Table -->
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
            <th>_Creator</th>
            <th>_Creation date</th>
            <th>_Invited</th>
            <th>_Period</th>
            <th>_State</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${completedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd-MM-YYY HH:mm')} - ${invite.period.end.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.state}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <a data-base-url="${pageContext.request.contextPath}${action}/confirmInvite/" href="${pageContext.request.contextPath}${action}/confirmInvite/${invite.externalId}" class="btn btn-default" id='accept-btn'>_Accept</a>
                  <a data-base-url="${pageContext.request.contextPath}${action}/rejectInvite/" href="${pageContext.request.contextPath}${action}/rejectInvite/${invite.externalId}" class="btn btn-default" id='reject-btn'>_Reject</a>
                  <button type="button" class="btn btn-default details-button" data-creator="${invite.creator.profile.fullName}" data-contact="${invite.contact}" data-gender="${invite.gender}"
                    data-start="${invite.period.start.toString('dd-MM-YYY HH:mm')}" data-end="${invite.period.end.toString('dd-MM-YYY HH:mm')}" data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}" data-email="${invite.email}" data-iddocumenttype="${invite.idDocumentType}"  data-state="${invite.state}"
                    data-contactsos="${invite.contactSOS}" data-iddocumentnumber="${invite.idDocumentNumber}" data-invitationinstitution="${invite.invitationInstitution}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-creationtime="${invite.creationTime.toString('dd-MM-YYY HH:mm')}" data-oid="${invite.externalId}" data-state="${invite.state}">
                    _Details
                  </button>
                  </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <c:if test="${! empty notCompletedInvites}">
    <div class="panel panel-default">
      <!-- Default panel contents -->
      <div class="panel-heading">__Incomplete</div>
      <div class="panel-body">
        <p>__This invites require invited-side completion</p>
      </div>

      <!-- Table -->
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
            <th>_Creator</th>
            <th>_Creation date</th>
            <th>_Invited</th>
            <th>_Period</th>
            <th>_State</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${notCompletedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd-MM-YYY HH:mm')} - ${invite.period.end.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.state}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button" data-creator="${invite.creator.profile.fullName}" data-contact="${invite.contact}" data-gender="${invite.gender}"
                    data-start="${invite.period.start.toString('dd-MM-YYY HH:mm')}" data-end="${invite.period.end.toString('dd-MM-YYY HH:mm')}" data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}" data-email="${invite.email}" data-iddocumenttype="${invite.idDocumentType}"  data-state="${invite.state}"
                    data-contactsos="${invite.contactSOS}" data-iddocumentnumber="${invite.idDocumentNumber}" data-invitationinstitution="${invite.invitationInstitution}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-creationtime="${invite.creationTime.toString('dd-MM-YYY HH:mm')}" data-oid="${invite.externalId}" data-state="${invite.state}">
                    _Details
                  </button>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <c:if test="${! empty confirmedInvites}">
    <div class="panel panel-default">
      <!-- Default panel contents -->
      <div class="panel-heading">__Confirmed</div>
      <div class="panel-body">
        <p>__This invites have been confirmed</p>
      </div>

      <!-- Table -->
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
            <th>_Creator</th>
            <th>_Creation date</th>
            <th>_Invited</th>
            <th>_Period</th>
            <th>_State</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${confirmedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd-MM-YYY HH:mm')} - ${invite.period.end.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.state}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button" data-creator="${invite.creator.profile.fullName}" data-contact="${invite.contact}" data-gender="${invite.gender}"
                    data-start="${invite.period.start.toString('dd-MM-YYY HH:mm')}" data-end="${invite.period.end.toString('dd-MM-YYY HH:mm')}" data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}" data-email="${invite.email}" data-iddocumenttype="${invite.idDocumentType}"  data-state="${invite.state}"
                    data-contactsos="${invite.contactSOS}" data-iddocumentnumber="${invite.idDocumentNumber}" data-invitationinstitution="${invite.invitationInstitution}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-creationtime="${invite.creationTime.toString('dd-MM-YYY HH:mm')}" data-oid="${invite.externalId}" data-state="${invite.state}">
                    _Details
                  </button>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <c:if test="${! empty rejectedInvites}">
    <div class="panel panel-default">
      <!-- Default panel contents -->
      <div class="panel-heading">__Rejected</div>
      <div class="panel-body">
        <p>__This invites have been rejected</p>
      </div>

      <!-- Table -->
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
            <th>_Creator</th>
            <th>_Creation date</th>
            <th>_Invited</th>
            <th>_Period</th>
            <th>_State</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${rejectedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd-MM-YYY HH:mm')} - ${invite.period.end.toString('dd-MM-YYY HH:mm')}</td>
              <td>${invite.state}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button" data-creator="${invite.creator.profile.fullName}" data-contact="${invite.contact}" data-gender="${invite.gender}"
                    data-start="${invite.period.start.toString('dd-MM-YYY HH:mm')}" data-end="${invite.period.end.toString('dd-MM-YYY HH:mm')}" data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}" data-email="${invite.email}" data-iddocumenttype="${invite.idDocumentType}"  data-state="${invite.state}"
                    data-contactsos="${invite.contactSOS}" data-iddocumentnumber="${invite.idDocumentNumber}" data-invitationinstitution="${invite.invitationInstitution}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-creationtime="${invite.creationTime.toString('dd-MM-YYY HH:mm')}" data-oid="${invite.externalId}" data-state="${invite.state}">
                    _Details
                  </button>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

</c:if>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="form-horizontal modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close"><span class="sr-only"><spring:message code="button.close"/></span></button>
        <h3 class="modal-title">"label.details"</h3>
        <small class="explanation">"label.modal.proposals.details"</small>
      </div>
      <div class="modal-body">

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.inviter'/></b></label>
          <div class="col-sm-8">
            <div class="information creator"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.creation.time'/></b></label>
          <div class="col-sm-8">
            <div class="information creationtime"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.invitation.institution'/></b></label>
          <div class="col-sm-8">
            <div class="information invitationinstitution"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.date.start'/></b></label>
          <div class="col-sm-8">
            <div class="information start"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.date.end'/></b></label>
          <div class="col-sm-8">
            <div class="information end"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.reason'/></b></label>
          <div class="col-sm-8">
            <div class="information reason"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.name'/></b></label>
          <div class="col-sm-8">
            <div class="information name"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.family.names'/></b></label>
          <div class="col-sm-8">
            <div class="information familynames"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.gender'/></b></label>
          <div class="col-sm-8">
            <div class="information gender"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.email'/></b></label>
          <div class="col-sm-8">
            <div class="information email"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.id.document.type'/></b></label>
          <div class="col-sm-8">
            <div class="information iddocumenttype"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.id.document.number'/></b></label>
          <div class="col-sm-8">
            <div class="information iddocumentnumber"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.invited.institution.name'/></b></label>
          <div class="col-sm-8">
            <div class="information invitedinstitutionname"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.invited.institution.address'/></b></label>
          <div class="col-sm-8">
            <div class="information invitedinstitutionaddress"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.contact'/></b></label>
          <div class="col-sm-8">
            <div class="information contact"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.contact.sos'/></b></label>
          <div class="col-sm-8">
            <div class="information contactsos"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.state'/></b></label>
          <div class="col-sm-8">
            <div class="information state"></div>
          </div>
        </div>

        <div id='action-buttons' class="col-sm-offset-4">
          <a data-base-url="${pageContext.request.contextPath}${action}/confirmInvite/" href="" class="btn btn-success" id='accept-btn'>_Accept</a>
          <a data-base-url="${pageContext.request.contextPath}${action}/rejectInvite/" href="" class="btn btn-danger" id='reject-btn'>_Reject</a>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code='button.close'/></button>
      </div>
    </div>
  </div>
</div>
<!-- End Modal -->

<script type="text/javascript">

$(function(){
  $(".details-button").on("click", function(evt){
    var e = $(evt.target);

    ['creator','creationtime', 'invitationinstitution','start','end','reason', 'state', 'name', 'familynames', 'gender', 'email', 'iddocumenttype', 'iddocumentnumber', 'invitedinstitutionname', 'invitedinstitutionaddress', 'contact', 'contactsos'].map(function(x){
      $("#modal ." + x).html(e.data(x));
    });

    var oid = e.data('oid')

    var acceptBtn = $('#accept-btn')
    $(acceptBtn).attr('href', $(acceptBtn).data('base-url') + oid)
    var rejectBtn = $('#reject-btn')
    $(rejectBtn).attr('href', $(rejectBtn).data('base-url') + oid)

    $('#modal').modal('show');
  });
})
</script>
