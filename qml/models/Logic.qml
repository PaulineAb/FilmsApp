import QtQuick 2.0
import Felgo 3.0

Item {

    signal login(string login, string password)

    signal searchListOfMovies()

    signal search(string search_word)

    signal searchDetails(string movieID)

    signal addMovieToMyList(string title, string poster, string duration, string year,
                            string director, string producer, string actors, string synopsis)

}
