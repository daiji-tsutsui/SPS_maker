require './game_html.rb'

OUTPUT_FILENAME = 'game.html';

META = "<meta charset='UTF-8'>"

LINK = <<"EOS"
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/normalize.css@8.0.1/normalize.min.css'>
    <link rel='stylesheet' href='style.css'>
EOS

TITLE = 'Title'




# def enemy_pos(s)
#   return 200 * Math.sin(s)
# end
script = <<'EOS'
  const ENEMY_Z = -100.0;
  const MAN_HEIGHT = 20;
  const LINE_START_Z = -90;
  const LINE_END_Z = 100;
  const MAG_START = (-ENEMY_Z) / (LINE_START_Z - ENEMY_Z);
  const MAG_END = (-ENEMY_Z) / (LINE_END_Z - ENEMY_Z);
  var enemy_pos = 0.0;
  var s = 0;

  onload = function() {
    draw();
    var timer = setInterval(update, 1000.0/60.0);
  };

  var update = function() {
    enemy_pos = 300 * Math.sin(s * 0.02);
    s++;
    draw();
  }

  function draw() {
    var canvas = document.getElementById('game');
    if (!canvas || !canvas.getContext) {
      return false;
    }
    var ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, 640, 480);
    draw_line(ctx, -enemy_pos * MAG_START + 320, MAN_HEIGHT * MAG_START + 240,
      -enemy_pos * MAG_END + 320, MAN_HEIGHT * MAG_END + 240);
  }

  function draw_line(ctx, x1, y1, x2, y2, col = "yellow", lw = 1) {
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.strokeStyle = col;
    ctx.lineWidth = lw;
    ctx.stroke();
  }
EOS


game = GameHTML.new('SPS_JS', script)
canvas = <<'EOS'
    <div class="scores">
      <span id="pl-score">PLAYER'S LIFE: 5</span>
      <span id="en-score">ENEMY'S LIFE: 5</span>
    </div>
    <canvas id="game" width="640" height="480"></canvas>
    <a href="#" onclick="window.location.reload();">Retry</a>
EOS
game.add_canvas(canvas)
File.open(OUTPUT_FILENAME, mode = 'w') do |f|
  f.html_start
  f.write(game.head)
  f.write(game.body)
  f.html_end
end








# EOF
