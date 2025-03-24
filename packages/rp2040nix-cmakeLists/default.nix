{
  pkgs,
  pname,
  ...
}:
pkgs.runCommandLocal pname {} ''
  cp ${./CMakeLists.txt} $out
''
