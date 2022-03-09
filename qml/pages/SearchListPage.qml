import QtQuick 2.0
import Felgo 3.0

ListPage {

    id: listView

    title: "Search Result"

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            id: loading
            visible: false
        }
    }

    emptyText.text: "No film found."

    model: JsonListModel {
        id: listModel
        source: dataModel.searchResult
        fields: [ "text", "detailText", "image", "model" ]
    }

    delegate: SimpleRow {
        item: listModel.get(index)
        autoSizeImage: true
        imageMaxSize: dp(40)
        image.fillMode: Image.PreserveAspectCrop
        onSelected: searchDetails(item.model.movieID)
    }

    Connections {
        target: dataModel
        onSearchDetailsResultReceived: displaySearchDetails()
    }

    Component {
        id: searchDetailsComponent
        SearchDetailPage { }
    }

    function searchDetails(movieID) {
        if (loading.visible === false) {
            loading.visible = true
            logic.searchDetails(movieID)
        }
    }

    function displaySearchDetails() {
        loading.visible = false
        navigationStack.push(searchDetailsComponent)
    }
}
