#include "notificationservice.h"
#include "qmlnotifyservice.h"

#include <QQmlApplicationEngine>
#include <QQmlContext>

namespace QmlNotificationService {

bool init(QQmlApplicationEngine *engine) {
    if (!engine)
        return false;

    auto root = engine->rootContext();
    if (!root)
        return false;

    engine->addImportPath(":/");

    root->setContextProperty("notificationService", NotificationService::getService());
    return true;
}
}

