{ lib
, python3Packages
, fetchFromGitHub
}:

python3Packages.buildPythonApplication rec {
  pname = "oterm";
  version = "0.1.22";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "ggozad";
    repo = "oterm";
    rev = "refs/tags/${version}";
    hash = "sha256-hRbPlRuwM3NspTNd3mPhVxPJl8zA9qyFwDGNKH3Slag=";
  };

  pythonRelaxDeps = [
    "pillow"
    "httpx"
  ];

  propagatedBuildInputs = with python3Packages; [
    textual
    typer
    python-dotenv
    httpx
    aiosql
    aiosqlite
    pyperclip
    packaging
    rich-pixels
    pillow
    aiohttp
  ];

  nativeBuildInputs = with python3Packages; [
    poetry-core
    pythonRelaxDepsHook
  ];

  pythonImportsCheck = [
    "oterm"
  ];

  # Tests require a HTTP connection to ollama
  doCheck = false;

  meta = with lib; {
    description = "A text-based terminal client for Ollama";
    homepage = "https://github.com/ggozad/oterm";
    changelog = "https://github.com/ggozad/oterm/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ suhr ];
    mainProgram = "oterm";
  };
}
