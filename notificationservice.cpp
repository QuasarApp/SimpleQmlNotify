/*
 * Copyright (C) 2018-2021 QuasarApp.
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

NotificationData NotificationService::question() const {
    return _question;
}

void NotificationService::setNotify(const NotificationData& notify) {
    if (_notify != notify)
        _history.push_back(_notify);

    _notify = notify;

    emit notifyChanged();
}

int NotificationService::setQuestion(const NotificationData &question) {

    _question = question;
    _question.setCode(rand() % std::numeric_limits<int>().max());
    emit questionChanged();

    return _question.type();
}

void NotificationService::questionComplete(bool accepted, int code) {
    emit questionCompleted(accepted, code);
}

void NotificationService::setNotify(const QString &title,
                                    const QString &text,
                                    const QString &img,
                                    int type) {

    setNotify(NotificationData(title, text, img,
                               static_cast<NotificationData::Type>(type)));
}

int NotificationService::setQuestion(const QString &title, const QString &text, const QString &img, int code) {
    return setQuestion(NotificationData(title, text, img, code));
}

NotificationService *NotificationService::getService() {
    static auto service = new NotificationService;
    return service;
}

const QList<NotificationData> &NotificationService::history() const {
    return _history;
}

}
