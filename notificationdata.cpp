/*
 * Copyright (C) 2018-2023 QuasarApp.
 * Distributed under the lgplv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

#include "notificationdata.h"
namespace QmlNotificationService {

NotificationData::NotificationData(const QString &title,
                                   const QString &text,
                                   const QString &img, int type) {

    _text = text;
    _title = title;
    _img = img;
    _type = type;
}

QString NotificationData::text() const {
    return _text;
}

QString NotificationData::img() const {
    const QString imageSrc = imgSrc();
    if(imageSrc != "")
      return imageSrc;
    else
      return this->getDefaultImage(_type);
}

QString NotificationData::imgSrc() const
{
    return _img;
}

QString NotificationData::title() const {
    return _title;
}

bool NotificationData::operator ==(const NotificationData &righ) {
    return _title == righ._title &&
            _text == righ._text &&
            _img == righ._img &&
            _type == righ._type;
}

bool NotificationData::operator !=(const NotificationData &righ) {
    return !operator==(righ);
}

QString NotificationData::getDefaultImage(const int code) const
{

    const auto notificationType = static_cast<NotificationData::Type>(code);

    switch (notificationType) {
    case NotificationData::Type::Normal:
        return "qrc:/icons/info";
    case NotificationData::Type::Warning:
        return "qrc:/icons/warning";
    case NotificationData::Type::Error:
        return "qrc:/icons/error";
    default:
        return "";
    }
}

int NotificationData::type() const {
    return _type;
}

bool NotificationData::isValid() const {
    return _text.size() || _title.size() || _img.size();
}

void NotificationData::setCode(int code) {
    _type = code;
}
}
