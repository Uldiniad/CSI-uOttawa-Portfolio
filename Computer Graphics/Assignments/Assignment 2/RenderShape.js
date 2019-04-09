function RenderShape() {
    this.gl = null;
    this.buffers = null;
    this.programInfo = null;
    this.colors = null;
    this.vertices = null;
    this.indices = null;
    this.vertexShaderFile = null;
    this.fragmentShaderFile = null;
    this.wireframe = null;

    this.rotation = 0.0;
    this.rotationVector = [Math.random() * 2 - 1, Math.random() * 2 - 1, Math.random() * 2 - 1];
    this.then = 0;

    this.render = function (now) {
        now *= 0.001;  // convert to seconds
        const deltaTime = now - this.then;
        this.then = now;

        this.drawScene(this.gl, this.programInfo, this.buffers, deltaTime);

        requestAnimationFrame(timestamp => this.render(timestamp));

        this.rotation += deltaTime;
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
        if (!this.wireframe) {
            this.gl.uniform1i(uWireframe, 0);
            this.gl.drawElements(this.gl.TRIANGLES, this.indices.length, this.gl.UNSIGNED_SHORT, 0);
        }
        this.gl.uniform1i(uWireframe, 1);
        this.gl.drawElements(this.gl.LINE_STRIP, this.indices.length, this.gl.UNSIGNED_SHORT, 0)
    };

    this.initBuffers = function () {
        const vertexBuffer = this.gl.createBuffer();
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, vertexBuffer);
        this.gl.bufferData(this.gl.ARRAY_BUFFER, this.vertices, this.gl.STATIC_DRAW);

        const indexBuffer = this.gl.createBuffer();
        this.gl.bindBuffer(this.gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
        this.gl.bufferData(this.gl.ELEMENT_ARRAY_BUFFER, this.indices, this.gl.STATIC_DRAW);

        this.colors = [];
        for (let i = 0; i < this.vertices.length / 3; i++) {
            this.colors = this.colors.concat(Math.random(), Math.random(), Math.random(), 1)
        }
        this.colors = new Float32Array(this.colors);

        const colorBuffer = this.gl.createBuffer();
        this.gl.bindBuffer(this.gl.ARRAY_BUFFER, colorBuffer);
        this.gl.bufferData(this.gl.ARRAY_BUFFER, this.colors, this.gl.STATIC_DRAW);

        this.buffers = {
            vertices: vertexBuffer,
            color: colorBuffer,
            indices: indexBuffer,
        };
    };

    this.processShader = function (file) {
        let request = new XMLHttpRequest();
        request.open('GET', file, false);
        request.send();
        return request.responseText;
    };

    this.processShaders = function () {
        initShaders(this.gl, this.processShader(this.vertexShaderFile), this.processShader(this.fragmentShaderFile));
    };

    this.main = function () {
        this.processShaders();
        this.programInfo = {
            program: this.gl.program,
            attribLocations: {
                vertexPosition: this.gl.getAttribLocation(this.gl.program, 'aVertexPosition'),
                vertexColor: this.gl.getAttribLocation(this.gl.program, 'aVertexColor'),
            },
            uniformLocations: {
                projectionMatrix: this.gl.getUniformLocation(this.gl.program, 'uProjectionMatrix'),
                modelViewMatrix: this.gl.getUniformLocation(this.gl.program, 'uModelViewMatrix'),
            },
        };
        this.initBuffers();
        requestAnimationFrame(timestamp => this.render(timestamp));
    }
}



