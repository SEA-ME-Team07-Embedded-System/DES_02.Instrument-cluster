
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QtQuick 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtLocation 5.15
import QtPositioning 5.15

import com.example 1.0


Window {

    property int x_center : 250
    property int x_gap : 30
    id: root
    visible: true //"FullScreen"
    width: 1280
    height: 400
    title: qsTr("Team07 dashboard")

    property bool parkVisible: false
    property bool driveVisible: true
    property string black: "#aa1f1f1f"//"white" //"black"
    property string white: "black"//"white"
    property string side: "#afafaf"//"white"
    property string center_color:"#77393939"//"#737373" // "white

    property int center_width: width
//    property int side_width: (width-center_width)/2

    property date curentTime:new Date()
    property int hour: curentTime.getHours()
    property int minutes: curentTime.getMinutes()
    property int seconds: curentTime.getSeconds()


    ValueSource {
        id: valueSource
    }

//    Rectangle{
//        id:leftScreen
//        anchors{
//            left: parent.left
//            top: parent.top
//            bottom: parent.bottom
//        }
//        width: side_width // parent.width/3.25
//        color: side//side//white

//        Text{
//            id:temperature
//            anchors{
//                left:parent.left
//                leftMargin: 20
//                top:parent.top
//                topMargin: 20
//            }
//            font.pixelSize: 20
//            font.bold: false

//            color:black
//            text:"16°C"
//        }
//    }


    Rectangle{
        id:centerScreen
        anchors{
//            left: centerScreen.left
            top: parent.top
            bottom: parent.bottom
        }
        width: center_width //parent.width/2.5
        color: white //"#d6d6d6"

        Rectangle { //bar
            width: parent.width * .85
            anchors{
                top: centerScreen.top
                topMargin: 95
            }
            anchors.horizontalCenter: parent.horizontalCenter
            height: 2
            color: center_color
        }
        Rectangle { //map
            id:map_main
            visible: true
            width: center_width
            height: 480

            Plugin {
                id: mapPlugin
                name: "mapboxgl" // Mapbox plugin name
                PluginParameter { name: "mapbox.access_token"; value: "file:/home/seame-workstation07/QT/Examples/Qt-5.15.2/quickcontrols/extras/dashboard_new/qml/mapbox/api-key.txt" }
            }

            Map {
                id: map
                anchors.fill: parent
                plugin: mapPlugin
                center: QtPositioning.coordinate(valueSource.lati, valueSource.longi)
                zoomLevel: 17

            tilt:85
            activeMapType: map.supportedMapTypes[0]
            }

            Image{
                id:arrow
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height*0.5
                width: parent.height*0.1
                height: arrow.width
                rotation:180
                source:"qrc:/images/arrow_grey.png"
            }
            MouseArea {
                anchors.fill: map_main
                onClicked: {
                    if (left_view.visible) {
                        left_view.opacity = 0;
                        right_view.opacity = 0;
                        map_gradation.opacity=0;
                        map_gradation_2.visible = true;
                        map_gradation_2.opacity=1;
//                        side= "#afafaf"

                    } else {
                        left_view.visible = true;
                        left_view.opacity = 1;
                        right_view.visible = true;
                        right_view.opacity = 1;
                        map_gradation.visible = true;
                        map_gradation.opacity=1;
                        map_gradation_2.opacity=0;
                    }
                }
            }
        }
        Rectangle{
            id:map_gradation
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 480  //640 480
            height: center_width
            rotation:90
            visible: true
            opacity:1
            Behavior on opacity {
                NumberAnimation {
                    duration: 500  // 1초 동안 애니메이션 진행
                }
            }
            onOpacityChanged: {
                if (opacity == 0) {
                    map_gradation.visible = false;
                }
            }
            gradient: Gradient{
                GradientStop{position: 0.0; color: "#4f4f4f"}
                GradientStop{position: 0.35; color: "#664f4f4f"}
                GradientStop{position: 0.45; color: "#334f4f4f"}
                GradientStop{position: 0.5; color: "#224f4f4f"}
                GradientStop{position: 0.55; color: "#334f4f4f"}
                GradientStop{position: 0.65; color: "#664f4f4f"}
                GradientStop{position: 1.0; color: "#4f4f4f"}
            }
        }
        Rectangle{
            id:map_gradation_2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 480  //640 480
            height: center_width
            rotation:90
            visible: false
            opacity:1
            Behavior on opacity {
                NumberAnimation {
                    duration: 500  // 1초 동안 애니메이션 진행
                }
            }
            onOpacityChanged: {
                if (opacity == 0) {
                    map_gradation_2.visible = false;
                }
            }
            gradient: Gradient{
                GradientStop{position: 0.0; color: side} //"#afafaf"
                GradientStop{position: 0.15; color: "#44afafaf"}
                GradientStop{position: 0.25; color: "#33afafaf"}
                GradientStop{position: 0.5; color: "#11afafaf"}
                GradientStop{position: 0.75; color: "#33afafaf"}
                GradientStop{position: 0.85; color: "#44afafaf"}
                GradientStop{position: 1.0; color: side}
            }
        }
        ///////////////////////Left circle///////////////////////////
        Rectangle{
            id:left_view
            color:"#00000000"
            visible:true
            x:120
//            anchors.fill:centerScreen
//            anchors.fill:left_circle
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1
            Behavior on opacity {
                NumberAnimation {
                    duration: 500  // 1초 동안 애니메이션 진행
                }
            }
            onOpacityChanged: {
                if (opacity == 0) {
                    left_view.visible = false;
                }
            }
            Rectangle{
                id:left_circle
//                x:100
//                y:100
                anchors.verticalCenter: parent.verticalCenter
                width:320
                height:320
                radius:160
                opacity:1
                color:"#77a0ff9e"//"#dfdfdf"
    //            color:"#ffaf00"
            }
            Rectangle{
                id:left_circle_2
                anchors.centerIn: left_circle
                width:left_circle.height*0.98
                height:left_circle.height*0.98
                radius:left_circle.radius*0.98
                opacity:1
                color:"black"
            }

            Rectangle{
                id:left_clockmode
                visible:true
                color:"#00000000"
                opacity: 1
                anchors.fill:left_circle
                anchors.centerIn: left_circle
                Behavior on opacity {
                    NumberAnimation {
                        duration: 500  // 1초 동안 애니메이션 진행
                    }
                }
                onOpacityChanged: {
                    if (opacity == 0) {
                        left_clockmode.visible = false;
                    }
                }
                MouseArea {
                    anchors.fill: left_clockmode
                    onClicked: {
                        if (left_clockmode.visible) {
                            left_clockmode.opacity = 0;  // 애니메이션 시작
                            left_drivemode.visible=true;
                            left_drivemode.opacity=1;
    //                        right_circle.color = "#77dfdfdf"
                        } else {
                            left_clockmode.visible = true;
                            left_clockmode.opacity = 1;  // 애니메이션 시작
                            left_drivemode.visible=false;
                            left_drivemode.opacity=0;
    //                        right_circle.color = "##77a0ff9e" //"#77dfdfdf"
                        }
                    }
                }

                Image{
                    id:clock_minute
                    x: left_circle.x-left_circle.height/22+1.5
                    y: left_circle.y+left_circle.height/2.15
                    width: parent.width*1.07; height: clock_minute.width*1.8
                    source:"qrc:/images/clock_minute2.png"
                }

                Image{
                    id:clock_hour
                    anchors.horizontalCenter: clock_minute.horizontalCenter
                    y:173
                    width: clock_minute.width*0.35;  height: clock_hour.width*1.8
        //            fillMode: Image.PreserveAspectFit
                    source:"qrc:/images/clock_hour2.png"
                }

                Item{
                    id:minuteItem
                    property int value:minutes
                    property int angle_minute: 360/60
                    Image{
                        x:clock_minute.x+clock_minute.width/2+1
                        y:clock_minute.y+clock_minute.width/2//200+14
                        height:clock_minute.width/2.5
                        width: 10
                        antialiasing: true
                        source:"qrc:/images/second.png"
                    }
                    transform: Rotation
                    {
                        origin.x:clock_minute.x+clock_minute.width/2+3
                        origin.y:clock_minute.y+clock_minute.width/2
                        angle:minuteItem.value*minuteItem.angle_minute+180
                    }

                    antialiasing: true
                }
                Item{
                    id:hourItem
                    property int value:hour
                    property int angle_hour: 360/12
                    Image{
                        x:clock_hour.x+clock_hour.width/2+1
                        y:clock_hour.y+clock_hour.width/1.98
                        width: 7
                        height:clock_hour.width/2.5
                        antialiasing: true
                        source:"qrc:/images/minute.png"
                    }
                    transform: Rotation
                    {
                        origin.x:clock_hour.x+clock_hour.width/2+2
                        origin.y:clock_hour.y+clock_hour.width/1.98
                        angle:hourItem.value*hourItem.angle_hour+30*(minutes/60) +180
                    }
                    antialiasing: true
                }

                Timer{
                    id:timer
                    repeat: true
                    interval: 1000
                    running: true
                    onTriggered: {
                        curentTime = new Date()
                        print(curentTime.getHours(),":",curentTime.getMinutes(),":",curentTime.getSeconds());
                    }
                }
            }
            /////////////////////////////////////////////////drive mode
            Rectangle{
                id:left_drivemode
                visible:false
                color:"#00000000"
                opacity: 1
                anchors.fill:left_circle
                anchors.centerIn: left_circle
                Behavior on opacity {
                    NumberAnimation {
                        duration: 500  // 1초 동안 애니메이션 진행
                    }
                }
                onOpacityChanged: {
                    if (opacity == 0) {
                        left_drivemode.visible = false;
                    }
                }

                Rectangle {
                    id:hi_3
                    anchors.centerIn: parent
                    width: right_circle*0.5
                    height: right_circle*0.5
                    color: "#222"

                    DBusManager {
                        id: dbusHandler
                    }

                    Column {
                        id:detail_box2
                        anchors.centerIn: parent
                        spacing: -140

                        Rectangle {
                            id:sports
                            visible:true
                            width: 26
                            height: 200
                            color: "#333"
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }

                            Text {
                                id:detail_text2

                                anchors.centerIn: parent
                                text: "Sports"
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            rotation: 270

                            MouseArea {
                                anchors.fill: sports
                                onClicked: {
                                    dbusHandler.sendToDBus(9);
                                    left_circle.color = "#f03e6e"//"#77ff3f19"
                                    right_circle.color = "#f03e6e"
                                    if (left_drivemode.visible) {
                                        left_drivemode.opacity = 0;  // 애니메이션 시작
                                        left_clockmode.visible=true;
                                        left_clockmode.opacity=1;

                                    } else {
                                        left_drivemode.visible = true;
                                        left_drivemode.opacity = 1;  // 애니메이션 시작
                                        left_clockmode.visible=false;
                                        left_clockmode.opacity=0;
                                    }
                                }
                            }

                        }

                        Rectangle {
                            id:normal
                            width: 26
                            height: 200
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }


                            Text {
                                anchors.centerIn: parent
                                text: "Normal"
                                font.pixelSize: 16
                                color: "white"
                                rotation:90
                            }
                            rotation: 270

                            MouseArea {
                                anchors.fill: normal
                                onClicked: {
                                    dbusHandler.sendToDBus(5);
                                    left_circle.color = "#73c7ff"
                                    right_circle.color = "#73c7ff"//"#7719afff"
                                    if (left_drivemode.visible) {
                                        left_drivemode.opacity = 0;  // 애니메이션 시작
                                        left_clockmode.visible=true;
                                        left_clockmode.opacity=1;

                                    } else {
                                        left_drivemode.visible = true;
                                        left_drivemode.opacity = 1;  // 애니메이션 시작
                                        left_clockmode.visible=false;
                                        left_clockmode.opacity=0;
                                    }
                                }
                            }

                        }

                        Rectangle {
                            id: eco
                            width: 26
                            height: 200
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "Eco"
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            rotation: 270

                            MouseArea {
                                anchors.fill: eco
                                onClicked: {
                                    dbusHandler.sendToDBus(3);
                                    left_circle.color = "#77a0ff9e"
                                    right_circle.color = "#77a0ff9e"
                                    if (left_drivemode.visible) {
                                        left_drivemode.opacity = 0;  // 애니메이션 시작
                                        left_clockmode.visible=true;
                                        left_clockmode.opacity=1;

                                    } else {
                                        left_drivemode.visible = true;
                                        left_drivemode.opacity = 1;  // 애니메이션 시작
                                        left_clockmode.visible=false;
                                        left_clockmode.opacity=0;
                                    }
                                }
                            }

                        }

                    }
                }
            }
        }

 ////////////////////////////////

        Text{
            id:gear
            x:x_center-x_gap*1.5 //x_center-x_gap*1.5
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 30
            font.bold: false
            color:center_color
            text:"P R N D"
        }


        Rectangle{
            id:gear_light
            x:x_center+x_gap*14.1 //x_center-x_gap*1.5
            visible: driveVisible
            width:25
            height:30
            radius:3

            SequentialAnimation on color {
                ColorAnimation { from: "#aae6e6e6"; to: "#aa737373"; duration: 1500 }
//                ColorAnimation { from: "#737373"; to: "#73ccff"; duration: 1500 }
            }
            opacity:1
            anchors{
                top: centerScreen.top
                topMargin: 102
            }
        }
        Rectangle{
            id:gear_light_2
            x:x_center+x_gap*11 //x_center-x_gap*1.5
            visible: parkVisible
            width:25
            height:30
            radius:3
            SequentialAnimation on color {
            ColorAnimation { from: "#e6e6e6"; to: "#ff9090"; duration: 1500 }
                //                ColorAnimation { from: "#e6e6e6"; to: "#73ccff"; duration: 1500 }
            }
            opacity:1
            anchors{
                top: centerScreen.top
                topMargin: 102
            }
        }


        Text{
            id:gear_d
            x:x_center+x_gap*14.1
            visible: driveVisible
            SequentialAnimation on color {
                ColorAnimation { from: "#000000"; to: "#ffffff"; duration: 1500 }
            }
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            font.pixelSize: 30
            font.bold: false
            text:"D"
        }

        Text{
            id:gear_p
            x:x_center+x_gap*11.1//x_center-x_gap*1.5
            //color:"blue"
            visible: parkVisible
            SequentialAnimation on color {
                ColorAnimation { from: "#000000"; to: "#ffffff"; duration: 1500 }
            }
            anchors{
                top: centerScreen.top
                topMargin: 100
            }
            font.pixelSize: 30
            font.bold: false
            text:"P"

        }


        Item{ //park mode
            anchors.fill:centerScreen
            Text{
                id:gearPark
                visible: parkVisible
                anchors{
                    top: parent.top
                    topMargin: 30
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 50
                font.bold: false
                color:black
                text:"P"
            }

            Image{
                id:carparkIcon
                visible:parkVisible
                anchors{
                    top: parent.top
                    topMargin: 150
                }
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*.8
                fillMode: Image.PreserveAspectFit
                source:"qrc:/images/car_park.png"
            }
        }

        Item{ //drive mode
            anchors.fill:centerScreen
            Text{
                id:speed
                visible: driveVisible
                anchors{
                    top: parent.top
                    topMargin: 5
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 60
                font.bold: false
                color:black
                text: valueSource.kph
            }
            Text{
                id:cmpersec
                visible: driveVisible
                anchors{
                    top: speed.bottom
                    topMargin: -3
                }
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 15
                font.bold: false
                color:center_color
                text:"CMPS"
            }
        }

        Text{
            id:odoCM
            anchors{
                left: centerScreen.left
                leftMargin: 20
                bottom: centerScreen.bottom
                bottomMargin: 20
            }
            font.pixelSize: 20
            font.bold: false
            color:center_color //black
            text:valueSource.odo+"m"
        }

        Text{
            id:tripCM
            anchors{
                right: centerScreen.right
                rightMargin: 20
                bottom: centerScreen.bottom
                bottomMargin: 20
            }
            font.pixelSize: 20
            font.bold: false
            color:center_color //black
            text:"TRIP 100 cm"
        }

        /////////////

        //////////////////////////////////


        Rectangle{
            id:right_view
            x:300
            anchors.verticalCenter: parent.verticalCenter
//            anchors.centerIn: parent /////////////////////////////////////////////
            color:"#00000000"
            visible:true
//            anchors.fill:right_circle
            opacity: 1
            Behavior on opacity {
                NumberAnimation {
                    duration: 500  // 1초 동안 애니메이션 진행
                }
            }
            onOpacityChanged: {
                if (opacity == 0) {
                    right_view.visible = false;
                }
            }

            //
            Rectangle{
                id:right_circle
                x:1280-120*6//centerScreen.width*0.7
                y:-155 //anchors.verticalCenter: parent.verticalCenter
                width:320
                height:320
                radius:160
                opacity:1
                color:"#77a0ff9e"//"#dfdfdf"
            }
            Rectangle{
                id:right_circle_2
                anchors.centerIn: right_circle
                width:right_circle.height*0.98
                height:right_circle.height*0.98
                radius:right_circle.radius*0.98
                opacity:1
                color:"black"
            }
            Rectangle{
                id:right_circle_3
                anchors.centerIn: right_circle
                width:right_circle.height*0.97
                height:right_circle.height*0.97
                radius:right_circle.radius*0.97
                opacity:1
                color:"#78797a"
            }
            Rectangle{
                id:right_circle_4
                anchors.centerIn: right_circle
                width:right_circle.height*0.9
                height:right_circle.height*0.9
                radius:right_circle.radius*0.9
                opacity:1
                color:"#000000"
            }
            //
            Rectangle{
                id:information_battey
                anchors.centerIn: right_circle
                visible:true
                opacity: 1
                Behavior on opacity {
                    NumberAnimation {
                        duration: 500  // 1초 동안 애니메이션 진행
                    }
                }
                onOpacityChanged: {
                    if (opacity == 0) {
                        information_battey.visible = false;
                    }
                }
                MouseArea {
                    anchors.fill: batterycarIcon
                    onClicked: {
                        if (information_battey.visible) {
                            information_battey.opacity = 0;  // 애니메이션 시작
                            information_detail.visible=true;
                            information_detail.opacity=1;
                        } else {
                            information_battey.visible = true;
                            information_battey.opacity = 1;  // 애니메이션 시작
                            information_detail.visible=false;
                            information_detail.opacity=0;
                        }
                    }
                }
                Image{
                    id:batterycarIcon
                    anchors.centerIn: parent
                    width:right_circle.width*0.85
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.7
                    source:"qrc:/images/tesla_frame.png"
                }
                ProgressBar{
                    id:progressBar
                    width : right_circle.width * 0.3*0.85
                    height:right_circle.height * 0.2*0.85
                    anchors.centerIn: parent
                    value : valueSource.fuel / 100
                    rotation:0
                    background: Rectangle {
                        color: "#e6e6e6"
                        radius: 7
                    }
                    contentItem: Item {
                        Rectangle {
                            width: progressBar.visualPosition * parent.width*0.85
                            height: parent.height
                            radius: 7
                            color: "#00ffc3"//"#5bfa50"//"#17a81a"
                        }
                        Rectangle{
                            visible: true
                            width: parent.width //1200//progressBar.width
                            height: parent.height*0.9 //200 //progressBar.heigth
                            radius: 7
                            gradient: Gradient{
                                GradientStop{position: 0.0; color: "#d0ffffff"}
                                GradientStop{position: 0.3; color: "#30efefef"}
                                GradientStop{position: 0.65; color: "#3d000000"}
                                GradientStop{position: 0.85; color: "#3d000000"}
                                GradientStop{position: 1.0; color: "#30efefef"}
                            }
                        }
                    }
                }
                Text {
                    id:battery_percent
                    anchors.centerIn: progressBar
                    text:valueSource.fuel + "%"
                    font.pixelSize: 20
                    visible:true
                    color: "#efefef"
                }
                Text {
                    id:battery_name
                    visible:true
                    anchors{
                        top:progressBar.bottom
                        topMargin: 50
                    }
                    anchors.horizontalCenter: progressBar.horizontalCenter
        //            text: valueSource.travelableDis +"M"
                    text:"Battery"
                    font.pixelSize: 25
                    color: "white"
                }

                Rectangle { //bar
                    width: parent.width * .3
                    anchors{
                        top: parent.top
                        topMargin: 95
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 2
                    color: center_color
                }
            }
///////////////////////////////// Right 2(detail)
            Rectangle{
                id:information_detail
                anchors.fill: right_circle
                anchors.centerIn: right_circle

                color: "#00000000"
                visible:false
                opacity:1
                Behavior on opacity {
                    NumberAnimation {
                        duration: 500  // 1초 동안 애니메이션 진행
                    }
                }
                onOpacityChanged: {
                    if (opacity == 0) {
                        information_detail.visible = false;
                    }
                }

                MouseArea {
                    anchors.fill: information_detail
                    onClicked: {
                        if (information_detail.visible) {
                            information_detail.opacity = 0;  // 애니메이션 시작
                            information_battey.visible=true;
                            information_battey.opacity=1;
                        } else {
                            information_detail.visible = true;
                            information_detail.opacity = 1;  // 애니메이션 시작
                            information_battey.visible=false;
                            information_battey.opacity=0;
                        }
                    }
                }
                Rectangle {
                    id:hi_2
                    anchors.centerIn: parent
                    width: right_circle*0.5
                    height: right_circle*0.5
                    color: "#222"

                    Column {
                        id:detail_box
                        anchors.centerIn: parent
                        spacing: -140

                        Rectangle {
                            id:time_table
                            width: detail_text.height + 10
                            height: 200
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }
                            Text {
                                id:detail_text
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:parent.height/5
                                text: "Time:"
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            Text {
                                id:time
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:parent.height/2
                                text:hourItem.value+ ":"+ minuteItem.value
                                font.pixelSize: 16
                                color: "white"
                                rotation:90
                            }
                            rotation: 270
                        }

                        Rectangle {
                            width: time_table.width
                            height: time_table.height
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:parent.height/2.5
                                text: "Dist.:             m"
                                font.pixelSize: 16
                                color: "white"
                                rotation:90
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:time.y
                                text: valueSource.odo
                                font.pixelSize: 16
                                color: "white"
                                rotation:90
                            }
                            rotation: 270
                        }

                        Rectangle {
                            width: time_table.width
                            height: time_table.height
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:parent.height/2.7
                                text: "Battery:          %"
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:time.y
                                text: valueSource.fuel
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            rotation: 270
                        }

                        Rectangle {
                            width: time_table.width
                            height: time_table.height
                            color: "#333"

                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.3; color: "#333" }
                                GradientStop { position: 0.7; color: "#333" }
                                GradientStop { position: 1.0; color: "transparent" }
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:parent.height/2.3
                                text: "Speed:          cm/s"
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                y:time.y
                                text: valueSource.kph
                                font.pixelSize: 16
                                color: "white"
                                rotation: 90
                            }
                            rotation: 270
                        }
                    }
                }
            }

        }
/////////////////


    }



