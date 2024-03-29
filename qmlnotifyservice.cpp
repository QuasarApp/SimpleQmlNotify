/*
 * Copyright (C) 2018-2024 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

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

    initSNotufyResources();

    engine->addImportPath(":/");

    root->setContextProperty("notificationService", NotificationService::getService());
    return true;
}
}

