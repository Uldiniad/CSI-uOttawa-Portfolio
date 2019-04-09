class Scene extends THREE.Scene {
    constructor() {
        super();
        this.canvasWidth = window.innerWidth;
        this.canvasHeight = window.innerHeight;
        this.renderer = new THREE.WebGLRenderer();
        this.renderer.setPixelRatio(window.devicePixelRatio);
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(this.renderer.domElement);

        this.camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 80000);
        this.camera.position.set(0, 50, 200);

        window.addEventListener('resize', this.onWindowResize, false);
    }

    onWindowResize() {
        this.renderer.setSize(this.canvasWidth, this.canvasHeight);

        this.camera.aspectRatio = this.canvasWidth / this.canvasHeight;
        this.camera.updateProjectionMatrix();

        Scene.render(this.renderer, this, this.camera);
    }

    static render(renderer, scene, camera) {
        renderer.render(scene, camera);
    }
}