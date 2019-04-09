function init() {
    // Check if WebGL is available, display error
    if (WEBGL.isWebGLAvailable() === false) {
        // if unavailable, print error on console and exit
        document.body.appendChild(WEBGL.getWebGLErrorMessage());
    }

    // Register a resize event function
    window.addEventListener('resize', function () {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    }, true);

    // Register a mouse down event function
    mouse = new THREE.Vector2();
    document.addEventListener('mousedown', function (event) {
        event.preventDefault();
        mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
        mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
        render();
    });


    function init_scene() {
        scene = new THREE.Scene();

        let textureLoader = new THREE.TextureLoader();
        textureLoader.crossOrigin = "";

        // Add "savannah" plane
        scene.add(new THREE.Mesh(new THREE.PlaneGeometry(10, 10), new THREE.MeshBasicMaterial({color: 'orange'})).rotateX(THREE.Math.degToRad(-90)));

        // Add black spheres for joints, hoofs and spots
        let sphere = new THREE.Mesh(new THREE.SphereGeometry(1), new THREE.MeshBasicMaterial({color: 'black'}));
        // Add yellow cylinders for the rest of the body parts
        let cylinder = new THREE.Mesh(new THREE.CylinderGeometry(1, 1, 2), new THREE.MeshBasicMaterial({color: 'yellow'}));

        // Root node
        let torso = new THREE.Group();
        let torso_cylinder = cylinder.clone().translateY(7).rotateX(THREE.Math.degToRad(-90));
        torso_cylinder.scale.set(2, 6, 2);
        torso.add(torso_cylinder);

        let upper_joint = sphere.clone().translateY(5);
        upper_joint.name = 'upper_joint';
        let bone = cylinder.clone().translateY(-1);
        upper_joint.add(bone);
        let lower_joint = sphere.clone().translateY(-1);
        lower_joint.name = 'lower_joint';
        bone.add(lower_joint);
        let half_limb = upper_joint;

        let lower_limb = half_limb.clone().translateY(-5);
        let upper_limb = half_limb.clone();
        lower_limb.name = 'lower_limb';
        upper_limb.name = 'upper_limb';
        upper_limb.getObjectByName('lower_joint').add(lower_limb);
        let full_limb = upper_limb;

        legs = new THREE.Group();
        let front_left_leg = full_limb.clone().translateX(-1).translateZ(sphere.geometry.parameters.radius + cylinder.geometry.parameters.height + cylinder.geometry.parameters.height * cos(45));
        let front_right_leg = full_limb.clone().translateX(1).translateZ(sphere.geometry.parameters.radius + cylinder.geometry.parameters.height + cylinder.geometry.parameters.height * cos(45));
        let back_right_leg = full_limb.clone().translateX(1).translateZ(-(sphere.geometry.parameters.radius + cylinder.geometry.parameters.height + cylinder.geometry.parameters.height * cos(45)));
        let back_left_leg = full_limb.clone().translateX(-1).translateZ(-(sphere.geometry.parameters.radius + cylinder.geometry.parameters.height + cylinder.geometry.parameters.height * cos(45)));
        legs.add(front_left_leg);
        legs.add(front_right_leg);
        legs.add(back_right_leg);
        legs.add(back_left_leg);

        neck = full_limb.clone().rotateX(Math.PI).translateY(-12);

        let face = cylinder.clone().translateY(0.5).translateZ(1);
        face.scale.set(1, 1.5, 1);

        let nose = cylinder.clone().translateY(2.5).translateZ(0.75);
        nose.scale.set(0.5, 0.5, 0.5);
        let ear = half_limb.clone().translateY(-5.5).translateZ(0.5).rotateX(THREE.Math.degToRad(-90));
        ear.children[0].remove(ear.children[0].children[0]);
        ear.scale.set(0.25, 0.25, 0.25);
        ear.children[0].scale.set(1, 2, 1);
        ear.children[0].translateY(-2);
        let ears = new THREE.Group();

        left_ear = ear.clone();
        left_ear.translateX(-0.75);
        right_ear = ear.clone();
        right_ear.translateX(0.75);
        ears.add(left_ear);
        ears.add(right_ear);

        face.add(ears);

        head = new THREE.Group();
        head.add(face);
        head.add(nose);
        head.rotateX(THREE.Math.degToRad(90));

        neck.getObjectByName('lower_limb').getObjectByName('lower_joint').add(head);

        neck.translateY(8).translateZ((sphere.geometry.parameters.radius + cylinder.geometry.parameters.height + cylinder.geometry.parameters.height * cos(45)));
        neck.rotateX(THREE.Math.degToRad(-25));
        neck.getObjectByName('lower_limb').rotateX(THREE.Math.degToRad(15));
        head.rotateX(THREE.Math.degToRad(-15));

        upper_body = neck;
        let lower_body = legs;

        giraffe = torso;
        giraffe.add(upper_body);
        giraffe.add(lower_body);
        giraffe.scale.set(0.5, 0.5, 0.5);

        scene.add(giraffe);
    }

    function init_camera() {
        camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 2000);
        radius = 20;
        camera.position.x = radius * cos(15);
        camera.position.y = radius * sin(15);
        camera.lookAt(giraffe.position);
    }

    function init_renderer() {
        renderer = new THREE.WebGLRenderer();
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setClearColor(new THREE.Color(0x333333));
        document.body.appendChild(renderer.domElement);
    }

    function init_raycaster() {
        raycaster = new THREE.Raycaster();
    }

    function init_gui() {
        let gui = new dat.GUI();

        let joint_angles = {
            lower_neck_x: 15,
            lower_neck_z: 0,
            mid_neck: 0,
            upper_neck_x: 0,
            upper_neck_z: 0,
            right_ear: 0,
            left_ear: 0,
        };

        let joints = gui.addFolder("Joints");
        joints.add(joint_angles, "lower_neck_x", 0, 90).onChange(function (angle) {
            upper_body.rotateX(THREE.Math.degToRad(170.5 - angle - THREE.Math.radToDeg(upper_body.rotation.x)));
            render();
        });
        joints.add(joint_angles, "lower_neck_z", -45, 45).onChange(function (angle) {
            upper_body.rotateZ(THREE.Math.degToRad(-angle - THREE.Math.radToDeg(upper_body.rotation.z)));
            render();
        });
        joints.add(joint_angles, "mid_neck", -15, 15).onChange(function (angle) {
            neck.getObjectByName('lower_limb').rotateX(THREE.Math.degToRad(15 - THREE.Math.radToDeg(neck.getObjectByName('lower_limb').rotation.x) + angle));
            render();
        });
        joints.add(joint_angles, "upper_neck_x", -60, 15).onChange(function (angle) {
            head.rotateX(THREE.Math.degToRad(75 - angle - THREE.Math.radToDeg(head.rotation.x)));
            render();
        });
        joints.add(joint_angles, "upper_neck_z", -90, 90).onChange(function (angle) {
            head.rotateZ(THREE.Math.degToRad(-angle - THREE.Math.radToDeg(head.rotation.z)));
            render();
        });
        joints.add(joint_angles, "right_ear", 0, 90).onChange(function (angle) {
            right_ear.rotateX(THREE.Math.degToRad(-(90 - angle + THREE.Math.radToDeg(right_ear.rotation.x))));
            render();
        });
        joints.add(joint_angles, "left_ear", 0, 90).onChange(function (angle) {
            left_ear.rotateX(THREE.Math.degToRad(-(90 - angle + THREE.Math.radToDeg(left_ear.rotation.x))));
            render();
        });

        camera_angles = {
            azimuth: 0,
            elevation: 15
        };

        function cartesian() {
            camera.position.x = radius * cos(camera_angles.azimuth) * sin(90 - camera_angles.elevation);
            camera.position.y = radius * cos(90 - camera_angles.elevation);
            camera.position.z = radius * sin(camera_angles.azimuth) * sin(90 - camera_angles.elevation);
        }

        let camera_folder = gui.addFolder("Camera");
        camera_folder.add(camera_angles, "elevation", 15, 165).onChange(function () {
            cartesian();
            camera.lookAt(giraffe.position);
            render();
        });
        camera_folder.add(camera_angles, "azimuth", 0, 360).onChange(function () {
            cartesian();
            camera.lookAt(giraffe.position);
            render();
        });

        let animation_id;
        gui.add({Animation: false}, "Animation").onChange(function animation(animate) {
            if (animate) {
                animation_id = requestAnimationFrame(animation);
                for (let i = 0; i < legs.children.length; i++) {
                    if (i % 2 === 0) {
                        legs.children[i].rotation.x = THREE.Math.degToRad(30) * Math.sin(3 * THREE.Math.degToRad(animation_id) + Math.PI / 2);
                        legs.children[i].getObjectByName('lower_joint').rotation.x = THREE.Math.degToRad(22.5) * Math.sin(3 * THREE.Math.degToRad(animation_id) + Math.PI / 2) - Math.PI / 8;
                    } else {
                        legs.children[i].rotation.x = THREE.Math.degToRad(30) * Math.sin(3 * THREE.Math.degToRad(animation_id) + 3 * Math.PI / 2);
                        legs.children[i].getObjectByName('lower_joint').rotation.x = THREE.Math.degToRad(22.5) * Math.sin(3 * THREE.Math.degToRad(animation_id) + 3 * Math.PI / 2) - Math.PI / 8;
                    }
                }
                render();
            } else {
                cancelAnimationFrame(animation_id);
            }
        });
    }

    init_scene();
    init_camera();
    init_renderer();
    init_raycaster();
    init_gui();
}

function cos(degrees) {
    return Math.cos(THREE.Math.degToRad(degrees));
}

function sin(degrees) {
    return Math.sin(THREE.Math.degToRad(degrees));
}

function render() {
    raycaster.setFromCamera(mouse, camera);
    let intersections = raycaster.intersectObjects(scene.children);
    if (intersections.length > 0) {
        for (let intersected of intersections) {
            if (intersected.object.geometry.type === "PlaneGeometry") {
                giraffe.lookAt(intersected.point.multiplyScalar(-1))
            }
        }
    }
    renderer.render(scene, camera);
}

init();
render();