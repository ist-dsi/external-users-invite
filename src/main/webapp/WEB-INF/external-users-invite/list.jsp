<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="page-header">
  <h1><spring:message code='title.invites'/></h1>
</div>
<div class="well">
  <p><spring:message code='external.invites.list.well'/></p>
</div>

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
      <a href="${pageContext.request.contextPath}/external-users-invite/newInvite" type="button" class="btn btn-primary"><spring:message code='button.create'/></a>
    </div>
  </div>
</p>

<c:if test="${emptyInvites}">
  <div class="alert alert-warning">
    <p><spring:message code='label.invites.empty'/></p>
  </div>
</c:if>

<c:if test="${! emptyInvites}">
  <%-- TODO: design (buttons also) --%>
  <c:if test="${empty completedInvites}">
    <div class="alert alert-info">
      <p><spring:message code='label.completed.invites.empty'/></p>
    </div>
  </c:if>
  <c:if test="${! empty completedInvites}">
    <div class="panel panel-warning">
      <!-- Default panel contents -->
      <div class="panel-heading"><spring:message code='title.unconfirmed.invites'/></div>
      <div class="panel-body">
        <p><spring:message code='label.unconfirmed.invites'/></p>
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
            <th><spring:message code='label.inviter'/></th>
            <th><spring:message code='label.creation.time'/></th>
            <th><spring:message code='label.invited'/></th>
            <th><spring:message code='label.period'/></th>
            <th><spring:message code='label.state'/></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${completedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd/MM/YYY HH:mm')} - ${invite.period.end.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.state.localizedName}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <a data-base-url="${pageContext.request.contextPath}/external-users-invite/confirmInvite/" href="${pageContext.request.contextPath}/external-users-invite/confirmInvite/${invite.externalId}" class="btn btn-default" id='accept-btn'><spring:message code='button.accept'/></a>
                  <a data-base-url="${pageContext.request.contextPath}/external-users-invite/rejectInvite/" href="${pageContext.request.contextPath}/external-users-invite/rejectInvite/${invite.externalId}" class="btn btn-default" id='reject-btn'><spring:message code='button.reject'/></a>
                  <button type="button" class="btn btn-default details-button"
                    data-creator="${invite.creator.profile.fullName}" data-creationtime="${invite.creationTime.toString('dd/MM/YYY HH:mm')}"
                    data-start="${invite.period.start.toString('dd/MM/YYY HH:mm')}" data-end="${invite.period.end.toString('dd/MM/YYY HH:mm')}"
                    data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-unit="${invite.unit.name} (${invite.unit.acronym})"
                    data-state="${invite.state.localizedName}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}"
                    data-email="${invite.email}" data-contact="${invite.contact}"   data-contactsos="${invite.contactSOS}"
                    data-gender="${invite.gender}"
                    data-iddocumenttype="${invite.idDocumentType}" data-iddocumentnumber="${invite.idDocumentNumber}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-oid="${invite.externalId}">
                    <spring:message code='button.details'/>
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
      <div class="panel-heading"><spring:message code='title.incomplete.invites'/></div>
      <div class="panel-body">
        <p><spring:message code='label.incomplete.invites'/></p>
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
            <th><spring:message code='label.inviter'/></th>
            <th><spring:message code='label.creation.time'/></th>
            <th><spring:message code='label.invited'/></th>
            <th><spring:message code='label.period'/></th>
            <th><spring:message code='label.state'/></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${notCompletedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd/MM/YYY HH:mm')} - ${invite.period.end.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.state.localizedName}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button"
                    data-creator="${invite.creator.profile.fullName}" data-creationtime="${invite.creationTime.toString('dd/MM/YYY HH:mm')}"
                    data-start="${invite.period.start.toString('dd/MM/YYY HH:mm')}" data-end="${invite.period.end.toString('dd/MM/YYY HH:mm')}"
                    data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-unit="${invite.unit.name} (${invite.unit.acronym})"
                    data-state="${invite.state.localizedName}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}"
                    data-email="${invite.email}" data-contact="${invite.contact}"   data-contactsos="${invite.contactSOS}"
                    data-gender="${invite.gender}"
                    data-iddocumenttype="${invite.idDocumentType}" data-iddocumentnumber="${invite.idDocumentNumber}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-oid="${invite.externalId}">
                    <spring:message code='button.details'/>
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
      <div class="panel-heading"><spring:message code='title.confirmed.invites'/></div>
      <div class="panel-body">
        <p><spring:message code='label.confirmed.invites'/></p>
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
            <th><spring:message code='label.inviter'/></th>
            <th><spring:message code='label.creation.time'/></th>
            <th><spring:message code='label.invited'/></th>
            <th><spring:message code='label.period'/></th>
            <th><spring:message code='label.state'/></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${confirmedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd/MM/YYY HH:mm')} - ${invite.period.end.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.state.localizedName}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button"
                    data-creator="${invite.creator.profile.fullName}" data-creationtime="${invite.creationTime.toString('dd/MM/YYY HH:mm')}"
                    data-start="${invite.period.start.toString('dd/MM/YYY HH:mm')}" data-end="${invite.period.end.toString('dd/MM/YYY HH:mm')}"
                    data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-unit="${invite.unit.name} (${invite.unit.acronym})"
                    data-state="${invite.state.localizedName}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}"
                    data-email="${invite.email}" data-contact="${invite.contact}"   data-contactsos="${invite.contactSOS}"
                    data-gender="${invite.gender}"
                    data-iddocumenttype="${invite.idDocumentType}" data-iddocumentnumber="${invite.idDocumentNumber}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-oid="${invite.externalId}">
                    <spring:message code='button.details'/>
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
      <div class="panel-heading"><spring:message code='title.rejected.invites'/></div>
      <div class="panel-body">
        <p><spring:message code='label.rejected.invites'/></p>
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
            <th><spring:message code='label.inviter'/></th>
            <th><spring:message code='label.creation.time'/></th>
            <th><spring:message code='label.invited'/></th>
            <th><spring:message code='label.period'/></th>
            <th><spring:message code='label.state'/></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${rejectedInvites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd/MM/YYY HH:mm')} - ${invite.period.end.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.state.localizedName}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default details-button"
                    data-creator="${invite.creator.profile.fullName}" data-creationtime="${invite.creationTime.toString('dd/MM/YYY HH:mm')}"
                    data-start="${invite.period.start.toString('dd/MM/YYY HH:mm')}" data-end="${invite.period.end.toString('dd/MM/YYY HH:mm')}"
                    data-reason="${invite.reasonName} - ${invite.reasonDescription}"
                    data-unit="${invite.unit.name} (${invite.unit.acronym})"
                    data-state="${invite.state.localizedName}"
                    data-name="${invite.givenName}" data-familynames="${invite.familyNames}"
                    data-email="${invite.email}" data-contact="${invite.contact}"   data-contactsos="${invite.contactSOS}"
                    data-gender="${invite.gender}"
                    data-iddocumenttype="${invite.idDocumentType}" data-iddocumentnumber="${invite.idDocumentNumber}"
                    data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}"
                    data-oid="${invite.externalId}">
                    <spring:message code='button.details'/>
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
        <h3 class="modal-title"><spring:message code='modal.title.invite.new'/></h3>
        <small class="explanation"><spring:message code='modal.title.invite.new.explanation'/></small>
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
          <label class="col-sm-4 control-label"><b><spring:message code='label.unit'/></b></label>
          <div class="col-sm-8">
            <div class="information unit"></div>
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
          <a data-base-url="${pageContext.request.contextPath}/external-users-invite/confirmInvite/" href="" class="btn btn-success" id='accept-btn'><spring:message code='button.accept'/></a>
          <a data-base-url="${pageContext.request.contextPath}/external-users-invite/rejectInvite/" href="" class="btn btn-danger" id='reject-btn'><spring:message code='button.reject'/></a>
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

    ['creator','creationtime','unit','start','end','reason','state','name','familynames','gender','email','iddocumenttype','iddocumentnumber','invitedinstitutionname','invitedinstitutionaddress','contact','contactsos'].map(function(x){
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
