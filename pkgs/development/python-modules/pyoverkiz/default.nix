{ lib
, aiohttp
, attrs
, backoff
, backports-strenum
, boto3
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pyhumps
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, warrant-lite
}:

buildPythonPackage rec {
  pname = "pyoverkiz";
  version = "1.13.8";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "iMicknl";
    repo = "python-overkiz-api";
    rev = "refs/tags/v${version}";
    hash = "sha256-tvS7aPfBTs75Rq1WGslWDMv1pOTVt7MtwpXPRJtqbuk=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'pyhumps = "^3.0.2,!=3.7.3"' 'pyhumps = "^3.0.2"'
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    attrs
    backoff
    backports-strenum
    boto3
    pyhumps
    warrant-lite
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "pyoverkiz"
  ];

  meta = with lib; {
    description = "Module to interact with the Somfy TaHoma API or other OverKiz APIs";
    homepage = "https://github.com/iMicknl/python-overkiz-api";
    changelog = "https://github.com/iMicknl/python-overkiz-api/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
