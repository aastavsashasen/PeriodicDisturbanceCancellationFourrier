% DH parameters describing the manipulator
dhparams = [0   	pi/2	0   	0;
            0	pi/2       0   0;
            0.5     -pi/2   0    0;
            0.5     0   0   0];

% create rigidbody tree
myrobot = rigidBodyTree('MaxNumBodies', 4, 'Dataformat', 'col');

% add first link
body1 = rigidBody('body1');
jnt1 = rigidBodyJoint('jnt1','revolute');
dhparams(1,:)
setFixedTransform(jnt1,dhparams(1,:),'mdh');
body1.Joint = jnt1;

body1.Mass = 0.5;
body1.CenterOfMass = [0 0 0];
body1.Inertia = [1 1 1 0 0 0];
addBody(myrobot,body1,'base')

% add the rest of the bodies
body2 = rigidBody('body2');
jnt2 = rigidBodyJoint('jnt2','revolute');
body3 = rigidBody('body3');
jnt3 = rigidBodyJoint('jnt3','revolute');
% this is Z/X plane (joint 3)
tool = rigidBody('tool');
jnt_ee = rigidBodyJoint('jnt_ee', 'fixed');
% add the rest of the transforms betwn the bodies
setFixedTransform(jnt2,dhparams(2,:),'mdh');
setFixedTransform(jnt3,dhparams(3,:),'mdh');
setFixedTransform(jnt_ee,dhparams(4,:),'mdh');

body2.Joint = jnt2;
body3.Joint = jnt3;
tool.Joint = jnt_ee;

body2.Mass = 1.0;
body2.CenterOfMass = [0.325 0 0];
body2.Inertia = [1 1 1 0 0 0];
body3.Mass = 1.0;
body3.CenterOfMass = [0.2175 0 0];
body3.Inertia = [1 1 1 0 0 0];
tool.Mass = 0.01;
tool.CenterOfMass = [0 0 0];
tool.Inertia = [1 1 1 0 0 0];

addBody(myrobot,body2,'body1')
addBody(myrobot,body3,'body2')
addBody(myrobot,tool,'body3')

% %f = figure
% % interactive visualization of Robot
% viz = interactiveRigidBodyTree(myrobot, "MarkerBodyName", "tool")
% x = 0.0;
% y = 0.0;
% z = 0.0;
% scatter3(x,y,z,'filled');

% extra variable needed.....
E_max = 1000;
E_max1 = 1000;
gamma = 0.1;
mf = 1;
mf1 = 1;
mf2 = 1;


