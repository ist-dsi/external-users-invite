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

<ul class="nav nav-tabs" data-tabs="tabs">
  <li role="presentation" class="active" role="tab"><a href="#invites" data-toggle="tab"><spring:message code='title.invites'/></a></li>
  <li role="presentation" role="tab"><a href="#configurations" data-toggle="tab"><spring:message code='title.configurations'/></a></li>
</ul>

<div class="tab-content">
  <div role="tabpanel" class="tab-pane active" id="invites">
    <h4><spring:message code='title.invites'/> (${invites.size()})</h4>

    <c:if test="${empty invites}">
      <div class="alert alert-warning">
        <p><spring:message code='label.invites.empty'/></p>
      </div>
    </c:if>
    <c:if test="${!empty invites}">
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
          <c:forEach items="${invites}" var="invite">
            <tr>
              <td>${invite.creator.profile.fullName}</td>
              <td>${invite.creationTime.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.givenName} (${invite.email})</td>
              <td>${invite.period.start.toString('dd/MM/YYY HH:mm')} - ${invite.period.end.toString('dd/MM/YYY HH:mm')}</td>
              <td>${invite.state.localizedName}</td>
              <td>
                <div class="btn-group btn-group-xs">
                  <a href="${pageContext.request.contextPath}/admin-external-invite/confirmInvite/${invite.externalId}" class="btn btn-default accept-btn"><spring:message code='button.accept'/></a>
                  <a href="${pageContext.request.contextPath}/admin-external-invite/rejectInvite/${invite.externalId}" class="btn btn-default reject-btn"><spring:message code='button.reject'/></a>
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
    </c:if>

    <!-- Modal -->
    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="form-horizontal modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close"><span class="sr-only"><spring:message code="button.close"/></span></button>
            <h3 class="modal-title">_label.details</h3>
            <small class="explanation">_label.modal.proposals.details</small>
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
              <a data-base-url="${pageContext.request.contextPath}/admin-external-invite/confirmInvite/" href="" class="btn btn-success" id='accept-btn'><spring:message code='button.accept'/></a>
              <a data-base-url="${pageContext.request.contextPath}/admin-external-invite/rejectInvite/" href="" class="btn btn-danger" id='reject-btn'><spring:message code='button.reject'/></a>
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

          debugger;

          var oid = e.data('oid')

          var acceptBtn = $('#accept-btn')
          $(acceptBtn).attr('href', $(acceptBtn).data('base-url') + oid)
          var rejectBtn = $('#reject-btn')
          $(rejectBtn).attr('href', $(rejectBtn).data('base-url') + oid)

          $('#modal').modal('show');
        });
      })
    </script>
  </div>

  <div role="tabpanel" class="tab-pane" id="configurations">
    <h4><spring:message code='title.expiration.days'/></h4>

    <dl class="dl-horizontal">
      <dt><spring:message code='title.expiration.days'/></dt>
      <dd>${expirationDays}</dd>
    </dl>

    <br><br>

    <h4><spring:message code='title.reasons'/> (${reasons.size()})</h4>

    <a href="${pageContext.request.contextPath}/admin-external-invite/prepareAddReason" type="button" class="btn btn-primary"><spring:message code='button.create'/></a>

    <c:if test="${empty reasons}">
      <div class="alert alert-warning">
        <p><spring:message code='label.reasons.empty'/></p>
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
                <a href="${pageContext.request.contextPath}/admin-external-invite/deleteReason/${reason.externalId}" class="btn btn-default"><spring:message code='label.delete'/></a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</div>