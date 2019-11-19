#ifndef NOTIFICATIONSERVICE_H
#define NOTIFICATIONSERVICE_H

#include "notificationdata.h"

#include <QObject>

namespace QmlNotificationService {

/**
 * @brief The NotificationService class
 */
class NOTIFYSERVICESHARED_EXPORT NotificationService: public QObject
{
    Q_OBJECT

    Q_PROPERTY(NotificationData notify READ notify NOTIFY notifyChanged)
    Q_PROPERTY(QList<NotificationData> history READ history NOTIFY notifyChanged)

private:
    explicit NotificationService(QObject *ptr = nullptr);

    NotificationData _notify;
    QList<NotificationData> _history;

public:
    /**
     * @brief notify
     * @return notyfyData for qml
     */
    NotificationData notify() const;

    /**
     * @brief setNotify - add new message for application
     * @param notify - message data
     */
    void setNotify(const NotificationData &notify);

    Q_INVOKABLE void setNotify(const QString& title = "",
                       const QString& text = "",
                       const QString& img = "",
                       int type = NotificationData::Normal);

    /**
     * @brief getService
     * @return pointer t oservice
     */
    static NotificationService* getService();

    /**
     * @brief history
     * @return list of all notify
     */
    const QList<NotificationData> & history() const;

signals:
    void notifyChanged();
};

}

#endif // NOTIFICATIONSERVICE_H
