import QtQuick 2.0
import Felgo 3.0

ListPage {

    id: moviesListPage
    title: "List of films"

    rightBarItem: NavigationBarRow {
        IconButtonBarItem {
            icon: IconType.search
            onClicked: navigationStack.push(searchComponent)
            title: "Search a film"
        }
    }

    model: JsonListModel {
        id: listModel
        source: dataModel.moviesList
        fields: [ "text", "detailText", "image", "model" ]
    }

    emptyText.text: "No film in your list."

    delegate: SimpleRow {
        item: listModel.get(index)
        autoSizeImage: true
        imageMaxSize: dp(50)
        image.fillMode: Image.PreserveAspectCrop
        onSelected: navigationStack.push(movieDetailComponent, {model: item.model})
    }

    Component {
        id: movieDetailComponent
        MovieDetailPage { }
    }

    Component {
        id: searchComponent
        SearchMoviePage { }
    }

    function getMovieList() {
        logic.searchListOfMovies()
    }
}
