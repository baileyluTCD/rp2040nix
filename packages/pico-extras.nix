{
  pkgs,
  inputs,
  pname,
  ...
}:
pkgs.runCommandLocal pname { } ''
  mkdir -p $out/lib/${pname}

  cp -r ${inputs.pico-extras-src}/* $out/lib/${pname}
''
