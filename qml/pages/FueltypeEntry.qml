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


Dialog {
    id: addFuelType
    property FuelType fuelType
    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: colum
            width: parent.width

            DialogHeader { title: {
                    if(fuelType != undefined) return qsTr("Modify Fuel Type")
                    else return qsTr("New Fuel Type")
                }
            }

            TextField {
                id: nameinput
                label: qsTr("Name")
                placeholderText: label
                focus: true
                width: parent.width
            }
        }
    }
    canAccept: nameinput.acceptableInput

    onOpened: {
        if(fuelType != undefined)
        {
            nameinput.text = fuelType.name
        }
    }

    onAccepted: {
        if(fuelType == undefined)
        {
            manager.car.addNewFuelType(nameinput.text)
        }
        else
        {
            fuelType.name = nameinput.text
            fuelType.save()
        }
    }
}
