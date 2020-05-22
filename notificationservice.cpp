/*
 * Copyright (C) 2018-2020 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

#include "notificationservice.h"
namespace QmlNotificationService {

NotificationService::NotificationService(QObject * ptr): QObject (ptr) {
    qRegisterMetaType<NotificationData>("NotificationData");
    qRegisterMetaType<QList<NotificationData>> ("QList<NotificationData>");

}

NotificationData NotificationService::notify() const {
    return _notify;
}

void NotificationService::setNotify(const NotificationData& notify) {
    if (_notify != notify)
        _history.push_back(_notify);

    _notify = notify;

    emit notifyChanged();
}

void NotificationService::setNotify(const QString &title,
                                    const QString &text,
                                    const QString &img,
                                    int type) {

    setNotify(NotificationData(title, text, img,
                               static_cast<NotificationData::Type>(type)));
}

NotificationService *NotificationService::getService() {
    static auto service = new NotificationService;
    return service;
}

const QList<NotificationData> &NotificationService::history() const {
    return _history;
}

}
