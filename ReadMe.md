# Bug Report

The behavior of the nix flake for `marlowe-cardano` has recently changed.

Formerly, a flake like [failure/flake.nix](failure/flake.nix) would successfully evaluate. Now it results following error:

```console
error: attempt to call something which is not a function but a set

       at /nix/store/f5hpakva8qi9m7aq76xppsj74wcq98i2-source/src/lib/l.nix:211:9:

          210|       if l.pathExists path then
          211|         import path args
             |         ^
          212|       else
```

For reference, the old behavior is demonstrated to succeed in [success/flake.nix](success/flake.nix).
