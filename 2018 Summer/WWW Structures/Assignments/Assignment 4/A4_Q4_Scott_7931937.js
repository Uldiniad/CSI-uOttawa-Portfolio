let picture;

function addEventListeners() {
    picture = document.getElementById("picture");
    picture.addEventListener('mousedown', start, false);
}

function start() {
    picture.addEventListener('mousemove', drag, false);
    picture.addEventListener('mouseup', stop, false);
}

function drag(event) {
    picture.style.left = (event.pageX - picture.width / 2) + "px";
    picture.style.top = (event.pageY - picture.height / 2) + "px";
}

function stop() {
    picture.removeEventListener("mousemove", drag, false);
    picture.removeEventListener("mouseup", stop, false);
}