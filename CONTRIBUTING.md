# Contributing

Please keep the three proof blocks independently buildable:

```bash
lake build VlassisThomas
lake build Grunbaum
lake build Feige
```

Before opening a pull request, also run the three audit files listed in the
README and check that no proof placeholders or project-defined axioms were
introduced.  New dependencies should be pinned in `lake-manifest.json`.

Implementation details may live in internal modules, but cross-block imports
should go through the public entry points `VlassisThomas.lean`,
`Grunbaum.lean`, and `Feige.lean`.
