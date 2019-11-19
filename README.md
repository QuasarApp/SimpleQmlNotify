# SimpleQmlNotify
Simple Qml notification service for qml applications.

## Use

### CPP
``` cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();
     service->setNotify("title", "text", "UrlOfImage", NotificationData::Normal);
 }


```

### QML

``` qml

 NotificationServiceView {
     anchors.fill: parent;
 }

```
