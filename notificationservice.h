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
     * @brief Notify This method return data of the last notify message.
     * @return return data of the last notify message.
     */
    NotificationData notify() const;

    /**
     * @brief question This method return data of the last question.
     * @return question data.
     */
    NotificationData question() const;

    /**
     * @brief setNotify This method add new notification message of application.
     * @param notify are message data.
     */
    void setNotify(const NotificationData &notify);

    /**
     * @brief setQuestion This method sets information of the users question.
     * @param question are data of the question.
     * @return return question code. You must be save this code for check ansver of your qestion.
     */
    int setQuestion(const NotificationData& question);

    /**
     * @brief questionComplete This method is main responce method of the users questions.
     * @param accepted are boolean option. Set this option to true if user click on accept button.
     * @param code are automaticly generated code fo the question.
     */
    Q_INVOKABLE void questionComplete(bool accepted, int code = 0);

    /**
     * @brief setNotify This method set new notify message for user. When notify changed on main application windows shows notify message.
     * @param title are title of a notify window.
     * @param text are text value of a notify window.
     * @param img are url to image of a notify window.
     * @param type are code of a notification type. For more information about notification type see the NotificationData enum.
     */
    Q_INVOKABLE void setNotify(const QString& title = "",
                       const QString& text = "",
                       const QString& img = "",
                       int type = NotificationData::Normal);

    /**
     * @brief setQuestion This method set new question for user. When question changed on main application windows shows question.
     * @param title are title of a question window.
     * @param text are text value of a question window.
     * @param img are url to image of a queston window.
     * @param code are code of question. This code must be sendet to the questionComplete method after buttons clik.
     */
    Q_INVOKABLE void setQuestion(const QString& title = "",
                       const QString& text = "",
                       const QString& img = "",
                       int code = 0);


    /**
     * @brief getService This method return instance to notify service.
     * @return pointer to the notification service.
     */
    static NotificationService* getService();

    /**
     * @brief history - This method used for return notify list.
     * @return list of all notify.
     */
    const QList<NotificationData> & history() const;

signals:
    /**
     * @brief notifyChanged This signal emited whet the notificator (Ths object) received a new notification message.
     */
    void notifyChanged();

    /**
     * @brief questionChanged This signal emited whet the notificator (Ths object) received a new question message.
     */
    void questionChanged();

    /**
     * @brief questionCompleted This signal emited when youser clcik any buttons on question popup.
     * @param accepted are bool option with "true" value if the yesr click to accept button.
     * @param questionCode are automaticly generated code of the question.
     *  For more information about code option see the setQuestion method.
     */
    void questionCompleted(bool accepted, int questionCode);

private:
    explicit NotificationService(QObject *ptr = nullptr);

    NotificationData _question;
    NotificationData _notify;
    QList<NotificationData> _history;
};

}

#endif // NOTIFICATIONSERVICE_H
