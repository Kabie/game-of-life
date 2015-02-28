import QtQuick 2.4
import QtQuick.Controls 1.3

import "game.js" as Js

ApplicationWindow {
  id: gameWindow
  title: "Game of Life"
  property int cell_x: 60
  property int cell_y: 40
  property int cell_width: 20
  property var game

  width:cell_x*cell_width; height:cell_y*cell_width
  minimumWidth:this.width; minimumHeight:this.height
  maximumWidth:this.width; maximumHeight:this.height

  Grid {
    id: board
    rows: cell_y
    columns: cell_x
    anchors.fill: parent

    Repeater {
      id: cells
      model: cell_x * cell_y

      Rectangle {
        id: cell
        property bool isAlive: Math.random() > 0.8
        property real r: Math.random()
        property real g: Math.random()
        property real b: Math.random()
        property var neighbors: []
        property var numberOfAliveNeighbors: 0

        width: cell_width
        height: cell_width
        color: isAlive ? Qt.rgba(r, g, b, 1.0) : "transparent"
        border.width: 1
        border.color: "#80ffffff"

        Text {
          anchors.centerIn: parent
          text: numberOfAliveNeighbors
        }

        MouseArea {
          anchors.fill: parent
          hoverEnabled: false
          onClicked: {
            r = Math.random()
            g = Math.random()
            b = Math.random()
            isAlive = !isAlive
          }
        }
      }
    }
  }

  Component.onCompleted: {
    game = new Js.Game(cells, cell_x, cell_y)
  }

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: game.iterate()
  }
}
