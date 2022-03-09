import QtQuick 2.0
import Felgo 3.0

Item {

    readonly property bool loading: HttpNetworkActivityIndicator.enabled

    Component.onCompleted: {
        HttpNetworkActivityIndicator.activationDelay = 0
    }

    function login(login, password, callback) {
        _.isLoginValid(login, password, callback)
    }

    function getMovieList(user_id, callback) {
        _.sendRequest(user_id, callback)
    }

    function search(search_word, callback) {
        _.search(search_word, callback)
    }

    function searchDetails(movieID, callback) {
        _.searchDetails(movieID, callback)
    }

    function addMovie(title, poster, duration, year,
                      director, producer, actors, synopsis, loggedId, callback) {
        _.addMovie(title, poster, duration, year,
                   director, producer, actors, synopsis,loggedId, callback)
    }

    Item {
        id: _

        function isLoginValid(login, password, callback) {
            HttpRequest.get("http://127.0.0.1:8000/user?login=" + login + "&password=" + password)
            .then(function(res) {
                var content = res.text
                try {
                    var obj = JSON.parse(content)
                } catch(ex) {
                    console.error("Could not parse server response as JSON:", ex)
                    return
                }
                console.debug("Successfully parsed JSON response")
                callback(obj)
            })
            .catch(function(err) {
            })
        }

        function sendRequest(user_id, callback) {
            HttpRequest.get("http://127.0.0.1:8000/films?userlist=" + user_id)
            .then(function(res) {
                var content = res.text
                try {
                    var obj = JSON.parse(content)
                } catch(ex) {
                    console.error("Could not parse server response as JSON:", ex)
                    return
                }
                console.debug("Successfully parsed JSON response")
                callback(obj)
            })
            .catch(function(err) {
            })
        }

        function search(search_word, callback) {
            HttpRequest.get("http://127.0.0.1:8000/search?searchword=" + search_word)
            .then(function(res) {
                var content = res.text
                try {
                    var obj = JSON.parse(content)
                } catch(ex) {
                    console.error("Could not parse server response as JSON:", ex)
                    return
                }
                console.debug("Successfully parsed JSON response")
                callback(obj)
            })
            .catch(function(err) {
            })
        }

        function searchDetails(movieID, callback) {
            HttpRequest.get("http://127.0.0.1:8000/searchdetails?movieid=" + movieID)
            .then(function(res) {
                var content = res.text
                try {
                    var obj = JSON.parse(content)
                } catch(ex) {
                    console.error("Could not parse server response as JSON:", ex)
                    return
                }
                console.debug("Successfully parsed JSON response")
                callback(obj)
            })
            .catch(function(err) {
            })
        }

        function addMovie(title, poster, duration, year,
                          director, producer, actors, synopsis, userlist, callback) {
            var data = {
                title: title,
                poster: poster,
                duration: duration,
                year: year,
                director: director,
                producer: producer,
                actors: actors,
                synopsis: synopsis,
                userlist: userlist
            }

            HttpRequest
            .post("http://127.0.0.1:8000/addfilm/", data)
            .set('Content-Type', 'application/json')
            .then(function(res) {
                var content = res.text
                try {
                    var obj = JSON.parse(content)
                } catch(ex) {
                    console.error("Could not parse server response as JSON:", ex)
                    return
                }
                console.debug("Successfully parsed JSON response")
                callback(obj)
            })
            .catch(function(err) {
                console.error("ERROR: "+ err)
            })
        }
    }
}
