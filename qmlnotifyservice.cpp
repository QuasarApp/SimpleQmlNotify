#include "notificationservice.h"
#include "qmlnotifyservice.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>

namespace QmlNotificationService {

bool init(QQmlApplicationEngine *engine) {
    auto root = engine->rootContext();
    if (!root)
        return false;

    root->setContextProperty("notificationService", NotificationService::getService());
    return true;
}
}

