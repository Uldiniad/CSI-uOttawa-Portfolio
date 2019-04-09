function Lattice() {
    RenderShape.call(this);
    this.prototype = Object.create(RenderShape.prototype);
    Object.defineProperty(this.prototype, 'constructor', {
        value: this,
        enumerable: false,
        writable: true
    });
    this.icosahedrons = new Array(12).fill(new Icosahedron(false));
    this.cylinders = new Array(20).fill(new Cylinder());

    this.initBuffers = function () {
        VAO = this.gl.createVertexArray();
        this.gl.bindVertexArray(VAO);

        elementBuffer = this.gl.createBuffer();
        this.gl.bindBuffer(this.gl.ELEMENT_ARRAY_BUFFER, elementBuffer);
        this.gl.bufferData(this.gl.ELEMENT_ARRAY_BUFFER, this.indices, this.gl.STATIC_DRAW);
    };

    this.drawScene = function () {
        this.gl.clearColor(0.0, 0.0, 0.0, 1.0);
        this.gl.clearDepth(1.0);
        this.gl.enable(this.gl.DEPTH_TEST);
        this.gl.depthFunc(this.gl.LEQUAL);
        this.gl.clear(this.gl.COLOR_BUFFER_BIT | this.gl.DEPTH_BUFFER_BIT);

        const fieldOfView = 45 * Math.PI / 180;   // in radians
        const aspect = this.gl.canvas.clientWidth / this.gl.canvas.clientHeight;
        const zNear = 0.1;
        const zFar = 100.0;
        const projectionMatrix = glMatrix.mat4.create();

        glMatrix.mat4.perspective(projectionMatrix,
            fieldOfView,
            aspect,
            zNear,
            zFar);

        const modelViewMatrix = glMatrix.mat4.create();

        glMatrix.mat4.translate(modelViewMatrix, modelViewMatrix, [-0.0, 0.0, -6.0]);
        glMatrix.mat4.rotate(modelViewMatrix, modelViewMatrix, this.rotation, this.rotationVector);

        {
            const numComponents = 3;
            const type = this.gl.FLOAT;
            const normalize = false;
            const stride = 0;
            const offset = 0;
            this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers.vertices);
            this.gl.vertexAttribPointer(
                this.programInfo.attribLocations.vertexPosition,
                numComponents,
                type,
                normalize,
                stride,
                offset);
            this.gl.enableVertexAttribArray(
                this.programInfo.attribLocations.vertexPosition);
        }

        {
            const numComponents = 4;
            const type = this.gl.FLOAT;
            const normalize = false;
            const stride = 0;
            const offset = 0;
            this.gl.bindBuffer(this.gl.ARRAY_BUFFER, this.buffers.color);
            this.gl.vertexAttribPointer(
                this.programInfo.attribLocations.vertexColor,
                numComponents,
                type,
                normalize,
                stride,
                offset);
            this.gl.enableVertexAttribArray(
                this.programInfo.attribLocations.vertexColor);
        }

        this.gl.uniformMatrix4fv(
            this.programInfo.uniformLocations.projectionMatrix,
            false,
            projectionMatrix);
        this.gl.uniformMatrix4fv(
            this.programInfo.uniformLocations.modelViewMatrix,
            false,
            modelViewMatrix);

        let uWireframe = this.gl.getUniformLocation(this.gl.program, 'uWireframe');
        this.gl.uniform1i(uWireframe, 0);

        this.gl.bindVertexArray(VAO);
        this.gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, elementBuffer);
        this.gl.drawElementsInstanced(this.gl.TRIANGLE_STRIP, this.indices.length, this.gl.UNSIGNED_BYTE, 0, this.cylinders.length);
    };

    this.vertexShaderFile = 'shaders/vertex.shader';
    this.fragmentShaderFile = 'shaders/fragment.shader';
}