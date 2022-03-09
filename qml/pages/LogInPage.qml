import QtQuick 2.0
import Felgo 3.0

Page {

    title: "Log in"

    rightBarItem: NavigationBarRow {
        ActivityIndicatorBarItem {
            id: loading
            visible: false
        }
    }

    Column {
        id: contentCol
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: contentPadding
        spacing: contentPadding


        AppTextField {
            id: loginInput
            width: parent.width
            showClearButton: true
            placeholderText: "Login"
            inputMethodHints: Qt.ImhNoPredictiveText
        }

        AppTextField {
            id: passwordInput
            width: parent.width
            inputMode: inputModePassword
            placeholderText: "Password"
            inputMethodHints: Qt.ImhNoPredictiveText
        }


        AppButton {
            id: logInButton
            text: "Log in"
            onClicked: logIn()
        }


        AppText {
            id: error
            visible: false
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: sp(12)
            color: "red"
            text: "Login or password is incorrect"
        }
    }

    Connections {
        target: dataModel
        onMovieListReceived: goToMoviesList()
        onLoginIsNotValid: displayError()
    }

    Component {
        id: listPageComponent
        MoviesListPage {}
    }

    function goToMoviesList() {
        logInButton.enabled = true
        loading.visible = false
        error.visible = false
        loginInput.text = ""
        passwordInput.text = ""
        if(navigationStack.depth === 1) {
            navigationStack.push(listPageComponent)
        }
    }

    function logIn () {
        logInButton.enabled = false
        loading.visible = true
        error.visible = false
        logic.login(loginInput.text, passwordInput.text)
    }

    function displayError() {
        logInButton.enabled = true
        error.visible = true
        loading.visible = false
    }
}
