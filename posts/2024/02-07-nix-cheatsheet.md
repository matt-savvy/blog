%{
  title: "A Nix Cheatsheet",
  author: "Matt",
  tags: ~w(nix),
  description: "A quick reference for some Nix know-how"
}
---

**List Channels**

You might not even have any userspace channels.

```
# userspace channels
nix-channel --list

# root
sudo -i nix-channel --list
```

**Update channels**
```
# userspace channels
nix-channel --update

# root
sudo -i nix-channel --update
```

**Adding / replacing channels**

You probably only really want to do this if you are going from one stable version to the next.
```
# root
sudo -i nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
```

[Nix Channel Status](https://status.nixos.org/)

## Managing Packages

**Install**
```
nix-env -iA nixpkgs.<packagename>
```
**List**
```
nix-env -q
```
**Uninstall**
```
nix-env -e nixpkgs.<packagename>
```

## Nix Shell

**Basic Shell Template**
```nix
{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    ..
  ];
  SOME_ENV_VAR = "...";
  SOME_OTHER_ENV_VAR="...";
}
```

**Activate Shell**
```
# in dir with a default.nix
nix-shell

# otherwise, specify file with shell
nix-shell <filename>

# shell with package/packages
nix-shell -p lua

# shell with package in "pure" mode
nix-shell -p lua --pure
```

Pure mode means that other packages in your current env will not be available.

