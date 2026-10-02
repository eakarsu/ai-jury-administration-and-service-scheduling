-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'MANAGER', 'ANALYST');

-- CreateTable
CREATE TABLE "User" (
    "active" BOOLEAN NOT NULL DEFAULT true,
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'ANALYST',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "actorId" TEXT,
    "actorName" TEXT,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT,
    "detail" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowAnalysis" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "workflow" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "input" JSONB NOT NULL,
    "evidence" JSONB NOT NULL,
    "evidenceHash" TEXT NOT NULL,
    "result" JSONB NOT NULL,
    "model" TEXT NOT NULL,
    "receipt" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkflowAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordReview" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RecordReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsageBucket" (
    "id" TEXT NOT NULL,
    "calls" INTEGER NOT NULL,

    CONSTRAINT "UsageBucket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IssuedCredential" (
    "token" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "assertion" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMP(3),

    CONSTRAINT "IssuedCredential_pkey" PRIMARY KEY ("token")
);

-- CreateTable
CREATE TABLE "DomainArtifact" (
    "id" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "contentHash" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "approvedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainArtifact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecordApproval" (
    "id" TEXT NOT NULL,
    "version" TEXT NOT NULL,

    CONSTRAINT "RecordApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DomainExecution" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "connectorId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "result" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DomainExecution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkSession" (
    "id" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "respondentId" TEXT NOT NULL,
    "subjectEntity" TEXT NOT NULL,
    "subjectId" TEXT NOT NULL,
    "questions" JSONB NOT NULL,
    "answers" JSONB NOT NULL,
    "currentQuestion" TEXT,
    "status" TEXT NOT NULL,
    "deadline" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WorkSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SessionMedia" (
    "id" TEXT NOT NULL,
    "sessionId" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "actorId" TEXT NOT NULL,
    "contentType" TEXT NOT NULL,
    "bytes" BYTEA NOT NULL,
    "contentHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SessionMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppSetting" (
    "id" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JuryTerm" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "court" TEXT NOT NULL,
    "termNumber" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3) NOT NULL,
    "clerk" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JuryTerm_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JurorRecord" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "jurorNumber" TEXT NOT NULL,
    "contactReference" TEXT NOT NULL,
    "availabilityNotes" TEXT NOT NULL,
    "questionnaireAt" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JurorRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JurorQuestionnaire" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurorRecordId" TEXT NOT NULL,
    "receivedAt" TIMESTAMP(3) NOT NULL,
    "responses" TEXT NOT NULL,
    "evidence" TEXT NOT NULL,
    "clerkNotes" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JurorQuestionnaire_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SummonsBatch" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "batchNumber" TEXT NOT NULL,
    "serviceAt" TIMESTAMP(3) NOT NULL,
    "location" TEXT NOT NULL,
    "instructions" TEXT NOT NULL,
    "issuedAt" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SummonsBatch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JurorSummons" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurorRecordId" TEXT NOT NULL,
    "summonsBatchId" TEXT NOT NULL,
    "noticeReference" TEXT NOT NULL,
    "deliveredAt" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JurorSummons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceRequest" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurorRecordId" TEXT NOT NULL,
    "requestType" TEXT NOT NULL,
    "requestedAt" TIMESTAMP(3) NOT NULL,
    "reason" TEXT NOT NULL,
    "requestedDate" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ServiceRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClerkDecision" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "serviceRequestId" TEXT NOT NULL,
    "clerk" TEXT NOT NULL,
    "decidedAt" TIMESTAMP(3) NOT NULL,
    "decision" TEXT NOT NULL,
    "rationale" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClerkDecision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JurorAttendance" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurorRecordId" TEXT NOT NULL,
    "servedAt" TIMESTAMP(3) NOT NULL,
    "hours" DOUBLE PRECISION NOT NULL,
    "travelMiles" DOUBLE PRECISION NOT NULL,
    "attendanceEvidence" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JurorAttendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JurorPayment" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurorRecordId" TEXT NOT NULL,
    "serviceCents" INTEGER NOT NULL,
    "travelCents" INTEGER NOT NULL,
    "paidAt" TIMESTAMP(3),
    "receipt" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JurorPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OperationalTask" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "owner" TEXT NOT NULL,
    "priority" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "dueAt" TIMESTAMP(3) NOT NULL,
    "done" BOOLEAN NOT NULL,
    "notes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OperationalTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RuleVersion" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "jurisdiction" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "effectiveAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "sourceUrl" TEXT NOT NULL,
    "requirementText" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RuleVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentRequirement" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "requiredBy" TIMESTAMP(3) NOT NULL,
    "sourceReference" TEXT NOT NULL,
    "evidenceReference" TEXT,
    "reviewNotes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'Draft',
    "juryTermId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "WorkflowAnalysis_workflow_createdAt_idx" ON "WorkflowAnalysis"("workflow", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "RecordReview_entity_entityId_version_actorId_key" ON "RecordReview"("entity", "entityId", "version", "actorId");

-- CreateIndex
CREATE INDEX "IssuedCredential_entity_entityId_createdAt_idx" ON "IssuedCredential"("entity", "entityId", "createdAt");

-- CreateIndex
CREATE INDEX "DomainArtifact_subjectEntity_subjectId_idx" ON "DomainArtifact"("subjectEntity", "subjectId");

-- CreateIndex
CREATE INDEX "WorkSession_respondentId_createdAt_idx" ON "WorkSession"("respondentId", "createdAt");

-- CreateIndex
CREATE INDEX "SessionMedia_sessionId_idx" ON "SessionMedia"("sessionId");

-- CreateIndex
CREATE INDEX "JuryTerm_createdAt_idx" ON "JuryTerm"("createdAt");

-- CreateIndex
CREATE INDEX "JurorRecord_createdAt_idx" ON "JurorRecord"("createdAt");

-- CreateIndex
CREATE INDEX "JurorRecord_juryTermId_idx" ON "JurorRecord"("juryTermId");

-- CreateIndex
CREATE INDEX "JurorQuestionnaire_createdAt_idx" ON "JurorQuestionnaire"("createdAt");

-- CreateIndex
CREATE INDEX "JurorQuestionnaire_juryTermId_idx" ON "JurorQuestionnaire"("juryTermId");

-- CreateIndex
CREATE INDEX "SummonsBatch_createdAt_idx" ON "SummonsBatch"("createdAt");

-- CreateIndex
CREATE INDEX "SummonsBatch_juryTermId_idx" ON "SummonsBatch"("juryTermId");

-- CreateIndex
CREATE INDEX "JurorSummons_createdAt_idx" ON "JurorSummons"("createdAt");

-- CreateIndex
CREATE INDEX "JurorSummons_juryTermId_idx" ON "JurorSummons"("juryTermId");

-- CreateIndex
CREATE INDEX "ServiceRequest_createdAt_idx" ON "ServiceRequest"("createdAt");

-- CreateIndex
CREATE INDEX "ServiceRequest_juryTermId_idx" ON "ServiceRequest"("juryTermId");

-- CreateIndex
CREATE INDEX "ClerkDecision_createdAt_idx" ON "ClerkDecision"("createdAt");

-- CreateIndex
CREATE INDEX "ClerkDecision_juryTermId_idx" ON "ClerkDecision"("juryTermId");

-- CreateIndex
CREATE INDEX "JurorAttendance_createdAt_idx" ON "JurorAttendance"("createdAt");

-- CreateIndex
CREATE INDEX "JurorAttendance_juryTermId_idx" ON "JurorAttendance"("juryTermId");

-- CreateIndex
CREATE INDEX "JurorPayment_createdAt_idx" ON "JurorPayment"("createdAt");

-- CreateIndex
CREATE INDEX "JurorPayment_juryTermId_idx" ON "JurorPayment"("juryTermId");

-- CreateIndex
CREATE INDEX "OperationalTask_createdAt_idx" ON "OperationalTask"("createdAt");

-- CreateIndex
CREATE INDEX "OperationalTask_juryTermId_idx" ON "OperationalTask"("juryTermId");

-- CreateIndex
CREATE INDEX "RuleVersion_createdAt_idx" ON "RuleVersion"("createdAt");

-- CreateIndex
CREATE INDEX "RuleVersion_juryTermId_idx" ON "RuleVersion"("juryTermId");

-- CreateIndex
CREATE INDEX "DocumentRequirement_createdAt_idx" ON "DocumentRequirement"("createdAt");

-- CreateIndex
CREATE INDEX "DocumentRequirement_juryTermId_idx" ON "DocumentRequirement"("juryTermId");

-- AddForeignKey
ALTER TABLE "JurorRecord" ADD CONSTRAINT "JurorRecord_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorQuestionnaire" ADD CONSTRAINT "JurorQuestionnaire_jurorRecordId_fkey" FOREIGN KEY ("jurorRecordId") REFERENCES "JurorRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorQuestionnaire" ADD CONSTRAINT "JurorQuestionnaire_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SummonsBatch" ADD CONSTRAINT "SummonsBatch_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorSummons" ADD CONSTRAINT "JurorSummons_jurorRecordId_fkey" FOREIGN KEY ("jurorRecordId") REFERENCES "JurorRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorSummons" ADD CONSTRAINT "JurorSummons_summonsBatchId_fkey" FOREIGN KEY ("summonsBatchId") REFERENCES "SummonsBatch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorSummons" ADD CONSTRAINT "JurorSummons_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceRequest" ADD CONSTRAINT "ServiceRequest_jurorRecordId_fkey" FOREIGN KEY ("jurorRecordId") REFERENCES "JurorRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceRequest" ADD CONSTRAINT "ServiceRequest_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClerkDecision" ADD CONSTRAINT "ClerkDecision_serviceRequestId_fkey" FOREIGN KEY ("serviceRequestId") REFERENCES "ServiceRequest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClerkDecision" ADD CONSTRAINT "ClerkDecision_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorAttendance" ADD CONSTRAINT "JurorAttendance_jurorRecordId_fkey" FOREIGN KEY ("jurorRecordId") REFERENCES "JurorRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorAttendance" ADD CONSTRAINT "JurorAttendance_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorPayment" ADD CONSTRAINT "JurorPayment_jurorRecordId_fkey" FOREIGN KEY ("jurorRecordId") REFERENCES "JurorRecord"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JurorPayment" ADD CONSTRAINT "JurorPayment_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OperationalTask" ADD CONSTRAINT "OperationalTask_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RuleVersion" ADD CONSTRAINT "RuleVersion_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentRequirement" ADD CONSTRAINT "DocumentRequirement_juryTermId_fkey" FOREIGN KEY ("juryTermId") REFERENCES "JuryTerm"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

