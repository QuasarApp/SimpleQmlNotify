#ifndef HISTORYNOTIFICATIONMODEL_H
#define HISTORYNOTIFICATIONMODEL_H

#include <QAbstractListModel>
#include "notificationdata.h"

class HistoryNotificationsModel : public QAbstractListModel
{
    Q_OBJECT

    enum Roles {
        Icon = Qt::UserRole + 1,
        Title,
        Message,
        Type
    };

public:
    explicit HistoryNotificationsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    void addHistoryObject(const QmlNotificationService::NotificationData &notificationData);
    void setHistory(const QList<QmlNotificationService::NotificationData> &historyList);
    Q_INVOKABLE void clearAllHistory();
    Q_INVOKABLE void removeNotificationItemAtIndex(const int index);

private:
    QList<QmlNotificationService::NotificationData> notificationsList;
};

#endif // HISTORYNOTIFICATIONMODEL_H
