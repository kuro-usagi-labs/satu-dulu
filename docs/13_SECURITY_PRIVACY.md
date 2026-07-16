# Security and Privacy

## Privacy posture

MVP is local-first:

- no account;
- no server upload;
- no third-party analytics;
- no ad SDK;
- PDF content stays on device;
- notification content is generated locally.

## Sensitive data

Potentially sensitive:

- project goals;
- income/revenue metrics;
- PDF documents;
- notes;
- external output URLs.

Do not log document names or note content in production diagnostics without explicit consent.

## File safety

- validate selected file before persistence;
- create unique stored filename;
- never overwrite existing file silently;
- do not follow arbitrary paths supplied by metadata;
- resolve relative paths under known app directory;
- clean partial files after failed import;
- protect destructive delete with confirmation.

## Database safety

- use parameterized queries through Drift;
- enable foreign keys;
- transactions for status switching and imports;
- schema migrations tested;
- no raw SQL from user input.

## Secrets

Repository must not contain:

- Apple `.p12`;
- `.mobileprovision`;
- signing passwords;
- App Store API key;
- personal Apple ID credentials;
- private repository tokens.

Use GitHub Actions Secrets and protected environments.

## Logging

Debug logs may contain IDs but should avoid:

- full PDF paths;
- PDF content;
- note content;
- financial values unless necessary;
- notification text.

## Backup/export

Future export should:

- require explicit user action;
- clearly state included files;
- optionally omit PDFs;
- produce a deterministic manifest;
- never upload automatically.

## Threat cases

1. Malicious/corrupt PDF causes crash → isolate reader failure and show error.
2. File provider returns temporary path → copy immediately.
3. Duplicate import wastes storage → optional checksum/duplicate prompt.
4. Signing secrets exposed in CI logs → no echo, use secrets, cleanup keychain.
5. User deletes project with linked PDF → preserve PDF or ask explicit choice; default preserve guide.
6. App interrupted during import → orphan cleanup on next launch.
