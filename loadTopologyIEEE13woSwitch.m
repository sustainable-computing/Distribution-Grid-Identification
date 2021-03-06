function [nNodes, Y, mappingTerminal2Node, PhA, PhB, PhC, homesPerNode]=loadTopologyIEEE13woSwitch(DSSObj)
% FUNCTION loadTopology: parse the topology config file and use values
% to initialize variables

% INPUT: 
% DSSObj: OpenDSS COM Object used to obtain Ymatrix for the specified model

% OUTPUT:
% nNodes: the number of nodes
% Y: the three-phase nodal admittance matrix
% mappingTerminal2Node: mapping from bus names to node indices
% PhX: a logical vector showing whether a node is connected to phase X
% homesPerNode: the number of homes connected downstream of each node

%Reference the circuit for the interface
DSSCircuit = DSSObj.ActiveCircuit;

% Topology
NodeList = DSSCircuit.YNodeOrder;
nNodes = length(NodeList);

keySet = {'sourcebus.1', 'sourcebus.2', 'sourcebus.3',... %1-3
'650.1', '650.2', '650.3',...                             %4-6
'rg60.1', 'rg60.2', 'rg60.3',...                          %7-9
'633.1', '633.2', '633.3',...                             %10-12
'634.1', '634.2', '634.3',...                             %13-15 *
'680.1', '680.2', '680.3',...                             %16-18 *
'675.1', '675.2', '675.3',...                             %19-21 *
'645.2', '645.3',...                                      %22-23 *
'646.2', '646.3',...                                      %24-25 *
'684.1', '684.3',...                                      %26-27 *
'652.1',...,                                              %28 *
'611.3',...                                               %29 *
'632.1', '632.2', '632.3',...                             %30-32
'671.1', '671.2', '671.3'};%,...                             %33-35
%'692.1', '692.2', '692.3'};                               %36-38

valueArray = 1:nNodes;

mappingTerminal2Node = containers.Map(keySet,valueArray);

PhA = logical([0, 0, 0,...
    1, 0, 0,...
    1, 0, 0,...
    1, 0, 0,... 
    1, 0, 0,... 
    1, 0, 0,...
    1, 0, 0,... 
    0, 0,...
    0, 0,...
    1, 0,...
    1,...
    0,...
    1, 0, 0,...
    1, 0, 0,... 
    1, 0, 0]);

PhB = logical([0, 0, 0,...
    0, 1, 0,...
    0, 1, 0,...
    0, 1, 0,... 
    0, 1, 0,...
    0, 1, 0,...
    0, 1, 0,...
    1, 0,...
    1, 0,...
    0, 0,...
    0,...
    0,...
    0, 1, 0,...
    0, 1, 0,... 
    0, 1, 0]);

PhC = logical([0, 0, 0,...
    0, 0, 1,...
    0, 0, 1,...
    0, 0, 1,... 
    0, 0, 1,... 
    0, 0, 1,...
    0, 0, 1,...
    0, 1,...
    0, 1,...
    0, 1,...
    0,...
    1,...
    0, 0, 1,...
    0, 0, 1,... 
    0, 0, 1]);

% polyphase nodal admittace matrix
Y = constructYMatrix(DSSObj);

% Loads
LSRC = 0;
L650a = 0;
L650b = 0;
L650c = 0;

LREG  = 0;

L632a = 300;
L632b = 280;
L632c = 250;

L671a = 10;
L671b = 15;
L671c = 25;

L680a = 130;
L680b = 180;
L680c = 200;

L633a = 40;
L633b = 50;
L633c = 60;

L634a = 60;
L634b = 50;
L634c = 40;

L692a = 0;
L692b = 0;
L692c = 0;

L675a = 125;
L675b = 100;
L675c = 75;

L645b = 70;
L645c = 30;

L646b = 190;
L646c = 210;

L684a = 55;
L684c = 45;

L652a = 150;

L611c = 150;

homesPerNode = [LSRC, LSRC, LSRC,...
    L650a, L650b, L650c,...
    LREG, LREG, LREG,...
    L633a, L633b, L633c,... 
    L634a, L634b, L634c,...
    L680a, L680b, L680c,...
    L675a, L675b, L675c,...
    L645b, L645c,... 
    L646b, L646c,...
    L684a, L684c,... 
    L652a,... 
    L611c,...
    L632a, L632b, L632c,... 
    L671a, L671b, L671c];
%    L692a, L692b, L692c];
