function Cylinder() {
    RenderShape.call(this);
    this.prototype = Object.create(RenderShape.prototype);
    Object.defineProperty(this.prototype, 'constructor', {
        value: this,
        enumerable: false,
        writable: true
    });
    this.wireframe = false;
    let degrees = 22.5;
    this.vertices = new Float32Array([
        Math.cos(THREE.Math.degToRad(0)), -1, -Math.sin(THREE.Math.degToRad(0)), // 0
        Math.cos(THREE.Math.degToRad(0)), 1, -Math.sin(THREE.Math.degToRad(0)), // 1
        Math.cos(THREE.Math.degToRad(degrees)), -1, -Math.sin(THREE.Math.degToRad(degrees)), // 2
        Math.cos(THREE.Math.degToRad(degrees)), 1, -Math.sin(THREE.Math.degToRad(degrees)), // 3
        Math.cos(THREE.Math.degToRad(2 * degrees)), -1, -Math.sin(2 * THREE.Math.degToRad(degrees)), // 4
        Math.cos(THREE.Math.degToRad(2 * degrees)), 1, -Math.sin(2 * THREE.Math.degToRad(degrees)), // 5
        Math.cos(THREE.Math.degToRad(3 * degrees)), -1, -Math.sin(3 * THREE.Math.degToRad(degrees)), // 6
        Math.cos(THREE.Math.degToRad(3 * degrees)), 1, -Math.sin(3 * THREE.Math.degToRad(degrees)), // 7
        Math.cos(THREE.Math.degToRad(4 * degrees)), -1, -Math.sin(4 * THREE.Math.degToRad(degrees)), // 8
        Math.cos(THREE.Math.degToRad(4 * degrees)), 1, -Math.sin(4 * THREE.Math.degToRad(degrees)), // 9
        Math.cos(THREE.Math.degToRad(5 * degrees)), -1, -Math.sin(5 * THREE.Math.degToRad(degrees)), // 10
        Math.cos(THREE.Math.degToRad(5 * degrees)), 1, -Math.sin(5 * THREE.Math.degToRad(degrees)), // 11
        Math.cos(THREE.Math.degToRad(6 * degrees)), -1, -Math.sin(6 * THREE.Math.degToRad(degrees)), // 12
        Math.cos(THREE.Math.degToRad(6 * degrees)), 1, -Math.sin(6 * THREE.Math.degToRad(degrees)), // 13
        Math.cos(THREE.Math.degToRad(7 * degrees)), -1, -Math.sin(7 * THREE.Math.degToRad(degrees)), // 14
        Math.cos(THREE.Math.degToRad(7 * degrees)), 1, -Math.sin(7 * THREE.Math.degToRad(degrees)), // 15
        Math.cos(THREE.Math.degToRad(8 * degrees)), -1, -Math.sin(8 * THREE.Math.degToRad(degrees)), // 16
        Math.cos(THREE.Math.degToRad(8 * degrees)), 1, -Math.sin(8 * THREE.Math.degToRad(degrees)), // 17
        Math.cos(THREE.Math.degToRad(9 * degrees)), -1, -Math.sin(9 * THREE.Math.degToRad(degrees)), // 18
        Math.cos(THREE.Math.degToRad(9 * degrees)), 1, -Math.sin(9 * THREE.Math.degToRad(degrees)), // 19
        Math.cos(THREE.Math.degToRad(10 * degrees)), -1, -Math.sin(10 * THREE.Math.degToRad(degrees)), // 20
        Math.cos(THREE.Math.degToRad(10 * degrees)), 1, -Math.sin(10 * THREE.Math.degToRad(degrees)), // 21
        Math.cos(THREE.Math.degToRad(11 * degrees)), -1, -Math.sin(11 * THREE.Math.degToRad(degrees)), // 22
        Math.cos(THREE.Math.degToRad(11 * degrees)), 1, -Math.sin(11 * THREE.Math.degToRad(degrees)), // 23
        Math.cos(THREE.Math.degToRad(12 * degrees)), -1, -Math.sin(12 * THREE.Math.degToRad(degrees)), // 24
        Math.cos(THREE.Math.degToRad(12 * degrees)), 1, -Math.sin(12 * THREE.Math.degToRad(degrees)), // 25
        Math.cos(THREE.Math.degToRad(13 * degrees)), -1, -Math.sin(13 * THREE.Math.degToRad(degrees)), // 26
        Math.cos(THREE.Math.degToRad(13 * degrees)), 1, -Math.sin(13 * THREE.Math.degToRad(degrees)), // 27
        Math.cos(THREE.Math.degToRad(14 * degrees)), -1, -Math.sin(14 * THREE.Math.degToRad(degrees)), // 28
        Math.cos(THREE.Math.degToRad(14 * degrees)), 1, -Math.sin(14 * THREE.Math.degToRad(degrees)), // 29
        Math.cos(THREE.Math.degToRad(15 * degrees)), -1, -Math.sin(15 * THREE.Math.degToRad(degrees)), // 30
        Math.cos(THREE.Math.degToRad(15 * degrees)), 1, -Math.sin(15 * THREE.Math.degToRad(degrees)), // 31
        Math.cos(THREE.Math.degToRad(16 * degrees)), -1, -Math.sin(16 * THREE.Math.degToRad(degrees)), // 32
        Math.cos(THREE.Math.degToRad(16 * degrees)), 1, -Math.sin(16 * THREE.Math.degToRad(degrees)), // 33
    ]);

    this.indices = new Uint16Array([
        0, 1, 2,
        1, 2, 3,
        2, 3, 4,
        3, 4, 5,
        4, 5, 6,
        5, 6, 7,
        6, 7, 8,
        7, 8, 9,
        8, 9, 10,
        9, 10, 11,
        10, 11, 12,
        11, 12, 13,
        12, 13, 14,
        13, 14, 15,
        14, 15, 16,
        15, 16, 17,
        16, 17, 18,
        17, 18, 19,
        18, 19, 20,
        19, 20, 21,
        20, 21, 22,
        21, 22, 23,
        22, 23, 24,
        23, 24, 25,
        24, 25, 26,
        25, 26, 27,
        26, 27, 28,
        27, 28, 29,
        28, 29, 30,
        29, 30, 31,
        30, 31, 32,
        31, 32, 33,
    ]);

    this.vertexShaderFile = 'shaders/vertex.shader';
    this.fragmentShaderFile = 'shaders/fragment.shader';
}