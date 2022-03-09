import QtQuick 2.0
import Felgo 3.0

FlickablePage {

    property var model: ({})

    title: "Film Details"

    flickable.contentWidth: parent.width
    flickable.contentHeight: contentCol.height + contentPadding
    flickable.bottomMargin: contentPadding

    Column {
        id: contentCol
        y: contentPadding
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: contentPadding
        spacing: contentPadding

        AppText {
            text: model.title
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(24)
        }

        AppImage {
            source: model.poster
            width: parent.width < 200 ? parent.width : 200
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        AppText {
            text: model.duration + '  -  ' + model.year
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: model.director.indexOf(",") < 0 ? "Director" : "Directors"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: model.director
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }

        AppText {
            text: model.producer.indexOf(",") < 0 ? "Producer" : "Producers"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: model.producer
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }

        AppText {
            text: model.actors.indexOf(",") < 0 ? "Actor" : "Actors"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: model.actors
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }

        AppText {
            text: "Plot"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: model.synopsis
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }
    }
}
