class Teapot extends THREE.Mesh {
    constructor() {
        super(new THREE.TeapotBufferGeometry(), new THREE.MeshPhongMaterial({
            color: 'orange',
            side: THREE.DoubleSide
        }));
    }

    setMaterial(material) {
        this.material = material;
    }

    setTexture(map, texture) {
        this.material[map] = texture;
    }

    clearTexture(map) {
        this.material[map] = null;
    }
}