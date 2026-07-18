# Data Model

## Database

Use Drift over SQLite.

Goals:

- type-safe query;
- migration support;
- reactive streams;
- testable in-memory database.

## Tables

### projects

```text
id TEXT PRIMARY KEY
name TEXT NOT NULL
short_goal TEXT NOT NULL
why_chosen TEXT
success_definition TEXT
target_revenue_minor INTEGER
status TEXT NOT NULL
icon_key TEXT
accent_key TEXT
primary_guide_document_id TEXT
start_date INTEGER
review_date INTEGER
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
archived_at INTEGER
```

Application-layer transaction enforces one focus. Tambahkan defensive database check melalui transaction query.

### sprints

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL
name TEXT NOT NULL
hypothesis TEXT
start_date INTEGER NOT NULL
end_date INTEGER NOT NULL
target_outputs INTEGER
success_criteria TEXT
status TEXT NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### daily_plans

```text
id TEXT PRIMARY KEY
sprint_id TEXT NOT NULL
plan_date INTEGER NOT NULL
required_outcome TEXT NOT NULL
low_energy_action TEXT
linked_guide_document_id TEXT
linked_guide_page INTEGER
note TEXT
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
UNIQUE(sprint_id, plan_date)
```

### sprint_closures — digabungkan ke schema v3

```text
id TEXT PRIMARY KEY
sprint_id TEXT NOT NULL UNIQUE
decision TEXT NOT NULL
evidence_summary TEXT
next_approach TEXT
next_sprint_id TEXT UNIQUE
replacement_project_id TEXT
closed_at INTEGER NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

`decision` hanya menerima `continueFocus`, `pivot`, atau `park`. Continue/Pivot
menautkan `next_sprint_id`; Park dapat menautkan `replacement_project_id`.
Conditional invariant divalidasi dalam repository transaction.

### daily_actions

```text
id TEXT PRIMARY KEY
daily_plan_id TEXT NOT NULL
position INTEGER NOT NULL
label TEXT NOT NULL
is_completed INTEGER NOT NULL DEFAULT 0
completed_at INTEGER
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
UNIQUE(daily_plan_id, position)
```

Domain validates position 0..2.

### ship_records

```text
id TEXT PRIMARY KEY
daily_plan_id TEXT NOT NULL UNIQUE
output_type TEXT NOT NULL
output_title TEXT NOT NULL
external_url TEXT
evidence_note TEXT
is_partial INTEGER NOT NULL DEFAULT 0
shipped_at INTEGER NOT NULL
```

### metric_entries

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL
entry_date INTEGER NOT NULL
outputs_count INTEGER NOT NULL DEFAULT 0
views INTEGER
clicks INTEGER
orders INTEGER
revenue_minor INTEGER
work_minutes INTEGER
note TEXT
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
UNIQUE(project_id, entry_date)
```

Money disimpan dalam minor unit integer.

### weekly_reviews

```text
id TEXT PRIMARY KEY
project_id TEXT NOT NULL
sprint_id TEXT
week_start INTEGER NOT NULL
week_end INTEGER NOT NULL
shipped_summary TEXT
important_result TEXT
worked_well TEXT
waste_or_blocker TEXT
decision TEXT NOT NULL
next_week_focus TEXT
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### guide_documents

```text
id TEXT PRIMARY KEY
original_file_name TEXT NOT NULL
display_title TEXT NOT NULL
stored_relative_path TEXT NOT NULL UNIQUE
file_size_bytes INTEGER NOT NULL
checksum TEXT
project_id TEXT
category TEXT NOT NULL
description TEXT
when_to_read TEXT
is_pinned INTEGER NOT NULL DEFAULT 0
page_count INTEGER NOT NULL
last_read_page INTEGER NOT NULL DEFAULT 1
last_opened_at INTEGER
imported_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
cleanup_needed INTEGER NOT NULL DEFAULT 0
```

### pdf_bookmarks

```text
id TEXT PRIMARY KEY
document_id TEXT NOT NULL
page_number INTEGER NOT NULL
created_at INTEGER NOT NULL
UNIQUE(document_id, page_number)
```

### pdf_notes

```text
id TEXT PRIMARY KEY
document_id TEXT NOT NULL
page_number INTEGER NOT NULL
content TEXT NOT NULL
created_at INTEGER NOT NULL
updated_at INTEGER NOT NULL
```

### notification_preferences

```text
id INTEGER PRIMARY KEY CHECK(id = 1)
morning_enabled INTEGER NOT NULL
after_work_enabled INTEGER NOT NULL
evening_enabled INTEGER NOT NULL
morning_minutes INTEGER NOT NULL
after_work_minutes INTEGER NOT NULL
evening_minutes INTEGER NOT NULL
time_zone_id TEXT NOT NULL
updated_at INTEGER NOT NULL
```

## Foreign key strategy

- enable foreign keys;
- cascade child records where safe;
- project delete defaults to archive;
- PDF delete cascades bookmarks and notes;
- physical file deletion handled repository/service layer.

## Migration policy

- schema version starts at 1;
- schema v3 menyatukan `sprint_closures` dengan tabel anti-lupa secara add-only;
- every schema change adds migration and migration test;
- never edit released migration history;
- backup data before destructive migration;
- production migration must be idempotent for one execution path.
