{ stdenv
, autoreconfHook
, pkgconfig
, makeWrapper
, bison
, ncurses
, libevent
}:

let
  bashCompletion = builtins.fetchGit {
    url = "https://github.com/imomaliev/tmux-bash-completion.git";
    name = "tmux-bash-completion";
  };
in
stdenv.mkDerivation rec {
  pname = "tmux";
  version = "git";

  outputs = [ "out" "man" ];

  src = builtins.fetchGit {
    url = "https://github.com/tmux/tmux.git";
    name = "tmux-git";
    #ref = "7019937b52488a726b85c5cdfc4616532fd620d1";
  };

  nativeBuildInputs = [
    pkgconfig
    autoreconfHook
    bison
  ];

  buildInputs = [
    ncurses
    libevent
    makeWrapper
  ];

  postInstall = ''
    mkdir -p $out/share/bash-completion/completions
    cp -v ${bashCompletion}/completions/tmux $out/share/bash-completion/completions/tmux
  '';

  meta = {
    homepage = "https://github.com/tmux/tmux";
    description = "A terminal multiplexer";
  };
}

