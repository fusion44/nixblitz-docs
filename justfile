# Serve the documentation locally
serve:
  #!/usr/bin/env bash
  yarn start

# Build the documentation files
build:
  #!/usr/bin/env bash
  yarn build

# Update all documentation
upgrade:
  #!/usr/bin/env bash
  yarn upgrade

# Format the markdown files
format:
  #!/usr/bin/env bash
  prettier -w .
  alejandra -e .node_modules/ .
