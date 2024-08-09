{
  lib,
  buildPythonPackage,
  fetchPypi,
  isPy27,
  pytest,
  pytest-cov-stub,
  nbval,
  jupyter-packaging,
  ipywidgets,
  numpy,
  six,
  traittypes,
}:

buildPythonPackage rec {
  pname = "ipydatawidgets";
  version = "4.3.5";
  format = "setuptools";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OU8kiVdlh8/XVTd6CaBn9GytIggZZQkgIf0avL54Uqg=";
  };

  nativeBuildInputs = [ jupyter-packaging ];

  setupPyBuildFlags = [ "--skip-npm" ];

  propagatedBuildInputs = [
    ipywidgets
    numpy
    six
    traittypes
  ];

  nativeCheckInputs = [
    pytest
    pytest-cov-stub
    nbval
  ];

  checkPhase = "pytest ipydatawidgets/tests";

  meta = {
    description = "Widgets to help facilitate reuse of large datasets across different widgets";
    homepage = "https://github.com/vidartf/ipydatawidgets";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ bcdarwin ];
  };
}
