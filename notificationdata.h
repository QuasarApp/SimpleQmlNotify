#ifndef NOTIFICATIONDATA_H
#define NOTIFICATIONDATA_H
#include <QObject>
#include "notifyservice_global.h"
namespace QmlNotificationService {

/**
 * @brief The NotificationData class view data for NotificationServiceView
 */
class NOTIFYSERVICESHARED_EXPORT NotificationData
{
    Q_GADGET
    Q_PROPERTY(QString text READ text)
    Q_PROPERTY(QString img READ img)
    Q_PROPERTY(QString title READ title)
    Q_PROPERTY(int type READ type)

    QString _text;
    QString _img;
    QString _title;
    int _type;

public:

    enum Type {
        Normal,
        Warning = 1,
        Error = 2,
    };

    explicit NotificationData(const QString& title = "",
                              const QString& text = "",
                              const QString& img = "",
                              int type = Type::Normal);

    Q_INVOKABLE QString text() const;
    Q_INVOKABLE QString img() const;
    Q_INVOKABLE QString title() const;
    Q_INVOKABLE int type() const;
    Q_INVOKABLE bool isValid() const;

    bool operator ==(const NotificationData &righ);
    bool operator !=(const NotificationData &righ);

};
}
#endif // NOTIFICATIONDATA_H
