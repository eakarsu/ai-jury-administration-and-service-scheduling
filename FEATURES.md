# Jury Administration and Service Scheduling

Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments.

## Implemented records

- **Jury Term**: name, court, term Number, start At, end At, clerk, status.
- **Juror Record**: name, juror Number, contact Reference, availability Notes, questionnaire At, status.
- **Juror Questionnaire**: title, received At, responses, evidence, clerk Notes, status.
- **Summons Batch**: title, batch Number, service At, location, instructions, issued At, status.
- **Juror Summons**: title, notice Reference, delivered At, status.
- **Service Request**: title, request Type, requested At, reason, requested Date, status.
- **Clerk Decision**: title, clerk, decided At, decision, rationale, status.
- **Juror Attendance**: title, served At, hours, travel Miles, attendance Evidence, status.
- **Juror Payment**: title, service Cents, travel Cents, paid At, receipt, status.
- **Operational Task**: title, owner, priority, start At, due At, done, notes, status.
- **Rule Version**: title, jurisdiction, version, effective At, expires At, source Url, requirement Text, status.
- **Document Requirement**: title, category, required By, source Reference, evidence Reference, review Notes, status.

## AI workflows

- Questionnaire completeness review: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Deferral request summary: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Accommodation request organization: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Service instruction draft: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Attendance discrepancy review: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Payment explanation draft: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Evidence completeness review: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.
- Operations handoff draft: source-linked draft, saved history, three real AI input suggestion styles and three complete fictional examples.

## Calculations

- Juror attendance compensation: Compute service and travel compensation from entered court rates; does not select jurors or execute payments.
- Jury Term evidence checklist: Check source presence against an explicitly supplied document list; reviewer assesses adequacy.
- Operational deadline queue: Compute overdue items from entered dates and completed flags; no external notifications.

## Workspace features

Role-based login and account management; validated create/edit/delete; required parent and sibling relationships; search and pagination; atomic JSON imports; CSV/JSON exports; optimistic concurrency; two independent human reviews; immutable source-text uploads with independent review; dated task calendar; aggregate reports; searchable audit trail; model catalog and administrator AI settings; configured HTTPS connectors with approval, idempotency and receipt checks.

## Integration boundaries

A finite working scope, not every conceivable feature. No production regulator, insurer, carrier, court, university or clinical integration is preconfigured. Source uploads support text/CSV/JSON/Markdown, not OCR/PDF parsing. AI produces drafts and cannot authorize clinical handling, adjudicate rights, select recipients or jurors, establish eligibility, certify regulatory compliance or send submissions. Live external execution requires a configured adapter and independent human approval of the current record. Calculations use supplied rules and units; example rules are fictional.
