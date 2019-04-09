function Icosahedron(wireframe) {
    RenderShape.call(this);
    this.prototype = Object.create(RenderShape.prototype);
    Object.defineProperty(this.prototype, 'constructor', {
        value: this,
        enumerable: false,
        writable: true
    });
    this.wireframe = wireframe;
    this.vertices = new Float32Array([
        -.525731087, 0, -.850650787, // 0
        .525731087, 0, -.850650787, // 1
        .525731087, 0, .850650787, // 2
        -.525731087, 0, .850650787, // 3
        -.850650787, -.525731087, 0, // 4
        -.850650787, .525731087, 0, // 5
        .850650787, .525731087, 0, // 6
        .850650787, -.525731087, 0,  // 7
        0, -.850650787, .525731087,  // 8
        0, -.850650787, -.525731087,  // 9
        0, .850650787, -.525731087,  // 10
        0, .850650787, .525731087  // 11
    ]);

    this.indices = new Uint16Array([
        1, 9, 0,
        10, 1, 0,
        5, 10, 0,
        4, 5, 0,
        9, 4, 0,
        8, 2, 3,
        4, 8, 3,
        5, 4, 3,
        11, 5, 3,
        2, 11, 3,
        11, 2, 6,
        10, 11, 6,
        1, 10, 6,
        7, 1, 6,
        2, 7, 6,
        11, 10, 5,
        9, 8, 4,
        7, 2, 8,
        9, 7, 8,
        1, 7, 9,
    ]);

    this.vertexShaderFile = 'shaders/vertex.shader';
    this.fragmentShaderFile = 'shaders/fragment.shader';
}