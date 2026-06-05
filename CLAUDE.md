# CLAUDE.md

Guidance for Claude Code when working in the **OweMe** repository.

## What this project is

OweMe is a Flutter app for tracking personal debts, credits, and payments between
people. It is primarily a **learning project**: the owner uses it to deliberately
practice Flutter, Clean Architecture, DDD, SOLID, and clean-code habits. Treat code
quality and the owner's understanding as first-class goals, not just shipping
features.

## How I should work here (working agreement)

This is a learning collaboration. Default working style:

- **Explain, then let the owner write.** For non-trivial logic, prefer guiding and
  reviewing over silently producing large diffs. The owner wants to build the skill,
  not just the feature. Boilerplate and scaffolding the owner already understands are
  fine for me to write directly.
- **Teach the "why".** When applying a principle (SOLID, DDD, a pattern), say *why*
  it applies here, and name the trade-off.
- **Be a reviewer.** Proactively flag bugs, smells, and inconsistencies — but as
  suggestions with reasoning, not edicts.
- **Pragmatic, not dogmatic.** Follow Clean Architecture and SOLID, but allow
  sensible shortcuts for a solo, local-first app. When taking a shortcut, *call it
  out as a trade-off* rather than pretending it's pure. Don't add ceremony
  (interfaces, layers, abstractions) that earns nothing here.
- **Ask before large refactors.** Confirm direction before sweeping changes.

## Architecture

Clean Architecture + BLoC, layer-first under `lib/src/`:

```
lib/src/
├── app/          # bootstrap + get_it DI setup (di/ has per-feature injection files)
├── core/         # cross-cutting: error/failures, presentation helpers, design system
├── domain/       # entities, value_objects, enums, repositories (interfaces),
│                 #   use_cases, validation/ (rules + failures)
├── data/         # data_sources (sqflite), models, adapters (model<->entity), repositories (impl)
└── presentation/ # blocs, containers, pages, widgets, drafts, mappers, validation_mappers
```

**Dependency rule:** dependencies point inward. `domain` depends on nothing;
`data` and `presentation` depend on `domain`. Never import Flutter or sqflite into
`domain`.

### Key patterns (follow these)

- **Errors:** functional, via `dartz` `Either<Failure, T>`. `Failure` hierarchy lives
  in `core/error/failures/`, with domain- and validation-specific failures under
  `domain/failures/` and `domain/validation/failures/`. Repositories wrap exceptions
  as `Failure`s — never let raw exceptions leak past the data layer.
- **Value objects:** immutable, `Equatable`, validated at construction. `Money` stores
  integer `cents` (never use `double` for money). Factories return
  `Either<Failure, T>` (e.g. `RecordAmount.create`).
- **Validation — CANONICAL PATTERN:** put validation in a **separated rules class**
  (e.g. `domain/validation/rules/record_amount_rules.dart`), a static class whose
  `validate(...)` returns `Failure?` (`null` = valid). The value object/entity factory
  calls it, AND form BLoCs call it directly for live per-keystroke validation — one
  shared source of truth. *Only* inline validation in the factory when it is a single
  check that is never used for live form validation.
  - NOTE: `FavoriteDescription` currently validates inline and is the odd one out;
    refactoring it to a rules class is a known cleanup (see Known work).
- **Failure → UI:** map domain failures to user-facing (Portuguese) strings via
  extensions in `presentation/validation_mappers/` (`uiMessage`). Keep UI strings out
  of the domain.
- **State management:** `flutter_bloc`. Events = user intents, States = UI snapshots.
  BLoCs call use cases; pages are wrapped by container widgets that provide the BLoC.
  Live form-field state uses `ValidatableFieldState<T, F>`.
- **DI:** `get_it`, configured in `app/di/`. BLoCs registered as `factory`; use cases
  and repositories as `lazySingleton`. Add new wiring to the matching per-feature
  injection file.
- **Persistence:** `sqflite`. `data/models/` `Model` base class with `toMap()` /
  `tableName`; `adapters/` convert between models and domain entities.

## Conventions

- Files `snake_case`; classes `PascalCase`; private members `_leadingUnderscore`.
- Prefer `const` constructors; use `sealed`/`abstract` for closed hierarchies and
  exhaustive `switch`.
- Lints: stock `flutter_lints` (see `analysis_options.yaml`). Keep `flutter analyze`
  clean.
- **Tests mirror `lib/src/` under `test/src/`.** Use `flutter_test` + `mocktail`,
  group with `group()`, descriptive `test()` names. Domain and data are well-tested;
  **presentation (BLoCs/pages/widgets) currently has no tests** — add BLoC tests when
  touching presentation logic.

## Commands

```bash
flutter pub get          # install deps
flutter run              # run the app
flutter test             # run all tests
flutter test test/src/domain/value_objects/money_test.dart   # single test file
flutter analyze          # static analysis / lints
```

## Git

**Commit messages** — Conventional Commits, lowercase imperative subject:

```
type(#issue): subject     # when there's an issue, e.g. feat(#14): add error mapping
type: subject             # when there's no issue, e.g. chore: tidy imports
```

- **Types:** `feat`, `fix`, `refactor`, `chore`, `docs`, `test`.
- **Scope** is the issue number in parens (`(#14)`), omitted when there is no issue.
  Do not use module names as scope.
- **Subject:** lowercase, imperative mood (`add x`, not `Add x` / `added x`).
- **Body:** include a short what/why body for non-trivial commits; subject-only is
  fine for small changes.
- **Do NOT add a `Co-Authored-By` trailer** (or any AI attribution) to commits.

**Branches** — `type/issue-desc`, issue number optional:

```
type/<issue>-<kebab-desc>   # with issue, e.g. feat/14-error-handling
type/<kebab-desc>           # no issue,  e.g. refactor/favorite-validation
```

Create an issue for substantial features/fixes; issue-less branches are fine for
small cleanups and exploration. Only commit or push when the owner asks.

## Known work / context

These are real items in the codebase (good candidates for paired tasks):

- **Error handling is the next-to-MVP item** (README roadmap). `DebtorRepositoryImpl`
  catches everything → `DefaultFailure` (has `//TODO: handle specific Failures`):
  should map specific sqflite exceptions to domain failures.
- `DebtorIdNotFoundFailure` is marked for renaming to something more specific.
- Unify validation: refactor `FavoriteDescription` to a separated rules class to
  match `RecordAmount`.
- No DB migration strategy yet (schema version hardcoded to 1).
- `provider` is in `pubspec.yaml` but unused.

## Owner notes

- Communication: English is fine; user-facing app strings are Portuguese (pt-BR).
- The owner (Jan) is the sole developer; this is a portfolio/learning project.
