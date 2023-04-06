#include "historynotificationsmodel.h"
#include <QDebug>
HistoryNotificationsModel::HistoryNotificationsModel(QObject *parent)
    : QAbstractListModel{parent} {
}

int HistoryNotificationsModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return notificationsList.count();
}

QVariant HistoryNotificationsModel::data(const QModelIndex &index, int role) const {
    if(index.row() < 0 || index.row() >= notificationsList.count())
        return QVariant();

    switch (role) {
    case Icon:
        return notificationsList.at(index.row()).img();
    case Title:
        return notificationsList.at(index.row()).title();
    case Message:
        return notificationsList.at(index.row()).text();
    case Type:
        return notificationsList.at(index.row()).type();
    default:
        break;
    }
    return QVariant();
}

QHash<int, QByteArray> HistoryNotificationsModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Icon]    = "icon";
    roles[Title]   = "title";
    roles[Message] = "text";
    roles[Type]    = "type";
    return roles;
}


void HistoryNotificationsModel::setHistory(const QmlNotificationService::NotificationData &notificationData) {
    beginResetModel();
    notificationsList.push_back(notificationData);
    endResetModel();
}

void HistoryNotificationsModel::clearAllHistory() {
    beginResetModel();
    notificationsList.clear();
    endResetModel();
}

void HistoryNotificationsModel::removeNotificationItemAtIndex(const int elementIndex) {
    beginResetModel();
    notificationsList.removeAt(elementIndex);
    endResetModel();
}

