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

    Q_PROPERTY(int notificationsCount READ getNotificationsCount WRITE setNotificationsCount NOTIFY notificationsCountChanged)

public:
    explicit HistoryNotificationsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    void setHistory(const QmlNotificationService::NotificationData &notificationData);
    Q_INVOKABLE void clearAllHistory();

    Q_INVOKABLE void removeNotificationItemAtIndex(const int index);


signals:
    void dataInserted();

private:
    QList<QmlNotificationService::NotificationData> notificationsList;
    int m_notificationsCount;
};

#endif // HISTORYNOTIFICATIONMODEL_H
