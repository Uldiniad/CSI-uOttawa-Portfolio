function run() {
    document.write('ON YOUR MARK<br>');
    setTimeout(function () {
        document.write('GET SET<br>')
    }, 1000);
    setTimeout(function () {
        document.write('BANG!<br>' + "THEY'RE OFF<br><br>")
    }, 2000);

    let track = new Array(71);
    track.fill('-');
    let tortoise = 0;
    let hare = 0;
    let seconds = 0;
    let race;
    setTimeout(function () {
        race = setInterval(advance, 1000);
    }, 3000);

    function advance() {
        track[hare] = '-';
        track[tortoise] = '-';
        let hare_move = Math.floor(Math.random() * 10 + 1);
        if (hare_move >= 9) {
            hare += 9; //big hop
        } else if (hare_move >= 6 && hare_move <= 8) {
            hare += 1; //small hop
        } else if (hare_move === 3) {
            hare -= 12; //big slip
        } else if (hare_move === 4 || hare_move === 5) {
            hare -= 2; //small slip
        }
        if (hare < 0) {
            hare = 0;
        }
        // else sleep
        track[hare] = 'H';
        let tortoise_move = Math.floor(Math.random() * 10 + 1);
        if (tortoise_move <= 5) {
            tortoise += 3;
        } else if (tortoise_move >= 8) {
            tortoise += 1;
        } else {
            tortoise -= 6;
        }
        if (tortoise < 0) {
            tortoise = 0;
        }
        track[tortoise] = 'T';
        if (tortoise === hare) {
            track[tortoise] = 'Ouch!'
        }
        document.body.innerHTML = '';
        document.write(track.join('') + "<br><br>");
        document.write(++seconds + 's<br><br>');
        if (hare === 70 && tortoise === 70) {
            document.write('IT’S A TIE');
            clearInterval(race);
        } else if (hare >= 70) {
            document.write('HARE WINS. YUCK!');
            clearInterval(race);
        } else if (tortoise >= 70) {
            document.write('TORTOISE WINS!!! YAY!!!');
            clearInterval(race);
        }
    }
}