{ pkgs, lib, ... }:
pkgs.stdenv.mkDerivation {
  name = "probe-rs-udev-rules";

  src = ./.;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/lib/udev/rules.d
    cp 69-probe-rs.rules $out/lib/udev/rules.d
  '';
}

