#ifndef QMLNOTIFYSERVICE_H
#define QMLNOTIFYSERVICE_H
#include "notifyservice_global.h"

#include "notificationservice.h"

class QQmlApplicationEngine;

/**
 * Simple notify service for qml.
 * Use :
 * @code cpp 
 * #include <qmlnotifyservice.h>
 * QmlNotificationService::init();
 * auto service = QmlNotificationService::NotificationService::getService()
 * service->setNotify("title", "text", "UrlOfImage", NotificationData::Normal)
 * @endcode 
 *
 * in qml :
 * @code qml 
 *  NotificationServiceView {
        anchors.fill: parent;
    }
 * @endcode
 * Questions
 * CPP
 * @code cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();
     int questionCode = service->setQuestion("title", "some text");

     QObject::connect(service, QmlNotificationService::NotificationService::questionCompleted,
                     [questionCode](bool accepted, int questionCode) {
                         if (accepted && code === questionCode) {
                            // your action here. 
                         }
                     })

     
 }
 * @endcode
 * QML
 * @code qml
  NotificationServiceView {
     anchors.fill: parent;
 }
 
readonly property int questionCode: 0;

questionCode = notificationService.setQuestion(qsTr("Remove %0 user").arg(userModel.userId),
                                qsTr("All saved data and records will be delete, Do you want continuee?"))
Connections {
    target: notificationService
    function onQuestionCompleted(accepted, code) {
        if (accepted && code === privateRoot.questionCode) {
            if (userModel)
                backEnd.removeUser(userModel.userId)
        }
    }
}
 * @endcode   
 */
namespace QmlNotificationService {
    bool NOTIFYSERVICESHARED_EXPORT init(QQmlApplicationEngine *engine);
}


#endif // QMLNOTIFYSERVICE_H
