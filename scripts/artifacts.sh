#! /bin/sh

mkdir -p artifacts

elm-make src/frontend/Page/Catalog.elm --output artifacts/Page-Catalog.js
elm-make src/frontend/Page/Context.elm --output artifacts/Page-Context.js
elm-make src/frontend/Page/DesignGuidelines.elm --output artifacts/Page-DesignGuidelines.js
elm-make src/frontend/Page/DocumentationFormat.elm --output artifacts/Page-DocumentationFormat.js
elm-make src/frontend/Page/NotFound.elm --output artifacts/Page-NotFound.js
elm-make src/frontend/Page/Package.elm --output artifacts/Page-Package.js
elm-make src/frontend/Page/PackageOverview.elm --output artifacts/Page-PackageOverview.js
elm-make src/frontend/Page/PreviewDocumentation.elm --output artifacts/Page-PreviewDocumentation.js