//    Image{
//        id:car_light_left
//        x:x_center+350 //x_center-x_gap*1.5
//        y:169.3

//        rotation: 180
//        visible: true
//        width:parent.width*0.05
//        height:parent.width*0.05
//        source:"file:/home/seame-workstation07/Downloads/black_light.png"
//    }
//    Image{
//        id:car_light_right
//        x:x_center+390 //x_center-x_gap*1.5
//        y:169.3

//        rotation: 180
//        visible: true
//        width:parent.width*0.05
//        height:parent.width*0.05
//        source:"file:/home/seame-workstation07/Downloads/black_light.png"
//    }


//////////////////////////////////////////////////////////////////////////////////Right screen///////////////////////
//    Rectangle{
//        id:rightScreen
//        property real batteryPercentage: 0.75 // Set battery percentage between 0 and 1

//        anchors{
//            left: centerScreen.right
//            top: parent.top
//            bottom: parent.bottom
//        }
//        width: side_width //parent.width/3.25
//        color: side //white
//    }
}







    //        Image{
    //            id:carTopviewIcon
    //            anchors.centerIn:parent
    //            height:parent.height*.8
    //            fillMode: Image.PreserveAspectFit
    //            source:"file:/home/seame-workstation07/Downloads/car_upview.png"
    //        }

    //        Text{
    //            id:time
    //            anchors{
    //                right:parent.right
    //                rightMargin: 20
    //                top:parent.top
    //                topMargin: 20
    //            }
    //            font.pixelSize: 20
    //            font.bold: false

    //            color:black
    //            text:"12:00 PM"
    //        }

    //        Text{
    //            id:lefttopPsi
    //            anchors{
    //                right:carTopviewIcon.left
    //                top:carTopviewIcon.top
    //                topMargin: 80
    //            }
    //            font.pixelSize: 20
    //            font.bold: false
    //            color:black
    //            text:"46 Psi"
    //        }

    //////////////////////////////////////////////////////////////////////////////////////////////////////VV
    //            Canvas {
    //                visible: driveVisible
    //                width: centerScreen.width
    //                height: centerScreen.height

    //                onPaint: {
    //                    var ctx = getContext("2d");
    //                    ctx.strokeStyle = "#737373";
    //                    ctx.lineWidth = 2;

    //                    // Starting point of the line
    //                    var startLX = 220;
    //                    var startLY = 180;

    //                    var startRX = 300;
    //                    var startRY = 180;

    //                    // Ending point of the line
    //                    var endLX = 170;
    //                    var endLY = 330;

    //                    var endRX = 340;
    //                    var endRY = 330;

    //                    ctx.beginPath();
    //                    ctx.moveTo(startRX, startRY);
    //                    ctx.lineTo(endRX, endRY);
    //                    ctx.stroke();

    //                    ctx.beginPath();
    //                    ctx.moveTo(startLX, startLY);
    //                    ctx.lineTo(endLX, endLY);
    //                    ctx.stroke();

    //                }

    //            }

    //            Image{
    //                id:cardriveIcon
    //                visible:driveVisible
    //                anchors{
    //                    top: parent.top
    //                    topMargin: 50
    //                }
    //                anchors.horizontalCenter: parent.horizontalCenter
    //                width:parent.width
    //                fillMode: Image.PreserveAspectFit

    //                source:"file:/home/seame-workstation07/Downloads/car_back.png"
    //            }



    ////////////////////////////////////////////////////////////////////////////////////////////////////

    //        Image{
    //            id:tree_r
    //            x:x_center-400 //x_center-x_gap*1.5
    //            y:15
    //            visible: driveVisible
    //            width:parent.width*.07
    //            height:parent.width*.07
    //            source:"file:/home/seame-workstation07/Downloads/3Dtree.png"
    //            NumberAnimation on x{
    //                loops: Animation.Infinite
    ////                from: 300; to:330; duration:1500-valueSource.kph*10;
    //                from: 300; to:380; duration:1500-valueSource.kph*10;
    //            }

    //            NumberAnimation on y{
    //                loops: Animation.Infinite
    ////                from: 150; to:200; duration:1500-valueSource.kph*10;
    //                from: 150; to:350; duration:1500-valueSource.kph*10;
    //            }
    //            PropertyAnimation on width {
    //                loops: Animation.Infinite
    //                from: tree_l.width
    //                to: tree_l.width * 1.8 // You can adjust the scale factor as needed
    //                duration: 1500 // Duration for the width animation
    //            }

    //            PropertyAnimation on height {
    //                loops: Animation.Infinite
    //                from: tree_l.height
    //                to: tree_l.height * 1.8 // You can adjust the scale factor as needed
    //                duration: 1500 // Duration for the height animation
    //            }
    //        }

    //        Image{
    //            id:tree_l
    //            x:x_center-400 //x_center-x_gap*1.5
    //            y:15
    //            visible: driveVisible
    //            width:450 *.07
    //            height:450 *.07
    //            source:"file:/home/seame-workstation07/Downloads/3dtree.png"
    //            NumberAnimation on x{
    //                loops: Animation.Infinite
    //                from: 190; to:110; duration: 1500-valueSource.kph*10;
    //            }
    //            NumberAnimation on y{
    //                loops: Animation.Infinite
    //                from: 150; to:350; duration: 1500-valueSource.kph*10;
    //            }
    //            PropertyAnimation on width {
    //                loops: Animation.Infinite
    //                from: tree_l.width
    //                to: tree_l.width * 1.8 // You can adjust the scale factor as needed
    //                duration: 1500 // Duration for the width animation
    //            }

    //            PropertyAnimation on height {
    //                loops: Animation.Infinite
    //                from: tree_l.height
    //                to: tree_l.height * 1.8 // You can adjust the scale factor as needed
    //                duration: 1500 // Duration for the height animation
    //            }
    //        }
