{ lib
, stdenv
, fetchFromGitHub
, testers
, wrapGAppsHook
, bash-completion
, dbus
, dbus-glib
, fish
, gdk-pixbuf
, glib
, gobject-introspection
, gtk-layer-shell
, gtk3
, json-glib
, libgee
, libhandy
, libpulseaudio
, librsvg
, meson
, ninja
, pkg-config
, python3
, scdoc
, vala
, xvfb-run
, sassc
, pantheon
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "SwayNotificationCenter";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "ErikReider";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-7O+DX4uuncUqx5zEKQprZE6tctteT6NU01V2EBHiFqA=";
  };

  # build pkg-config is required to locate the native `scdoc` input
  depsBuildBuild = [ pkg-config ];

  nativeBuildInputs = [
    bash-completion
    # cmake # currently conflicts with meson
    fish
    glib
    gobject-introspection
    meson
    ninja
    pkg-config
    python3
    sassc
    scdoc
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    dbus
    dbus-glib
    gdk-pixbuf
    glib
    gtk-layer-shell
    gtk3
    json-glib
    libgee
    libhandy
    libpulseaudio
    librsvg
    pantheon.granite
    # systemd # ends with broken permission
  ];

  postPatch = ''
    chmod +x build-aux/meson/postinstall.py
    patchShebangs build-aux/meson/postinstall.py
  '';

  passthru.tests.version = testers.testVersion {
    package = finalAttrs.finalPackage;
    command = "${xvfb-run}/bin/xvfb-run swaync --version";
  };

  meta = with lib; {
    description = "Simple notification daemon with a GUI built for Sway";
    homepage = "https://github.com/ErikReider/SwayNotificationCenter";
    changelog = "https://github.com/ErikReider/SwayNotificationCenter/releases/tag/v${version}";
    license = licenses.gpl3;
    platforms = platforms.linux;
    mainProgram = "swaync";
    maintainers = with maintainers; [ berbiche pedrohlc ];
  };
})
