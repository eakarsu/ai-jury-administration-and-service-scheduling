export interface PageConfig {
  label: string;
  href: string;
  description: string;
  entities: string[];
  workflows: string[];
}

export interface EntityConfig {
  name: string;
  label: string;
  fields: Array<{ name: string; kind: "string" | "number" | "boolean" | "date" }>;
}

export interface WorkflowConfig {
  slug: string;
  title: string;
  description: string;
  prompt: string;
  fields: string[];
}

export const appConfig = {
  "slug": "ai-jury-administration-and-service-scheduling",
  "title": "Jury Administration and Service Scheduling",
  "tagline": "Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments.",
  "accent": "rose"
};
export const pages: PageConfig[] = [
  {
    "label": "Intake & registers",
    "href": "/registers",
    "description": "Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments.",
    "entities": [
      "JuryTerm",
      "JurorRecord",
      "JurorQuestionnaire"
    ],
    "workflows": [
      "questionnaire-completeness-review",
      "deferral-request-summary"
    ]
  },
  {
    "label": "Operational records",
    "href": "/workflow",
    "description": "Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments.",
    "entities": [
      "SummonsBatch",
      "JurorSummons",
      "ServiceRequest"
    ],
    "workflows": [
      "accommodation-request-organization",
      "service-instruction-draft"
    ]
  },
  {
    "label": "Review & delivery",
    "href": "/delivery",
    "description": "Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments.",
    "entities": [
      "ClerkDecision",
      "JurorAttendance",
      "JurorPayment"
    ],
    "workflows": [
      "attendance-discrepancy-review",
      "payment-explanation-draft"
    ]
  },
  {
    "label": "Tasks & requirements",
    "href": "/operations",
    "description": "Assignments, versioned rules and document requirements.",
    "entities": [
      "OperationalTask",
      "RuleVersion",
      "DocumentRequirement"
    ],
    "workflows": [
      "evidence-completeness-review",
      "operations-handoff-draft"
    ]
  }
];
export const entities: Record<string, EntityConfig> = {
  "JuryTerm": {
    "name": "JuryTerm",
    "label": "Jury Term",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "court",
        "kind": "string"
      },
      {
        "name": "termNumber",
        "kind": "string"
      },
      {
        "name": "startAt",
        "kind": "date"
      },
      {
        "name": "endAt",
        "kind": "date"
      },
      {
        "name": "clerk",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      }
    ]
  },
  "JurorRecord": {
    "name": "JurorRecord",
    "label": "Juror Record",
    "fields": [
      {
        "name": "name",
        "kind": "string"
      },
      {
        "name": "jurorNumber",
        "kind": "string"
      },
      {
        "name": "contactReference",
        "kind": "string"
      },
      {
        "name": "availabilityNotes",
        "kind": "string"
      },
      {
        "name": "questionnaireAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "JurorQuestionnaire": {
    "name": "JurorQuestionnaire",
    "label": "Juror Questionnaire",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurorRecordId",
        "kind": "string"
      },
      {
        "name": "receivedAt",
        "kind": "date"
      },
      {
        "name": "responses",
        "kind": "string"
      },
      {
        "name": "evidence",
        "kind": "string"
      },
      {
        "name": "clerkNotes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "SummonsBatch": {
    "name": "SummonsBatch",
    "label": "Summons Batch",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "batchNumber",
        "kind": "string"
      },
      {
        "name": "serviceAt",
        "kind": "date"
      },
      {
        "name": "location",
        "kind": "string"
      },
      {
        "name": "instructions",
        "kind": "string"
      },
      {
        "name": "issuedAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "JurorSummons": {
    "name": "JurorSummons",
    "label": "Juror Summons",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurorRecordId",
        "kind": "string"
      },
      {
        "name": "summonsBatchId",
        "kind": "string"
      },
      {
        "name": "noticeReference",
        "kind": "string"
      },
      {
        "name": "deliveredAt",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "ServiceRequest": {
    "name": "ServiceRequest",
    "label": "Service Request",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurorRecordId",
        "kind": "string"
      },
      {
        "name": "requestType",
        "kind": "string"
      },
      {
        "name": "requestedAt",
        "kind": "date"
      },
      {
        "name": "reason",
        "kind": "string"
      },
      {
        "name": "requestedDate",
        "kind": "date"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "ClerkDecision": {
    "name": "ClerkDecision",
    "label": "Clerk Decision",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "serviceRequestId",
        "kind": "string"
      },
      {
        "name": "clerk",
        "kind": "string"
      },
      {
        "name": "decidedAt",
        "kind": "date"
      },
      {
        "name": "decision",
        "kind": "string"
      },
      {
        "name": "rationale",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "JurorAttendance": {
    "name": "JurorAttendance",
    "label": "Juror Attendance",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurorRecordId",
        "kind": "string"
      },
      {
        "name": "servedAt",
        "kind": "date"
      },
      {
        "name": "hours",
        "kind": "number"
      },
      {
        "name": "travelMiles",
        "kind": "number"
      },
      {
        "name": "attendanceEvidence",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "JurorPayment": {
    "name": "JurorPayment",
    "label": "Juror Payment",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurorRecordId",
        "kind": "string"
      },
      {
        "name": "serviceCents",
        "kind": "number"
      },
      {
        "name": "travelCents",
        "kind": "number"
      },
      {
        "name": "paidAt",
        "kind": "date"
      },
      {
        "name": "receipt",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "OperationalTask": {
    "name": "OperationalTask",
    "label": "Operational Task",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "owner",
        "kind": "string"
      },
      {
        "name": "priority",
        "kind": "string"
      },
      {
        "name": "startAt",
        "kind": "date"
      },
      {
        "name": "dueAt",
        "kind": "date"
      },
      {
        "name": "done",
        "kind": "boolean"
      },
      {
        "name": "notes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "RuleVersion": {
    "name": "RuleVersion",
    "label": "Rule Version",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "jurisdiction",
        "kind": "string"
      },
      {
        "name": "version",
        "kind": "string"
      },
      {
        "name": "effectiveAt",
        "kind": "date"
      },
      {
        "name": "expiresAt",
        "kind": "date"
      },
      {
        "name": "sourceUrl",
        "kind": "string"
      },
      {
        "name": "requirementText",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  },
  "DocumentRequirement": {
    "name": "DocumentRequirement",
    "label": "Document Requirement",
    "fields": [
      {
        "name": "title",
        "kind": "string"
      },
      {
        "name": "category",
        "kind": "string"
      },
      {
        "name": "requiredBy",
        "kind": "date"
      },
      {
        "name": "sourceReference",
        "kind": "string"
      },
      {
        "name": "evidenceReference",
        "kind": "string"
      },
      {
        "name": "reviewNotes",
        "kind": "string"
      },
      {
        "name": "status",
        "kind": "string"
      },
      {
        "name": "juryTermId",
        "kind": "string"
      }
    ]
  }
};
export const workflows: WorkflowConfig[] = [
  {
    "slug": "questionnaire-completeness-review",
    "title": "Questionnaire completeness review",
    "description": "Questionnaire completeness review using selected jury term records and supplied evidence.",
    "prompt": "Questionnaire completeness review for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "deferral-request-summary",
    "title": "Deferral request summary",
    "description": "Deferral request summary using selected jury term records and supplied evidence.",
    "prompt": "Deferral request summary for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "accommodation-request-organization",
    "title": "Accommodation request organization",
    "description": "Accommodation request organization using selected jury term records and supplied evidence.",
    "prompt": "Accommodation request organization for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "service-instruction-draft",
    "title": "Service instruction draft",
    "description": "Service instruction draft using selected jury term records and supplied evidence.",
    "prompt": "Service instruction draft for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "attendance-discrepancy-review",
    "title": "Attendance discrepancy review",
    "description": "Attendance discrepancy review using selected jury term records and supplied evidence.",
    "prompt": "Attendance discrepancy review for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "payment-explanation-draft",
    "title": "Payment explanation draft",
    "description": "Payment explanation draft using selected jury term records and supplied evidence.",
    "prompt": "Payment explanation draft for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "evidence-completeness-review",
    "title": "Evidence completeness review",
    "description": "Evidence completeness review using selected jury term records and supplied evidence.",
    "prompt": "Evidence completeness review for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  },
  {
    "slug": "operations-handoff-draft",
    "title": "Operations handoff draft",
    "description": "Operations handoff draft using selected jury term records and supplied evidence.",
    "prompt": "Operations handoff draft for Jury Administration and Service Scheduling. Operational scope: Manage questionnaires, summons batches, deferral/accommodation requests, attendance and juror payments. Specific AI scope: Summarize requests for clerk review; do not profile or select jurors with AI. Produce an editable, source-linked draft for the responsible professional. Distinguish observations, missing evidence and proposed next actions. Do not invent facts, decide legal eligibility, authorize clinical release, profile individuals, submit externally or invent calibrated probabilities. Use supplied rule versions only. For translation preserve identifiers, dates, names and numbers and mark uncertain terms.",
    "fields": [
      "objective",
      "sourceContext",
      "applicableRules",
      "knownDiscrepancies",
      "constraints",
      "requestedOutput",
      "optionalReviewerNotes",
      "optionalAdditionalEvidence"
    ]
  }
];
export function findPage(href:string){return pages.find(p=>p.href===href);}
