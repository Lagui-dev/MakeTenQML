include(../MakeTenQML.pri)
include (models/models.pri)

QT       += quick qml


TEMPLATE = app
win32 {
	TARGET   = $$IDE_APP_TARGET
}
DESTDIR  = $$IDE_APP_PATH
VERSION  = $$APP_VERSION


SOURCES += \
    main.cpp \
    maketenglobal.cpp

HEADERS += \
    maketenglobal.h


RESOURCES += \
    app.qrc

win32 {
    RC_FILE = app.rc
}
macx {
    ICON = icons/logo_128x128.icns
}

FORMS +=

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

contains(ANDROID_TARGET_ARCH,arm64-v8a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}
