#ifndef NOTIFICATIONDATA_H
#define NOTIFICATIONDATA_H
#include <QObject>
#include "notifyservice_global.h"
namespace QmlNotificationService {

/**
 * @brief The NotificationData class view data for NotificationServiceView. This class contains a structure with notification data.

 */
class NOTIFYSERVICESHARED_EXPORT NotificationData
{
    Q_GADGET

public:

    /**
     * @brief The Type enum This enum contatins all available types of the notification messages.
     */
    enum Type {
        /// This is message for general notification.
        Normal,
        /// This is warning notification.
        Warning = 1,
        /// This is critical error notifications.
        Error = 2,
    };

    explicit NotificationData(const QString& title = "",
                              const QString& text = "",
                              const QString& img = "",
                              int type = Type::Normal);

    /**
     * @brief text This method return main text message of a question/notification object.
     * @return plain text of message.
     */
    Q_INVOKABLE QString text() const;

    /**
     * @brief img This method return url to image of a question/notification object.
     * @return url of image.
     */
    Q_INVOKABLE QString img() const;

    /**
     * @brief title This method return title of a question/notification object.
     * @return title of a question/notification object.
     */
    Q_INVOKABLE QString title() const;

    /**
     * @brief type This method return type of the notification message or code of the question.
     * @return type of the notification message or code of the question.
     */
    Q_INVOKABLE int type() const;

    /**
     * @brief isValid This method return true if this object is valid.
     * @return return true if this object is valid.
     */
    Q_INVOKABLE bool isValid() const;

    /**
     * @brief setCode This method sets new code of the question.
     * @param code are new value of the code.
     */
    void setCode(int code);

    bool operator ==(const NotificationData &righ);
    bool operator !=(const NotificationData &righ);

private:
    QString getDefaultImage(const QString &img, const int code);

    QString _text;
    QString _img;
    QString _title;
    int _type;
    QString defImgI;
    QString defImgW;
    QString defImgE;

};
}
#endif // NOTIFICATIONDATA_H
