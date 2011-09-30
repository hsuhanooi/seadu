var CONTEXT = ( function () {
	var variables = {};
	var elements = {};

	var setVar = function (name, variable) {
		if (variable == null) {
			throw "variable " + name + " can not be null";
		}
		variables[name] = variable
	};
	
	var getVar = function (name) {
		return variables[name];
	};
	
	var setElement = function (name, element) {
		if (element == null) {
			throw "element " + name + " can not be null";	
		}
		elements[name] = element;	
	};
	
	var getElement = function (name) {
		return elements[name];	
	};
	
	// ///////////////////////////
	// Expose These As Public
	// ///////////////////////////
	
	var my = {};
	my.setVar = setVar
	my.getVar = getVar
	my.setElement = setElement;
	my.getElement = getElement;

	return my;
}() );