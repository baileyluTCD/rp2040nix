{
  inputs,
  pkgs,
  pname,
  ...
}:
# Build the full pico sdk with all submodules
pkgs.pico-sdk.overrideAttrs (o: {
  inherit pname;
  version = "2.1.1";
  src = pkgs.runCommandLocal "pico-sdk-source" {} ''
    cp -r ${inputs.pico-sdk-src} $out
  '';
})
