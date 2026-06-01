# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Dartpedia is a CLI tool built while following the [official Dart tutorial](https://dart.dev/learn/tutorial). It queries Wikipedia articles from the terminal.

## Commands

All commands must be run from inside the `cli/` directory.

```bash
# Run the CLI
dart run bin/cli.dart search <article>
dart run bin/cli.dart version
dart run bin/cli.dart help

# Run all tests
dart test

# Run a single test file
dart test test/cli_test.dart

# Analyze (lint)
dart analyze

# Format code
dart format .

# Install dependencies
dart pub get
```

## Architecture

The project is a single Dart package under `cli/`:

- `bin/cli.dart` — entry point; parses CLI arguments and dispatches to functions (`main`, `searchWikipedia`, `printUsage`)
- `lib/cli.dart` — library entry point (currently a stub with `calculate()`); public API would go here
- `test/cli_test.dart` — tests against `lib/cli.dart` using the `test` package

The CLI follows a manual dispatch pattern: `main()` checks `arguments.first` with if/else and calls the appropriate function. `searchWikipedia()` handles both the case where the user provides the article title as arguments and the interactive case (prompts via `stdin`).
