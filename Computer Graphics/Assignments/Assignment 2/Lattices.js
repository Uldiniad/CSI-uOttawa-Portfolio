function Lattices() {
    RenderShape.call(this);
    this.prototype = Object.create(RenderShape.prototype);
    Object.defineProperty(this.prototype, 'constructor', {
        value: this,
        enumerable: false,
        writable: true
    });

    this.vertexShaderFile = 'shaders/vertex.shader';
    this.fragmentShaderFile = 'shaders/fragment.shader';
}