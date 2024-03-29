/*
 * Copyright (C) 2018-2024 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

#include "notificationservice.h"

namespace QmlNotificationService {

NotificationService::NotificationService(QObject * ptr): QObject (ptr) {
    qRegisterMetaType<NotificationData>("NotificationData");
    qRegisterMetaType<QList<NotificationData>> ("QList<NotificationData>");
    _history = new HistoryNotificationsModel();
    QQmlEngine::setObjectOwnership(_history, QQmlEngine::CppOwnership);

    connect(_history, &HistoryNotificationsModel::rowsInserted, this, &NotificationService::countNotificationsChanged);
    connect(_history, &HistoryNotificationsModel::rowsRemoved, this, &NotificationService::countNotificationsChanged);
    connect(_history, &HistoryNotificationsModel::modelReset, this, &NotificationService::countNotificationsChanged);
}

NotificationService::~NotificationService() {
    delete _history;
}

NotificationData NotificationService::notify() const {
    return _notify;
}

NotificationData NotificationService::question() const {
    return _question;
}

void NotificationService::setNotify(const NotificationData& notify) {
    if (_notify != notify) {
        _history->addHistoryObject(notify);
    }
    _notify = notify;

    emit notifyChanged();
}

int NotificationService::setQuestion(const Listner& listner, const NotificationData &question) {

    _question = question;
    int questionCode = rand();
    _question.setCode(questionCode);
    emit questionChanged();

    _listners[questionCode] = listner;

    return _question.type();
}

void NotificationService::questionComplete(bool accepted, int code) {

    if (_listners.contains(code)) {
        auto listner = _listners.value(code);
        listner(accepted);
        _listners.remove(code);
    }

    emit questionCompleted(accepted, code);
}

void NotificationService::setNotify(const QString &title,
                                    const QString &text,
                                    const QString &img,
                                    int type) {

    setNotify(NotificationData(title, text, img,
                               static_cast<NotificationData::Type>(type)));
}

int NotificationService::setQuestion(QObject *listnerObject,
                                     const QString &listnerMethod,
                                     const QString &title,
                                     const QString &text,
                                     const QString &img,
                                     int code) {

    Listner listner = [listnerObject, listnerMethod](bool accept) {

        const QByteArray stringData = listnerMethod.toLatin1();
        char method[100];
        method[qMin(99, stringData.size())] = '\0';
        std::copy(stringData.constBegin(), stringData.constBegin() + qMin(99, stringData.size()), method);

        QMetaObject::invokeMethod(listnerObject, method,
                                  Qt::QueuedConnection, Q_ARG(bool, accept));
    };

    return setQuestion(listner, NotificationData(title, text, img, code));
}

int NotificationService::setQuestion(const Listner& listner,
                                     const QString &title,
                                     const QString &text,
                                     const QString &img,
                                     int code) {

    return setQuestion(listner, NotificationData(title, text, img, code));
}

QString NotificationService::libVersion() {
    return QML_NOTIFY_VERSION;
}

NotificationService *NotificationService::getService() {
    static auto service = new NotificationService;
    return service;
}

QObject *NotificationService::history() const {
    return _history;
}

void NotificationService::showHistory() {
    emit sigShowHistory();
}

int NotificationService::notificationsCount() const {
    return  _history->rowCount({});
}

}
