<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<div class="page-header">
  <h1>Example page header </h1>
</div>
<div class="well">
  <p>This is an ordinary paragraph that is long enough to wrap to multiple lines so that you can see how the line spacing looks. This is an ordinary paragraph that is long enough to wrap to multiple lines so that you can see how the line spacing looks.</p>
</div>

<c:if test="${! empty messages}">
  <div class="alert alert-success" role="alert">
    <c:forEach items="${messages}" var="message">
      <p>${message}</p>
    </c:forEach>
  </div>
</c:if>

<h3>Contextual title</h3>
<p>
  <div class="row">
    <div class="col-sm-8">
      <a href="${pageContext.request.contextPath}/external-users-invite/newInvite" type="button" class="btn btn-primary">Create</a>
    </div>
  </div>
</p>

<c:if test="${empty invites}">
  <div class="alert alert-warning">
    <p><spring:message code='label.invites.empty'/></p>
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
    </colgroup>
    <thead>
      <tr>
        <th>Creator</th>
        <th>Invited</th>
        <th>Period</th>
        <th>State</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${invites}" var="invite">
        <tr>
          <td>${invite.creatorFullName}</td>
          <td>${invite.name} (${invite.email})</td>
          <td>${invite.period.start.toString('dd-MM-YYY HH:mm')} - ${invite.period.end.toString('dd-MM-YYY HH:mm')}</td>
          <td>${invite.state}</td>
          <td>
            <div class="btn-group btn-group-xs">
              <button type="button" class="btn btn-default details-button" data-creator="${invite.creatorFullName}" data-invitationinstitution="${invite.invitationInstitution}" data-start="${invite.period.start.toString('dd-MM-YYY HH:mm')}" data-end="${invite.period.end.toString('dd-MM-YYY HH:mm')}" data-reason="${invite.reason}" data-name="${invite.name}"
                data-email="${invite.email}" data-iddocumenttype="${invite.idDocumentType}" data-iddocumentnumber="${invite.idDocumentNumber}" data-invitedinstitutionname="${invite.invitedInstitutionName}" data-invitedinstitutionaddress="${invite.invitedInstitutionAddress}" data-contact="${invite.contact}" data-contactsos="${invite.contactSOS}" data-state="${invite.state}">Details</button>
            </div>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
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
          <label class="col-sm-4 control-label"><b><spring:message code='label.goals'/></b></label>
          <div class="col-sm-8">
            <div class="information invitationinstitution"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.goals'/></b></label>
          <div class="col-sm-8">
            <div class="information start"></div>
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-4 control-label"><b><spring:message code='label.goals'/></b></label>
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

        <div class="col-sm-offset-4">
          <button class="btn btn-success">Accept</button>
          <button class="btn btn-danger">Reject</button>
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

    ['creator','invitationinstitution','start','end','reason', 'state', 'name', 'email', 'iddocumenttype', 'iddocumentnumber', 'invitedinstitutionname', 'invitedinstitutionaddress', 'contact', 'contactsos'].map(function(x){
      $("#modal ." + x).html(e.data(x));
    });

    $('#modal').modal('show');
  });
})
</script>
