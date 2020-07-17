// EChars.js 
// https://juejin.im/post/5d6a83a6f265da03900545d5
// 基于 Canvas 手撸一个六边形能力图

function computeHexagonPoints(width, height, edge) {
    let centerX = width / 2;
    let centerY = height / 2;
    let x = edge * Math.sqrt(3) / 2;
    let left = centerX - x;
    let x1,x2,x3,x4,x5,x6;
    let y1,y2,y3,y4,y5,y6;
    x5 = x6 = left;
    x2 = x3 = left + x * 2;
    x1 = x4 = left + x;

    let y = edge / 2;
    let top = centerY - 2 * y;
    y1 = top;
    y2 = y6 = top + y;
    y3 = y5 = top + 3 * y;
    y4 = top + 4 * y;

    let points = new Array();
    points[0] = [x1, y1];
    points[1] = [x2, y2];
    points[2] = [x3, y3];
    points[3] = [x4, y4];
    points[4] = [x5, y5];
    points[5] = [x6, y6];
    return points;
  }

_context = canvas.getContext('2d');

function drawHexagonInner(edge) {
    _context.strokeStyle = _color;
    for (var i = 0; i < 6; i++) {
      _allPoints[i] = computeHexagonPoints(_width, _height, edge - i * edge / 5);
      _context.beginPath();
      _context.moveTo(_allPoints[i][5][0],_allPoints[i][5][1]);
      for (var j = 0; j < 6; j++) {
        _context.lineTo(_allPoints[i][j][0],_allPoints[i][j][1]);
      }
      _context.closePath();
      _context.stroke();
    }
  }

function drawLines() {
    _context.beginPath();
    _context.strokeStyle = _color;
    for (let i = 0; i < 3; i++) {
      _context.moveTo(_allPoints[0][i][0],_allPoints[0][i][1]); //1-4
      _context.lineTo(_allPoints[0][i+3][0],_allPoints[0][i+3][1]); //1-4
      _context.stroke();
    }
    _context.closePath();
  }


/**
   * 画覆盖物
   */
  function drawCover() {

    let tmpCoverPoints = _allPoints[0];
    _coverPoints = [];
    console.log("coverPoints ",tmpCoverPoints)

    let centerX = _width / 2;
    let centerY = _height / 2;
    for (let i = 0; i < tmpCoverPoints.length; i++) {
      _coverPoints.push([
        centerX + (tmpCoverPoints[i][0] - centerX) * (_data[i].score / 100.0),
        centerX + (tmpCoverPoints[i][1] - centerY) * (_data[i].score / 100.0)
      ]);
    }
    console.log("newCoverPoints ",_coverPoints)
    _context.beginPath();
    _context.fillStyle = 'rgba(90,200,250,0.4)';
    _context.moveTo(_coverPoints[5][0],_coverPoints[5][1]); //5
    for (var j = 0; j < 6; j++) {
      _context.lineTo(_coverPoints[j][0],_coverPoints[j][1]);
    }
    _context.stroke();
    _context.closePath();
    _context.fill();
  }


/**
   * 描点
   * @param pointRadius
   */

  function drawPoints(pointRadius) {
    _context.fillStyle = _color;
    for (let i = 0; i < _coverPoints.length; i++) {
      _context.beginPath();
      _context.arc(_coverPoints[i][0],_coverPoints[i][1],pointRadius,0,Math.PI*2);
      _context.closePath();
      _context.fill();
    }
  }

/**
   * 绘制上侧的文字
   * @param text
   * @param pos
   */
  function drawUpText(item, pos) {
    let nameMeasure = _context.measureText(item.name);
    let scoreMeasure = _context.measureText(item.score);

    _context.fillStyle = '#8E8E8E';
    _context.fillText(item.name, pos[0] - nameMeasure.width / 2,pos[1] - 26);
    _context.fillStyle = '#212121';
    _context.fillText(item.score, pos[0] - scoreMeasure.width / 2,pos[1] - 10);

  }

/**
   * 绘制下侧的文字
   * @param text
   * @param pos
   */
  function drawDownText(item, pos) {

    let nameMeasure = _context.measureText(item.name);
    let scoreMeasure = _context.measureText(item.score);

    _context.fillStyle = '#8E8E8E';
    _context.fillText(item.name, pos[0] - nameMeasure.width / 2,pos[1] + 16);
    _context.fillStyle = '#212121';
    _context.fillText(item.score, pos[0] - scoreMeasure.width / 2,pos[1] + 32);
  }


/**
   * 绘制左侧的文字
   * @param text
   * @param pos
   */
  function drawLeftText(item, pos) {

    let nameMeasure = _context.measureText(item.name);
    let scoreMeasure = _context.measureText(item.score);

    _context.fillStyle = '#8E8E8E';
    _context.fillText(item.name, pos[0] - nameMeasure.width - 10,pos[1]);
    _context.fillStyle = '#212121';
    _context.fillText(item.score, pos[0] - 10 - (nameMeasure.width + scoreMeasure.width) / 2,pos[1] + 16);

  }

/**
   * 绘制右侧的文字
   * @param text
   * @param pos
   */
  function drawRightText(item, pos) {
    let nameMeasure = _context.measureText(item.name);
    let scoreMeasure = _context.measureText(item.score);

    _context.fillStyle = '#8E8E8E';
    _context.fillText(item.name, pos[0] - nameMeasure.width + 26,pos[1]);
    _context.fillStyle = '#212121';
    _context.fillText(item.score, pos[0] + 26 - (nameMeasure.width + scoreMeasure.width) / 2,pos[1] + 16);
  }

/**
   * 绘制所有文本
   */
  function drawText() {

    _context.fillStyle = '#8E8E8E';
    _context.strokeStyle = _color;

    let textPos = _allPoints[0];

    for (let i = 0; i < textPos.length; i++) {

      let item = _data[i];
      let pos = textPos[i];
      if(i == 0) {
        drawUpText(item, pos);
      } else if(i == 1 || i == 2) {
        drawRightText(item, pos);
      } else if(i == 3) {
        drawDownText(item, pos);
      } else if(i == 4 || i == 5) {
        drawLeftText(item, pos);
      }
    }
  }
