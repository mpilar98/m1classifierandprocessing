
%Substitute values in data array
%returns a data grid mapout identical to the input data grid, except that each element of Z 
%with a value contained in the vector oldcode is replaced by the corresponding element of the 
%vector newcode.
%see corresponding matlab function (http://www.mathworks.com/help/toolbox/map/ref/changem.html)
function mapout = changem(Z, newcode, oldcode)
DEBUG = 0;
if DEBUG
	fprintf('Changem %d/%d\n', numel(newcode), numel(Z));
end
mapout = Z;
for i = 1:numel(oldcode)
	if DEBUG
		fprintf('Changem %d/%d\n', i, numel(oldcode));
	end
	mapout(find(Z == oldcode(i))) = newcode(i);
end

end

