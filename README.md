# SimpleQmlNotify
Simple Qml notification service for qml applications.

## Include

### For qmake projects 

 * cd yourRepo
 * git submodule add https://github.com/QuasarApp/SimpleQmlNotify.git # add the repository of QSimpleQmlNotify into your repo like submodule
 * git submodule update --init --recursive
 * Include in your pro file the pri file of Qt-Secret library
  ```qmake
    include($$PWD/SimpleQmlNotify/QmlNotify.pri)
  ```
 * Rebuild yuor project

### For cmake projects
#### The cmake build do not required Qt libraries. 
 
 * cd yourRepo
 * git submodule add https://github.com/QuasarApp/SimpleQmlNotify.git # add the repository of QSimpleQmlNotify into your repo like submodule
 * git submodule update --init --recursive
 * Include in your CMakeLists.txt file the main CMakeLists.txt file of QSimpleQmlNotify library
  ```cmake
    include(QmlNotyfyService)
  ```
 * Rebuild yuor project



### For other build system
 
 * cd yourRepo
 * git submodule add https://github.com/QuasarApp/SimpleQmlNotify.git # add the repository of QSimpleQmlNotify into your repo like submodule
 * git submodule update --init --recursive
 * Add the rule for build QmlNotyfyService
 * Add INCLUDEPATH and LIBS for your build system 
 * Rebuild yuor project


## Using

### Notification

#### CPP
```cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();
     service->setNotify("title", "text", "UrlOfImage", NotificationData::Normal);
 }


```

#### QML

```qml
 import NotifyModule 1.0

 NotificationServiceView {
     anchors.fill: parent;
 }

```

### Questions


#### CPP
```cpp
 #include <qmlnotifyservice.h>

 int main() {
     QmlNotificationService::init();
     auto service = QmlNotificationService::NotificationService::getService();

     QmlNotificationService::Listner listner = [] (bool accepted) {
                            // your action here.
     };

     service->setQuestion(listner, "title", "some text");

     
 }


```

#### QML

```qml
 import NotifyModule 1.0
 
 NotificationServiceView {
     anchors.fill: parent;
 }
 
 Item {
 
     notificationService.setQuestion(this, "onQuestionCompleted", qsTr("Remove %0 user").arg(userModel.userId),
                                qsTr("All saved data and records will be delete, Do you want continuee?"));
                                
     function onQuestionCompleted(accepted) {
        // your action here.   
     }
 }

```
### Include translations

For include translations into your projects you need to use the QuasarAppUtils::Locales class. See oficiald [documentation](https://quasarapp.ddns.net:3031/docs/QuasarApp/QuasarAppLib/latest/classQuasarAppUtils_1_1Locales.html)

```cpp
if(!QuasarAppUtils::Locales::init(locale, {":/qmlNotify_languages/"})) {
    QuasarAppUtils::Params::log("Error load language : " , QuasarAppUtils::Error);
}
```

Or you can manually load needed qm file.
All qm files located in qmlNotify_languages folder.
