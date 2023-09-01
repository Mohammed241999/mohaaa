import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: "Draggable Analog Clock"

    property int currentHour: new Date().getHours() % 12
    property int currentMinute: new Date().getMinutes()

    Rectangle {
        anchors.fill: parent
        color: "lightgray"

        // Create the clock face
        Item {
            width: 200
            height: 200
            anchors.centerIn: parent

            // Clock circle
            Shape {
                ShapePath {
                    fillColor: "white"
                    strokeColor: "black"
                    strokeWidth: 2
                    startX: 100
                    startY: 100
                    PathArc {
                        x: 100
                        y: 100
                        radiusX: 90
                        radiusY: 90
                        useLargeArc: true
                        direction: PathArc.Clockwise
                    }
                }
            }

            // Hour hand
            Rectangle {
                id: hourHand
                width: 4
                height: 60
                color: "black"
                transformOrigin: Item.Top
                rotation: currentHour * 30 - 90
                anchors.centerIn: parent

                MouseArea {
                    id: hourHandDragArea
                    anchors.fill: parent
                    drag.target: parent

                    onReleased: {
                        // Calculate the new hour based on the rotation angle
                        var angle = (hourHand.rotation + 90) % 360;
                        currentHour = Math.floor(angle / 30);
                    }
                }
            }

            // Minute hand
            Rectangle {
                id: minuteHand
                width: 2
                height: 80
                color: "black"
                transformOrigin: Item.Top
                rotation: currentMinute * 6 - 90
                anchors.centerIn: parent

                MouseArea {
                    id: minuteHandDragArea
                    anchors.fill: parent
                    drag.target: parent

                    onReleased: {
                        // Calculate the new minute based on the rotation angle
                        var angle = (minuteHand.rotation + 90) % 360;
                        currentMinute = Math.floor(angle / 6);
                    }
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            // Update the clock hands every second
            hourHand.rotation = (currentHour * 30) - 90;
            minuteHand.rotation = (currentMinute * 6) - 90;
        }
    }
}
