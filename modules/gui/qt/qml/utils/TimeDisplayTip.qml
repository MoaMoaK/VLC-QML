import QtQuick 2.0

Canvas {
    property alias text: txt.text
    property int tip_height: 5
    property int tip_width: 6
    property int positionX: 0

    id: bubble
    height: txt.height + 6
    width: txt.width + 6

    onPositionXChanged: requestPaint()
    onTip_heightChanged: requestPaint()
    onTip_widthChanged: requestPaint()

    onPaint: {
        var top = 0;
        var left = 0;
        var right = bubble.width;
        var bot1 = bubble.height-bubble.tip_height;
        var bot2 = bubble.height;
        var tipX = bubble.positionX - bubble.x;
        var post_tipX = tipX+bubble.tip_width/2;
        var pre_tipX = tipX-bubble.tip_width/2;

        var ctx = getContext("2d");
        ctx.save();
        ctx.clearRect(0,0,bubble.width, bubble.height);

        ctx.strokeStyle = "#000000";
        ctx.lineWidth = 1;

        ctx.beginPath();
        ctx.moveTo( left, top );
        ctx.lineTo( right, top );
        ctx.lineTo( right, bot1 );
        ctx.lineTo( post_tipX, bot1 );
        ctx.lineTo( tipX, bot2);
        ctx.lineTo( pre_tipX, bot1 );
        ctx.lineTo( left, bot1 );
        ctx.closePath();

        ctx.stroke();

        ctx.restore();
    }

    Text {
        id: txt
        x: parent.width/2 - width/2
        y: parent.heigh/3 - height/2
        text: "timing"
    }
}
