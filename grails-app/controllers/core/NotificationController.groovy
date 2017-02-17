package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_COLLABORATOR'])
class NotificationController {

    def springSecurityService

    def getNotifications() {
        User currentuser = springSecurityService.loadCurrentUser()
        List<Notification> notifications = Notification
                .where { username == currentuser.username && wasRead == 0 }
                .list(sort: 'id', order: 'desc', max: 5);
        if (notifications.size() < 5) {
            Integer newSize = 5 - notifications.size()
            List<Notification> notificationsAlreadyRead = Notification
                    .where { username == currentuser.username && wasRead == 1 }
                    .list(sort: 'id', order: 'desc', max: newSize);
            notifications.addAll(notificationsAlreadyRead)
        }
        render notifications.sort { [it.id] }.reverse() as JSON
    }

    def setLastNotificationsAsRead() {
        User currentuser = springSecurityService.loadCurrentUser()
        List<Notification> notifications = Notification
                .where { username == currentuser.username }
                .list(sort: 'id', order: 'desc');
        notifications.each { n ->
            n.wasRead = 1
            n.save(flush: true)
        }
        render notifications as JSON
    }
}
