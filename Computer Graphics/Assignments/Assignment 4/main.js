Ammo().then(function (Ammo) {
    window.addEventListener('resize', function () {
        camera.aspectRatio = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    }, true);

    init();
    animate();

    function init() {
        initGraphics();
        initPhysics();
        createObjects();
        initControls();
    }

    function initGraphics() { // Inspired by https://github.com/kripken/ammo.js/blob/master/examples/webgl_demo_softbody_rope/index.html
        camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.2, 2000);

        scene = new THREE.Scene();

        renderer = new THREE.WebGLRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(renderer.domElement);

        let directional_light = new THREE.DirectionalLight();
        directional_light.position.set(1, 0.5, 0);
        scene.add(directional_light);

        scene.add(new THREE.AmbientLight(0x404040));

        stats = new Stats();
        document.body.appendChild(stats.domElement);
    }

    function initPhysics() { // Inspired by https://github.com/kripken/ammo.js/blob/master/examples/webgl_demo_softbody_rope/index.html
        clock = new THREE.Clock();
        time = 0;
        let collisionConfiguration = new Ammo.btDefaultCollisionConfiguration();
        let dispatcher = new Ammo.btCollisionDispatcher(collisionConfiguration);
        let broadphase = new Ammo.btDbvtBroadphase();
        let solver = new Ammo.btSequentialImpulseConstraintSolver();
        physicsWorld = new Ammo.btDiscreteDynamicsWorld(dispatcher, broadphase, solver, collisionConfiguration);
        physicsWorld.setGravity(new Ammo.btVector3(0, -9.82, 0));
        auxiliaryTransform = new Ammo.btTransform();
        rigidBodies = [];
        margin = 0.05;
    }

    function createObjects() { // Inspired by https://github.com/kripken/ammo.js/blob/master/examples/webgl_demo_softbody_rope/index.html
        terrain = new THREE.Mesh(new THREE.BoxGeometry(40, 1, 40), new THREE.MeshPhongMaterial({color: 'blue'}));
        let terrainShape = new Ammo.btBoxShape(new Ammo.btVector3(terrain.geometry.parameters.width * 0.5, terrain.geometry.parameters.height * 0.5, terrain.geometry.parameters.depth * 0.5));
        terrainShape.setMargin(margin);
        terrain.position.set(0, -0.5, 0);
        createRigidBody(terrain, terrainShape);
        scene.add(terrain);
        for (let i = 0; i < 360; i += 90) {
            let wall = new THREE.Mesh(new THREE.BoxGeometry(1, 3, 40), new THREE.MeshPhongMaterial({color: 'white'}));
            let wallShape = new Ammo.btBoxShape(new Ammo.btVector3(wall.geometry.parameters.width * 0.5, wall.geometry.parameters.height * 0.5, wall.geometry.parameters.depth * 0.5));
            wallShape.setMargin(margin);
            wall.rotation.set(0, THREE.Math.degToRad(i), 0);
            wall.position.set(20 * cos(i), 0, 20 * sin(i));
            createRigidBody(wall, wallShape);
            scene.add(wall);
        }

        sphere = new THREE.Mesh(new THREE.SphereGeometry(1), new THREE.MeshPhongMaterial({color: 'white'}));
        let sphereShape = new Ammo.btSphereShape(sphere.geometry.parameters.radius);
        sphereShape.setMargin(margin);
        sphere.position.set(0, 2, 0);
        createRigidBody(sphere, sphereShape, 1);
        sphere.userData.physicsBody.setFriction(0.5);
        ball = new THREE.Group().add(sphere);
        scene.add(ball);

        cubes = new THREE.Group();
        for (let i = 0; i < 360; i += 22.5) {
            let cube = new THREE.Mesh(new THREE.BoxGeometry(1, 1, 1), new THREE.MeshPhongMaterial({color: 'yellow'}));
            let cubeShape = new Ammo.btBoxShape(new Ammo.btVector3(cube.geometry.parameters.width * 0.5, cube.geometry.parameters.height * 0.5, cube.geometry.parameters.depth * 0.5));
            cubeShape.setMargin(margin);
            cube.position.set(12.5 * cos(i), 1, 12.5 * sin(i));
            createRigidBody(cube, cubeShape);
            cubes.add(cube);
        }
        cubesRigidBodies = new Map(cubes.children.map(cube => [cube.userData.physicsBody.J, cube]));
        scene.add(cubes);
    }

    function createRigidBody(object, physicsShape, mass = 0) { // Inspired by https://github.com/kripken/ammo.js/blob/master/examples/webgl_demo_softbody_rope/index.html
        let transform = new Ammo.btTransform();
        transform.setIdentity();
        transform.setOrigin(new Ammo.btVector3(object.position.x, object.position.y, object.position.z));
        transform.setRotation(new Ammo.btQuaternion(object.quaternion.x, object.quaternion.y, object.quaternion.z, object.quaternion.w));

        let localInertia = new Ammo.btVector3(0, 0, 0);
        physicsShape.calculateLocalInertia(mass, localInertia);

        let rbInfo = new Ammo.btRigidBodyConstructionInfo(mass, new Ammo.btDefaultMotionState(transform), physicsShape, localInertia);
        let body = new Ammo.btRigidBody(rbInfo);

        object.userData.physicsBody = body;

        if (mass > 0) {
            rigidBodies.push(object);
            body.setActivationState(4);
        }
        physicsWorld.addRigidBody(body);
    }

    function initControls() { // Based on https://bl.ocks.org/duhaime/801daaa005c373eab6847741bd3f497a
        pressed = {};
        window.addEventListener('keydown', function (e) {
            pressed[e.key.toUpperCase()] = true;
        });
        window.addEventListener('keyup', function (e) {
            pressed[e.key.toUpperCase()] = false;
        });
    }

    function animate() {
        requestAnimationFrame(animate);
        render();
        stats.update();
    }

    function render() {
        delta = clock.getDelta();
        rotateCubes();
        moveSphere();
        physicsWorld.stepSimulation(delta, 10);
        updatePhysics();
        var relativeCameraOffset = new THREE.Vector3(40 * cos(30), 40 * sin(30), 0);
        var cameraOffset = relativeCameraOffset.applyMatrix4(ball.matrixWorld);
        camera.position.x = cameraOffset.x;
        camera.position.y = cameraOffset.y;
        camera.position.z = cameraOffset.z;
        camera.lookAt(ball.position);
        renderer.render(scene, camera);
        time += delta;
    }

    function rotateCubes() {
        for (let cube of cubes.children) {
            cube.rotateX(THREE.Math.degToRad(1));
            cube.rotateZ(THREE.Math.degToRad(1));
        }
    }

    function moveSphere() { // Inspired by https://bl.ocks.org/duhaime/801daaa005c373eab6847741bd3f497a
        if (pressed['W']) {
            sphere.userData.physicsBody.applyForce(new Ammo.btVector3(-5, 0, 0), new Ammo.btVector3(0, 0, 0))
        }
        if (pressed['S']) {
            sphere.userData.physicsBody.applyForce(new Ammo.btVector3(5, 0, 0), new Ammo.btVector3(0, 0, 0))
        }
        if (pressed['A']) {
            sphere.userData.physicsBody.applyForce(new Ammo.btVector3(0, 0, 5), new Ammo.btVector3(0, 0, 0))
        }
        if (pressed['D']) {
            sphere.userData.physicsBody.applyForce(new Ammo.btVector3(0, 0, -5), new Ammo.btVector3(0, 0, 0))
        }
    }

    function updatePhysics() {
        for (let i = 0; i < rigidBodies.length; i++) { // Based on https://github.com/kripken/ammo.js/blob/master/examples/webgl_demo_softbody_rope/index.html
            let object = rigidBodies[i];
            let objectPhysics = object.userData.physicsBody;
            let motionState = objectPhysics.getMotionState();
            if (motionState) {
                motionState.getWorldTransform(auxiliaryTransform);
                let position = auxiliaryTransform.getOrigin();
                let quaternion = auxiliaryTransform.getRotation();
                object.position.set(position.x(), position.y(), position.z());
                object.quaternion.set(quaternion.x(), quaternion.y(), quaternion.z(), quaternion.w());
            }
        }

        let dispatcher = physicsWorld.getDispatcher();
        for (let i = 0; i < dispatcher.getNumManifolds(); i++) {
            let manifold = dispatcher.getManifoldByIndexInternal(i);
            let body0 = manifold.getBody0();
            let body1 = manifold.getBody1();

            if (cubesRigidBodies.has(body0.J)) {
                physicsWorld.removeRigidBody(body0);
                cubes.remove(cubesRigidBodies.get(body0.J));
                if (cubes.children.length === 0) {
                    alert('You won!')
                }
            } else if (cubesRigidBodies.has(body1.J)) {
                physicsWorld.removeRigidBody(body1);
                cubes.remove(cubesRigidBodies.get(body1.J));
                if (cubes.children.length === 0) {
                    alert('You won!')
                }
            }
        }
    }

    function cos(degrees) {
        return Math.cos(THREE.Math.degToRad(degrees));
    }

    function sin(degrees) {
        return Math.sin(THREE.Math.degToRad(degrees));
    }
});