import QtQuick 2.0

Canvas {

    property int lineWidth: 1
    property string lineColor : "#000000"
    property var seek_bar

    id: chap

    onPaint: {
        var points_time = seek_bar.getSeekPointsTime();
        var total_time = seek_bar.getInputLength();
        var points_px = [];
        points_time.forEach(function(item, index, array) {
            points_px.push( (item/1000000)/total_time*chap.width);
        });

        var ctx = getContext("2d");
        ctx.save();
        ctx.clearRect(0,0,chap.width, chap.height);

        ctx.strokeStyle = lineColor;
        ctx.lineWidth = lineWidth;

        ctx.beginPath();
        points_px.forEach( function(item, index, array) {
            ctx.moveTo(item, 0);
            ctx.lineTo(item, chap.height);
        });
        ctx.closePath();

        ctx.stroke();

        ctx.restore();
    }
}
