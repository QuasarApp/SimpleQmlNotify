#ifndef QMLNOTIFYSERVICE_H
#define QMLNOTIFYSERVICE_H
#include "notifyservice_global.h"

#include "notificationservice.h"

class QQmlApplicationEngine;

/**
 * Simple notify service for qml.
 * Use :
 * #include <qmlnotifyservice.h>
 *
 * QmlNotificationService::init();
 * auto service = QmlNotificationService::NotificationService::getService()
 * service->setNotify("title", "text", "UrlOfImage", NotificationData::Normal)
 *
 *
 * in qml :
 *
 *  NotificationServiceView {
        anchors.fill: parent;
    }
 */
namespace QmlNotificationService {
    bool NOTIFYSERVICESHARED_EXPORT init(QQmlApplicationEngine *engine);
}


#endif // QMLNOTIFYSERVICE_H
