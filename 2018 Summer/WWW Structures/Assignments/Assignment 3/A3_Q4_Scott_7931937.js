var array = new Array(1000);
array[0] = 0;
array[1] = 0;
array.fill(1, 2);
for (let i = 2; i < array.length && i > 0; i = array.indexOf(1, i + 1)) {
    if (array[i] === 1) {
        for (let j = i + i; j < array.length; j += i) {
            array[j] = 0;
        }
    }
}
for (let i = 2; i < array.length && i > 0; i = array.indexOf(1, i + 1)) {
    document.write(i + ' ');
}