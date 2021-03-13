{ config, pkgs, ... }:

with pkgs;
let
  myPythonPackages = pythonPackages: with pythonPackages; [
    ipython
    requests
    pandas
  ];
  python-with-my-packages = python38.withPackages myPythonPackages;
in
  {
    environment.systemPackages = with pkgs; [
      python-with-my-packages
    ];
  }
