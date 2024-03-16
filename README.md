# Escape game

An "escape room" game made for the PARP course at Warsaw University of Technology.

The project consists of:

- prototype made in Prolog
- full version made in Haskell

Note: The Prolog version is a working prototype, but it is not optimized for a pleasant gaming experience. For that, use the Haskell version.

Authors:

- Jan Kowalczewski
- Milan Wróblewski
- Wiktor Topolski

## Running the Prolog version

1. Follow instructions on the [official SWI-Prolog website](https://www.swi-prolog.org/) to install SWI-Prolog.
2. In the `prolog` directory run `make start` to start the game.

## Running the Haskell version

1. Follow instructions on the [official Haskell website](https://www.haskell.org/downloads/) to install GHC and Cabal.
2. In the `haskell` directory run:
   - `make build` to build the project
   - `make start` to build the project and start the game
