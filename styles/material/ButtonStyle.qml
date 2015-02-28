/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls.Styles 1.3
import Material 0.1

ButtonStyle {
    background: View {
        id: background

        radius: units.dp(2)

        elevation: {
            var elevation = control.hasOwnProperty("elevation") ? control.elevation : 1

            if (elevation > 0 && (control.focus || mouseArea.currentCircle))
                elevation++;

            return elevation;
        }

        backgroundColor: control.hasOwnProperty("backgroundColor") 
                ? control.backgroundColor
                : elevation > 0 ? "white" : "transparent"

        tintColor: mouseArea.currentCircle || control.focus || control.hovered
                ? Qt.rgba(0,0,0, mouseArea.currentCircle ? 0.1 : elevation > 0 ? 0.03 : 0.05)
                : "transparent"

        Ink {
            id: mouseArea

            anchors.fill: parent
            focused: control.focus && button.context != "dialog"
            focusWidth: parent.width - units.dp(30)
            focusColor: Qt.darker(background.backgroundColor, 1.05)

            Connections {
                target: control.__behavior
                onPressed: mouseArea.onPressed(mouse)
                onCanceled: mouseArea.onCanceled()
                onReleased: mouseArea.onReleased(mouse)
            }
        }
    }
    label: Item {
        implicitHeight: Math.max(units.dp(36), label.height + units.dp(16))
        implicitWidth: control.hasOwnProperty("context") && control.context == "dialog"
                ? Math.max(units.dp(64), label.width + units.dp(16))
                : Math.max(units.dp(88), label.width + units.dp(32))

        Label {
            id: label
            anchors.centerIn: parent
            text: control.text
            style: "button"
            color: control.hasOwnProperty("textColor")
                    ? control.textColor : Theme.light.textColor
        }
    }
}