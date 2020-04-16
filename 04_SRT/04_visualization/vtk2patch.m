function [elemx,elemz] = vtk2patch(filename)
% vtk2patch - read mesh data from VTK file and prepare input for patch to
% visulize mesh.
%
%   Matthias Buecker, February 2020
%   Based on some elements of read_vtk by Mario Richtsfeld retrieved from
%   https://github.com/gpeyre/matlab-toolboxes/blob/master/toolbox_graph/read_vtk.m
%   in February 2020

fid = fopen(filename,'r');
if fid~=-1
    % Skip first 4 header line
    str = fgets(fid);
    str = fgets(fid);
    str = fgets(fid);
    str = fgets(fid);
    str = fgets(fid);
    % Read number of nodes from header
    nn = sscanf(str,'%*s %d %*s',1);

    % Read node coordinates
    coord = fscanf(fid,'%f %f %f',3*nn);
    coord = reshape(coord,3,nn)';
    coord = [(1:nn)',coord];
   
    % Read number of elements from next line
    str = fgets(fid);
    str = fgets(fid);
    ne = sscanf(str,'%*s %d %*s',1);
    
    % Read node coordinates
    elem = fscanf(fid,'%f %f %f %f',4*ne);
    elem = reshape(elem,4,ne)';
    elem(:,1) = [];
    elem = elem+1;
    
    % Prepare input matrices for patch
    ne = size(elem,1); % Number of elements
   
    elemind=coord(elem,1);
    % Matrix of x coordinates
    elemx(:,1)=coord(elemind,2);
    elemx=reshape(elemx,ne,3);
    elemx=elemx';
    % Matrix of z coordinates
    elemz(:,1)=coord(elemind,3);
    elemz=reshape(elemz,ne,3);
    elemz=elemz';

    fclose(fid);
end