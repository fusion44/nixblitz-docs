# Setting up a NixBlitz

There are multiple ways to utilize the NixBlitz CLI to create a usable system configuration. The process to create and maintain a system is described in this document.

## Creating the system configuration

### Getting the NixBlitz CLI App

Currently the project is in its very early stages and we don't provide any pre compiled executables yet.
Refer to the developer documentation to build the latest version of the executable.

To test the compiled binary run `nixblitz --help` to peek at all available commands:

```bash
> nixblitz --help

A CLI interface to the RaspiBlitz project.

Usage: nixblitz [COMMAND]

Commands:
  gui     Opens the TUI in the given work dir
  init    Initializes a new system in the given work dir
  doctor  Analyze the system for common problems
  help    Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version
```

### Initializing the system config

We can utilize the init command to initialize the first system config.

```bash
> nixblitz init --help

Initializes a new system in the given work dir

Usage: nixblitz init [OPTIONS]

Options:
  -w, --work-dir <PATH>  The working directory to operate on [default: .]
  -f, --force            Whether to force overwrite existing files
  -h, --help             Print help
```

The CLI takes two arguments:

- `-w` is the working directory where the config should be generated. By default the CLI will use the current shell CWD aka: `.`.
  The CLI will refrain from generating anything in the given directory, if the directory in not completely empty.
- `-f` This flag will overwrite and files, no questions asked. Any change made since the initial config creation will be overwritten.

Now execute the init command in an empty directory: `nixblitz init -w /tmp/something`

The generated config will look like this:

```bash
 + /tmp/something
   + src
   │ + apps
   │ │-- bitcoind.nix                  # contains the bitcoin core config
   │ │-- blitz_api.nix                 # blitz api config
   │ │-- blitz_web.nix                 # blitz web ui config
   │ └-- lnd.nix                       # LND config
   │ └ configs                         # This folder contains user space config files
   │ + pi
   │ │-- configuration.nix             # config when running on a PI
   │ └-- hardware-configuration.nix    # hardware config when running on a PI
   │ + vm
   │ │-- configuration.nix             # config when running in a VM
   │ └-- hardware-configuration.nix    # hardware config when running in a VM
   │ - configuration.common.nix        # the basic configuration file
   │ - flake.nix                       # the main flake file that contains the system configuration
   └-- nix_base_config.json            # the json file where all the configuration is stored for the basic system config
   - flake.nix                         # this flake file provides a development shell with everything necessary to run the config
   - justfile                          # a command runner with a few predefined helper commands
```

NixBlitz generates all the `*.nix` files automatically. Any changes will be overwritten. The options are
read from the `*.json` files. The json files can be edited and will reflect in changed nix files when the configuration
is applied.

:::warning
Some functionality described here is not yet implemented or contains bugs.
:::
:::info
From here on the options how to proceed on a number of factors:

- host operating system
- target hardware
- user proficiency with using the command line

We'll describe some of the options in detail below.
:::
