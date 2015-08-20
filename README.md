# external-users-invite

## Install

* Install FenixEdu External Users Invitation Application
    * External Invites
    * External Invites (admin)
    * External Invites (public) under `Público` folder

## FenixEdu External Users Invitation

### FenixEdu External Users Invitation

* Create a new Invite
* See Incomplete invites and take some action (accept/refuse)
* See finished invites (historic)
* If admin:
    * Manage reasons (will redirect to admin controller)

### FenixEdu External Users Invitation (admin)

* Create a new Reason
* Desactivate Reason (will not be available when creating new invites)
* Delete Reason (if there are no invites using that reason)

### Workflow

* Create new Invite with all fields fulfilled
    * if `other reason`, fill `Other` field
* On submit, a public link will be sent to the invited for filling remaining fields
* The inviter will be able to see completed invites waiting for confirmation on FenixEdu External Users Invitation controller page

## TODO

* Integration with thesis proposals
