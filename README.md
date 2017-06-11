# [package.frelm.org][altpkg]

The source code for an alternative website for Elm packages.

This is the source code for an [alternative package repository][altpkg], which
differs from the [pofficial repository][pkg] in that it permits "native" or "kernel"
modules to be published, as well as "effects" modules.

It has been possible to install such packages using [elm-github-install][egi],
but no central repository has previously existed to help with discovering
and browsing such modules. That is the niche which [package.frelm.org][altpkg]
is intended to fill.

[egi]: https://github.com/gdotdesign/elm-github-install
[altpkg]: https://package.frelm.org/
[pkg]: http://package.elm-lang.org/

## Reliability

The official [Elm package website][pkg] provides important guarantees of
reliability which [package.frelm.org][altpkg] cannot. To quote from the
documentation for the official package site:

> All community packages are written entirely in Elm, so all the things that make
  your apps reliable are helping make packages reliable.

> A small set of packages provide access to
  [The Web Platform](https://platform.html5.org/). These packages are managed
  by @elm-lang to ensure that (1) the APIs are exposed in a way that makes
  sense for Elm and (2) they are carefully vetted to make sure the underlying
  JS code is stable. We cover a decent amount of The Web Platform now, but you
  can always use [ports][] if something is not covered yet!

And, to provide further context, the official package website will provide this
explanation if you try to publish a package with "native" code:

> Elm compiles to JavaScript right now, but that may not always be true. For the
  long-term health of our package ecosystem, as many packages as possible should
  be written in Elm. This definitely means we will grow a bit slower, but I am
  willing to pay that cost if it leads to a better community and ecosystem!

> Point is: Use ports to talk to JS libraries. If you want that JS library as an
  Elm package, rewrite it in Elm.

> Now there are a shrinking number of cases where you cannot write the package"
  entirely in Elm. The @elm-lang organization on GitHub is meant to own any Web"
  Platform APIs. So if you are wondering how to make bindings to a Web Platform"
  library for vibration (for example) come talk to folks on [elm-dev][] about it.

> There is no guarantee that there will be easy contributions that will make it"
  happen quickly, but poor communication definitely makes things more difficult."

[ports]: https://guide.elm-lang.org/interop/javascript.html#ports
[elm-dev]: https://groups.google.com/forum/#!forum/elm-dev>

To take full advantage of these guarantees, you would need to use only packages
from the official package website, and avoid packages published using this
alternative package manager.
