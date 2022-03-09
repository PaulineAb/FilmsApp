import QtQuick 2.0
import Felgo 3.0

Item {

    property alias dispatcher: logicConnection.target
    property var moviesList: _.createFilmListModel(_.moviesList)
    property var searchResult: _.searchListModel()
    property var searchDetailResult: _.searchDetailsModel()
    property var loggedId: null

    signal loginIsNotValid
    signal movieListReceived
    signal searchResultListReceived
    signal searchDetailsResultReceived
    signal movieAdded
    signal movieNotAdded

    Connections {
        id: logicConnection

        onLogin: {
            client.login(login, password, _.loginCallback)
        }
        onSearchListOfMovies: {
            client.getMovieList(_.responseCallback)
        }
        onSearch: {
            client.search(search_word, _.searchCallback)
        }
        onSearchDetails: {
            client.searchDetails(movieID, _.searchDetailsCallback)
        }
        onAddMovieToMyList: {
            client.addMovie(title, poster, duration, year,
                            director, producer, actors, synopsis, loggedId, _.addMovieCallback)
        }
    }

    Client {
        id: client
    }

    Item {
        id: _

        property var moviesList: []
        property var searchResult: []
        property var searchDetailsResult: []

        function loginCallback(obj) {
            if(obj.length === 1) {
                loggedId = obj[0]['id']
                client.getMovieList(obj[0].id, _.responseCallback)
            } else { loginIsNotValid() }
        }

        function responseCallback(obj) {
            var response = obj
            if(moviesList.length > 0) {
                while(moviesList.length > 0) { moviesList.pop() }
            }
            moviesList = moviesList.concat(response)
            movieListReceived()
        }

        function createFilmListModel(test) {
            return test.map(function(data) {
                return {
                    text: data.title,
                    image: data.poster,
                    detailText: data.year,
                    model: data,
                }
            })
        }

        function searchCallback(obj) {
            var response = obj
            searchResult = []
            searchResult = searchResult.concat(response)
            searchResultListReceived()
        }

        function searchListModel() {
            return searchResult.filter(function(data) {
                if(data.kind === "movie")
                return data
            }).map(function(data) {
                return {
                    text: data.title,
                    image: data['full-size cover url'],
                    detailText: data.year,
                    model: data,
                }
            })
        }

        function searchDetailsCallback(obj) {
            var response = obj
            searchDetailsResult = []
            searchDetailsResult = searchDetailsResult.concat(response)
            searchDetailsResultReceived()
        }

        function searchDetailsModel() {
            return searchDetailsResult.map(function(data) {
                return data
            })
        }

        function addMovieCallback(obj) {
            if(obj['id']){
                client.getMovieList(obj['userlist'], _.responseCallback)
                movieAdded()
            } else {
                movieNotAdded()
            }
        }
    }
}
