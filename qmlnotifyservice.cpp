/*
 * Copyright (C) 2018-2023 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

#include "notificationservice.h"
#include "qmlnotifyservice.h"
#include "historynotificationsmodel.h"

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
    QPointer<HistoryNotificationsModel> historyModel = new HistoryNotificationsModel();

    engine->addImportPath(":/");

    root->setContextProperty("notificationService", NotificationService::getService());
    root->setContextProperty("historyNotificationsModel", historyModel);
    return true;
}
}

