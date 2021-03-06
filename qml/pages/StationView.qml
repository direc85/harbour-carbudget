/**
 * CarBudget, Sailfish application to manage car cost
 *
 * Copyright (C) 2014 Fabien Proriol
 *
 * This file is part of CarBudget.
 *
 * CarBudget is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * CarBudget is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with CarBudget. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors: Fabien Proriol
 */

import QtQuick 2.6
import Sailfish.Silica 1.0
import harbour.carbudget 1.0

Page {
    allowedOrientations: Orientation.All
    SilicaListView {
        PullDownMenu {
            MenuItem {
                text: qsTr("Add new station")
                onClicked: pageStack.push(Qt.resolvedUrl("StationEntry.qml"))
            }
        }

        VerticalScrollDecorator {}

        header: PageHeader {
            title: qsTr("Station List")
        }

        anchors.fill: parent
        leftMargin: Theme.paddingMedium
        rightMargin: Theme.paddingMedium
        model: manager.car.stations

        delegate: ListItem {
            width: parent.width
            showMenuOnPressAndHold: true

            menu: ContextMenu {
               MenuItem {
                   enabled: model.modelData.id > 0 ? true:false
                   text: qsTr("Modify")
                   onClicked: pageStack.push(Qt.resolvedUrl("StationEntry.qml"), { station: model.modelData })
                }

                MenuItem {
                    enabled: model.modelData.id > 0 ? true:false
                    text: qsTr("Delete")
                    onClicked: {
                        remorseAction(qsTr("Deleting"), function() {
                            manager.car.delStation(model.modelData)
                        })
                    }
                }
            }

            Column {
                width: parent.width
                Row {
                    width: parent.width
                    MenuItem {
                        id: stationName
                        x: Theme.paddingMedium
                        width: parent.width * 2.0 / 3.0 - Theme.horizontalPageMargin
                        text: model.modelData.name;
                        horizontalAlignment: Text.AlignLeft
                    }

                    MenuItem {
                        id: stationLitres
                        text: Math.round(model.modelData.quantity) + "l";
                        width: parent.width * 1.0 / 3.0 - Theme.horizontalPageMargin
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
        }
    }
}
