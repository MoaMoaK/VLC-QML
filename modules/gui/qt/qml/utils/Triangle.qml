import QtQuick 2.0

Canvas {
              id: triangle
              antialiasing: true

              property int triangleWidth: 60
              property int triangleHeight: 60
              property color strokeStyle:  "#ffffff"
              property color fillStyle: "#ffffff"
              property int lineWidth: 3
              property bool fill: false
              property bool stroke: true
              property real alpha: 1.0
              property string direction: "left"
              states: [
                  State {
                      name: "pressed"; when: ma1.pressed
                      PropertyChanges { target: triangle; fill: true; }
                  }
              ]

              onLineWidthChanged:requestPaint();
              onFillChanged:requestPaint();
              onStrokeChanged:requestPaint();

              signal clicked()

              onPaint: {
                  var ctx = getContext("2d");
                  ctx.save();
                  ctx.clearRect(0,0,triangle.width, triangle.height);
                  ctx.strokeStyle = triangle.strokeStyle;
                  ctx.lineWidth = triangle.lineWidth
                  ctx.fillStyle = triangle.fillStyle
                  ctx.globalAlpha = triangle.alpha
                  ctx.lineJoin = "round";
                  ctx.beginPath();

                  // put rectangle in the middle
                  ctx.translate( (0.5 *width - 0.5*triangleWidth), (0.5 * height - 0.5 * triangleHeight))

                  // draw the rectangle
                  if (triangle.direction == "left")
                  {
                      ctx.moveTo(0, triangleHeight/2);
                      ctx.lineTo(triangleWidth, 0);
                      ctx.lineTo(triangleWidth, triangleHeight);
                      console.log("print")
                  }
                  else if (triangle.direction == "up")
                  {
                      ctx.moveTo(triangleWidth/2, 0);
                      ctx.lineTo(triangleWidth, triangleHeight);
                      ctx.lineTo(0, triangleHeight);
                  }
                  else if (triangle.direction == "right")
                  {
                      ctx.moveTo(triangleWidth, triangleHeight/2);
                      ctx.lineTo(0, triangleHeight);
                      ctx.lineTo(0, 0);
                  }
                  else if (triangle.direction == "down")
                  {
                      ctx.moveTo(triangleWidth/2, triangleHeight);
                      ctx.lineTo(0, 0);
                      ctx.lineTo(triangleWidth, 0);
                  }

                  ctx.closePath();
                  if (triangle.fill)
                      ctx.fill();
                  if (triangle.stroke)
                      ctx.stroke();
                  ctx.restore();
              }
              MouseArea{
                  id: ma1
                  anchors.fill: parent
                  onClicked: parent.clicked()
              }
}
