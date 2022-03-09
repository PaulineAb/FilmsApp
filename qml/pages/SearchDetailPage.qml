import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 2.1

FlickablePage {

    property var model: ({})

    title: "Film Details"

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            id: loading
            visible: false
        }
        IconButtonBarItem {
            id: heart
            icon: IconType.hearto
            title: "Add to my list"
            onClicked: addToMyList()
        }
    }

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
            text: dataModel.searchDetailResult[0].title
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(24)
        }

        AppImage {
            source: dataModel.searchDetailResult[0]['full-size cover url']
            width: parent.width < 200 ? parent.width : 200
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        AppText {
            text: getMovieTime(dataModel.searchDetailResult[0].runtimes[0]) + '  -  ' + dataModel.searchDetailResult[0].year
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: dataModel.searchDetailResult[0].director.length === 1 ? "Director" : "Directors"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: getStringList(dataModel.searchDetailResult[0].director)
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }

        AppText {
            text: dataModel.searchDetailResult[0].producer.length === 1 ? "Producer" : "Producers"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: getStringList(dataModel.searchDetailResult[0].producer)
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }

        AppText {
            text: dataModel.searchDetailResult[0].cast.length === 1 ? "Actor" : "Actors"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(16)
        }

        AppText {
            text: getStringList(dataModel.searchDetailResult[0].cast)
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
            text: dataModel.searchDetailResult[0].plot[0]
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(14)
        }
    }

    Popup {
        id: popup
        visible: false
        width: 125
        height: 35
        x: Math.round((parent.width - width) / 2)
        y: 100
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            border.color: "#FFF"
            radius: 5
        }

        AppText {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Film added to your list"
            width: parent.width
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
        }
    }

    Connections {
        target: dataModel
        onMovieAdded: movieAdded()
        onMovieNotAdded: movieNotAdded()
    }

    function getMovieTime(time) {
        var minutes = time % 60
        var hours = (time - minutes) / 60
        return hours + "h " + minutes + "min"
    }

    function addToMyList() {
        loading.visible = true
        logic.addMovieToMyList(
                    dataModel.searchDetailResult[0].title,
                    dataModel.searchDetailResult[0]['full-size cover url'],
                    getMovieTime(dataModel.searchDetailResult[0].runtimes[0]),
                    dataModel.searchDetailResult[0].year,
                    getList(dataModel.searchDetailResult[0].director),
                    getList(dataModel.searchDetailResult[0].producer),
                    getList(dataModel.searchDetailResult[0].cast),
                    dataModel.searchDetailResult[0].plot[0]
                    )
    }

    function getList(data) {
        var tab = []
        for (var i in data)  {
            if(i === '0') tab.push(data[i].name)
            else tab.push(' ' + data[i].name)
        }
        return tab
    }

    function getStringList(data) {
        var tab = ''
        for (var i in data)  {
            if(i === '0') tab = data[i].name
            else tab = tab + ', ' + data[i].name
        }
        return tab
    }

    function movieAdded() {
        heart.icon = IconType.heart
        heart.enabled = false
        loading.visible = false
        popup.visible = true
    }

    function movieNotAdded() {
        loading.visible = false
    }

}
