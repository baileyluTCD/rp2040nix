{
  pkgs,
  inputs,
  pname,
  ...
}:
pkgs.runCommandLocal pname {} ''
  mkdir -p $out/lib/${pname}

  cp -r ${inputs.pico-host-sdl-src}/* $out/lib/${pname}
''
