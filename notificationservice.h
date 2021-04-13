#ifndef NOTIFICATIONSERVICE_H
#define NOTIFICATIONSERVICE_H

#include "notificationdata.h"

#include <QObject>

namespace QmlNotificationService {

/**
 * @brief The NotificationService class. This class used for working with notify.
 */
class NOTIFYSERVICESHARED_EXPORT NotificationService: public QObject
{
    Q_OBJECT

    Q_PROPERTY(NotificationData notify READ notify NOTIFY notifyChanged)
    Q_PROPERTY(NotificationData question READ question NOTIFY questionChanged)

    Q_PROPERTY(QList<NotificationData> history READ history NOTIFY notifyChanged)

public:
    /**
     * @brief Notify.
     * @return notyfyData for qml.
     */
    NotificationData notify() const;
    NotificationData question() const;

    /**
     * @brief setNotify - Add new message for application.
     * @param notify - Message data.
     */
    void setNotify(const NotificationData &notify);

    void setQuestion(const NotificationData& question);
    Q_INVOKABLE void questionComplete(bool accepted, int code = 0);

    Q_INVOKABLE void setNotify(const QString& title = "",
                       const QString& text = "",
                       const QString& img = "",
                       int type = NotificationData::Normal);

    Q_INVOKABLE void setQuestion(const QString& title = "",
                       const QString& text = "",
                       const QString& img = "",
                       int code = 0);


    /**
     * @brief getService - This method return instance to notify service. 
     * @return pointer to service.
     */
    static NotificationService* getService();

    /**
     * @brief history - This method used for return notify list.
     * @return list of all notify.
     */
    const QList<NotificationData> & history() const;

signals:
    void notifyChanged();
    void questionChanged();
    void questionCompleted(bool accepted, int questionCode);

private:
    explicit NotificationService(QObject *ptr = nullptr);

    NotificationData _question;
    NotificationData _notify;
    QList<NotificationData> _history;
};

}

#endif // NOTIFICATIONSERVICE_H
