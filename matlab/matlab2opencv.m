function [ ] = matlab2opencv( data, fileName, flag )
%MATLAB2OPENCV Save `variable` to yml/xml file 
% fileName: filename where the variable is stored
% flag: `a` for append, `w` for writing.
%   Detailed explanation goes here
file = fopen( fileName, 'w');
        fprintf( file, '%%YAML:1.0\n');
        
    for k = keys(data)
        variable_name = k{1};
        variable = data(k{1});

        [rows cols] = size(variable);

        % Write variable header
        fprintf( file, '%s: !!opencv-matrix\n', variable_name);
        fprintf( file, '    rows: %d\n', rows);
        fprintf( file, '    cols: %d\n', cols);
        fprintf( file, '    dt: d\n');
        fprintf( file, '    data: [ ');

        % Write variable data
        for i=1:rows*cols
            fprintf( file, '%.10f', variable(i));
            if (i == rows*cols), break, end
            fprintf( file, ', ');
            if mod(i,cols) == 0
                fprintf( file, '\n            ');
            end
        end

        fprintf( file, ']\n');


    end
fclose(file);
end