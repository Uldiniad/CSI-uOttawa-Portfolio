let scene = new Scene();
let teapot = new Teapot();

scene.cameraControls = new THREE.OrbitControls(scene.camera, scene.renderer.domElement);
scene.cameraControls.addEventListener('change', render);

let directional_light = new THREE.DirectionalLight();
directional_light.position.set(-1, 1, 1);

let spot_light = new THREE.SpotLight();
let radius = 200;
spot_light.intensity = 0.25;
spot_light.angle = Math.PI / 32;
spot_light.position.set(0, 0, 200);

let gui = new dat.GUI();

gui.add({phong: true}, 'phong').onChange(function (phong) {
    let meshBasicMaterial = new THREE.MeshBasicMaterial({
        color: 'white'
    });
    meshBasicMaterial.map = teapot.material.map;
    meshBasicMaterial.specularMap = teapot.material.specularMap;
    meshBasicMaterial.displacementMap = teapot.material.displacementMap;
    meshBasicMaterial.bumpMap = teapot.material.bumpMap;
    teapot.setMaterial(phong ? new THREE.MeshPhongMaterial({
        color: 'copper',
        side: THREE.DoubleSide,
        map: teapot.material.map,
        specularMap: teapot.material.specularMap,
        displacementMap: teapot.material.displacementMap,
        bumpMap: teapot.material.bumpMap
    }) : meshBasicMaterial);
    render();
});
let textures = {
    map: {visible: false, texture: new THREE.TextureLoader().load('fern.png')},
    specularMap: {visible: false, texture: new THREE.TextureLoader().load('specularFern.png')},
    displacementMap: {visible: false, texture: new THREE.TextureLoader().load('displacementFern.png')},
    bumpMap: {visible: false, texture: new THREE.TextureLoader().load('bumpFern.png')}
};
for (const key in textures) {
    gui.add(textures[key], 'visible').name(key.toString()).onChange(function (visible) {
        visible ? teapot.setTexture(key, textures[key].texture) : teapot.clearTexture(key);
        teapot.material.needsUpdate = true;
        render()
    });
}
gui.add({position: 0}, 'position', 0, 360).onChange(function (angle) {
    spot_light.position.set(radius * sin(angle), 0, radius * cos(angle));
    render();
});
gui.add(spot_light, 'angle', 0, Math.PI / 4).onChange(function (angle) {
    spot_light.angle = angle;
    render();
});

scene.add(teapot);
scene.add(directional_light);
scene.add(spot_light);
render();

function render() {
    Scene.render(scene.renderer, scene, scene.camera);
}

function cos(degrees) {
    return Math.cos(THREE.Math.degToRad(degrees));
}

function sin(degrees) {
    return Math.sin(THREE.Math.degToRad(degrees));
}