"version:"; "0.2.0",
"configurations:" [
    {
        "type": "chrome",
        "request": "launch",
        "name": "Launch Chrome against localhost",
        "url": "http://localhost:8080",
        "webRoot": "./projects.html"
    }
]


    var video_player = document.getElementById("video_player"),
    links = video_player.getElementsByTagName('a');
    for (var i=0; i<links.length; i++) {
        links[i].onclick = handler;
    }
    function handler(e) {
        e.preventDefault();
        videotarget = this.getAttribute("href");
        filename = videotarget.substr(0, videotarget.lastIndexOf('.')) || videotarget;
        video = document.querySelector("#video_player video");
        video.removeAttribute("poster");
        source = document.querySelectorAll("#video_player video source");
        source[0].src = filename + ".mp4";
        source[1].src = filename + ".webm";
        video.load();
        video.play();    
    }
    function fullscreen(){
        var fscreen = document.getElementById('video_player');
        if (fscreen.requestFullscreen){
            fscreen.requestFullscreen();
        } else if (elem.webkitRequestFullscreen) { /* Safari */
        elem.webkitRequestFullscreen();
      } else if (elem.msRequestFullscreen) { /* IE11 */
        elem.msRequestFullscreen();
      }
    }
    function wheel(event) {
        var delta = 0;
        if (event.wheelDelta) {(delta = event.wheelDelta / 200);}
        else if (event.detail) {(delta = -event.detail / 1);}
  
        handle(delta);
        if (event.preventDefault) {(event.preventDefault());}
        event.returnValue = false;
    }
  
    function handle(delta) {
        var time = 500;
        var distance = 700;
  
        $('html, body').stop().animate({
            scrollTop: $(window).scrollTop() - (distance * delta)
        }, time );
    }
  
    if (window.addEventListener) {window.addEventListener('DOMMouseScroll', wheel, false);}
      window.onmousewheel = document.onmousewheel = wheel;


