window.addEventListener("click", click, false);

function click(event) {
    let string;
    if (event.ctrlKey) {
        string = "Element: " + event.target.nodeName;
    } else if (event.shiftKey) {
        string = "Event: " + event;
    } else {
        string = "Click"
    }
    alert(string);
}