# Contributing Guidelines

## Issues

- Use the provided issue templates (Bug Report, Feature Request, Enhancement).
- Search for existing issues before opening a new one.
- Keep the title clear and concise. Describe the problem or request, not the solution.
- Include your OS and app version when reporting bugs.

## Pull Requests

- Every PR must reference a related issue (`Closes #<issue-no>`).
- One feature or fix per PR. Keep changes focused.
- Fill out the PR template completely, including a description of *why* the change is needed.
- Add screenshots or GIFs for any UI changes.

## Code

- Follow [Dart's Effective Dart style guide](https://dart.dev/guides/language/effective-dart/style).
- Run `flutter analyze` before submitting. No new warnings or errors allowed.
- Write tests for new logic where applicable.
- Do not introduce new dependencies without prior discussion in an issue.

## Commits

- Use clear, descriptive commit messages in English.
- Prefer small, atomic commits over large all-in-one changes.

## Branches

- Branch off from `development`.
- Use descriptive branch names and include issue number and description: `<feature/fix/enhancement>/<issue-number>-<description>`
