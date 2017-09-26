import QtQuick 2.0
import QtQuick.Controls 1.4

import "qrc:///qml/"
//import "../utils/"

//Item {
//    height: 500
//    width: 1000

Slider {

    function getTimeDispFromSec( sec ) {
        var min = Math.floor( sec/60 );
        sec = sec%60;
        var h = Math.floor( min/60 );
        min = min%60;
        var time = sec.toString();
        time = min.toString() + ":" + time;
        time = h.toString() + ":" + time;
        return time;
    }

    function getSecFromValue( val ) {
        return Math.floor( val * seekBar.getInputLength() / ( slider.maximumValue-slider.minimumValue ) );
    }

    function getValueFromPosX( posX ) {
        return ( posX/slider.width ) * ( slider.maximumValue-slider.minimumValue )
    }

    function getTimeDispFromPosX( posX ) {
        return getTimeDispFromSec(getSecFromValue(getValueFromPosX(posX)));
    }

    function hasChapters( ) {
        return seekBar.getSeekPointsTime().length > 0;
    }

    function getChapterNameFromSec( sec ) {
        var i = 0;
        var times = seekBar.getSeekPointsTime();
        while (i < times.length && times[i]/1000000 < sec) {
            i++;
        }
        return i>0 ? seekBar.getSeekPointsName()[i-1] : ""
    }

    function getChapterNameFromPosX( posX ) {
        return getChapterNameFromSec(getSecFromValue(getValueFromPosX(posX)))
    }

    function getDisplayFromPosX( posX )  {
        if (hasChapters()) {
            return getTimeDispFromPosX(posX)+" - "+getChapterNameFromPosX(posX);
        } else {
            return getTimeDispFromPosX(posX)
        }

    }

    property bool seekable: false


    id: slider

    maximumValue: seekBar.maximum
    minimumValue: seekBar.minimum
    value: seekBar.value

    style : SeekBarStyle {
        hovered: slider.state == "hovered"
        seek_bar: seekBar
    }

    TimeDisplayTip {
        id: timeDisplayTip
        opacity: 0.0
        x: Math.max( 0, Math.min( positionX - timeDisplayTip.width/2, parent.width - timeDisplayTip.width ) )
        y: 0 - height+15
        visible: slider.seekable
    }

    states: [
        State {
            name: "hovered"
            PropertyChanges { target: timeDisplayTip ; opacity: 1.0 }
        }
    ]

    transitions: Transition {
        from: ""; to: "hovered"; reversible: true
        NumberAnimation {
            properties: "opacity"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    MouseArea {
        id: sliderMouseArea
        propagateComposedEvents: true
        anchors.fill: slider
        hoverEnabled: true
        onEntered: { slider.state = "hovered" }
        onExited: { slider.state = "" }
        onMouseXChanged: {
            timeDisplayTip.positionX = mouseX;
            timeDisplayTip.text = getDisplayFromPosX(mouseX);
            if (slider.seekable && sliderMouseArea.pressed) {
                seekBar.value = getValueFromPosX(mouseX);
                seekBar.updatePos();
            }
        }
        onPressed: {
            if (slider.seekable)
            {
                seekBar.value = getValueFromPosX(mouseX);
                seekBar.updatePos();
            }
        }
    }

}
//}
