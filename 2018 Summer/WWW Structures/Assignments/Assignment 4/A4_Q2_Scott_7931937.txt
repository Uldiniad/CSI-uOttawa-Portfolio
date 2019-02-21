let board;
let emptySlot;

function initialize() {
    let randomSequence = ['', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].sort(function () {
        return 0.5 - Math.random();
    });
    emptySlot = randomSequence.indexOf('');
    board = [document.getElementById("slot0"),
        document.getElementById("slot1"),
        document.getElementById("slot2"),
        document.getElementById("slot3"),
        document.getElementById("slot4"),
        document.getElementById("slot5"),
        document.getElementById("slot6"),
        document.getElementById("slot7"),
        document.getElementById("slot8"),
        document.getElementById("slot9"),
        document.getElementById("slot10"),
        document.getElementById("slot11"),
        document.getElementById("slot12"),
        document.getElementById("slot13"),
        document.getElementById("slot14"),
        document.getElementById("slot15")];
    for (let i = 0; i < board.length; i++) {
        board[i].innerHTML = randomSequence[i];
    }
}

function move(tile) {
    let temp = board[tile].innerHTML;
    if (emptySlot === tile - 1 || emptySlot === tile + 1 || emptySlot === tile - 4 || emptySlot === tile + 4) {
        board[tile].innerHTML = '';
        board[emptySlot].innerHTML = temp;
        emptySlot = tile;
        checkWin();
    } else {
        alert('Illegal move');
    }
}

function checkWin() {
    for (let i = 1; i < board.length; i++) {
        if (parseInt(board[i - 1].innerHTML) !== i)
            return;
    }
    if (confirm('You win. Play again?')) {
        initialize();
    }
}