import QtQuick 2.0
import Felgo 3.0

ListPage {

    id: searchListPage
    title: "Search a film"

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            id: loading
            visible: false
        }
    }

    SearchBar {
        id: searchBar
        showClearButton: true
        anchors.left: parent.left
        anchors.right: searchButton.left
        onAccepted: {
            searchText(text)
        }
    }

    AppButton {
        id: searchButton
        icon: IconType.search
        anchors.right: parent.right
        minimumWidth: 50
        onClicked: searchText(searchBar.text)
    }

    Connections {
        target: dataModel
        onSearchResultListReceived: goToSearchList()
    }

    Component {
        id: searchListComponent
        SearchListPage { }
    }

    function searchText(text) {
        if (text !== '') {
            searchBar.enabled = false
            searchButton.enabled = false
            loading.visible = true
            logic.search(text)
        }
    }

    function goToSearchList() {
        searchBar.enabled = true
        searchButton.enabled = true
        loading.visible = false
        searchBar.text = ""
        navigationStack.push(searchListComponent)
    }
}
