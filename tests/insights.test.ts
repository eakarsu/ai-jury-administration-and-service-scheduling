import { test } from "node:test";
import assert from "node:assert/strict";
import { buildInsights, displayValue, FEATURE_TITLES } from "../src/lib/insights";
test("deterministic insights are labelled not AI-generated and preserve falsy values", () => {
  const r = buildInsights("Widget", [{ status: "Open", dueAt: "2020-01-01", count: 0, done: false, note: "" }, { status: "Open", count: 2 }], FEATURE_TITLES, new Date("2026-01-01T00:00:00Z"));
  assert.equal(r.aiGenerated, false); assert.equal(r.features.length, 3);
  assert.equal(r.features[0].sections.find(s => s.label === "Total records")?.value, 2);
  assert.equal(r.features[1].sections[0].value, 1);
  assert.equal(displayValue(0), "0"); assert.equal(displayValue(false), "false"); assert.equal(displayValue(""), "(empty)"); assert.equal(displayValue(null), "(empty)");
});
test("insights route, status filter and panel are wired", async () => {
  const fs = await import("node:fs");
  assert.ok(fs.readFileSync(new URL("../src/app/api/insights/route.ts", import.meta.url), "utf8").includes("authorize"));
  assert.ok(fs.readFileSync(new URL("../src/app/api/records/[entity]/route.ts", import.meta.url), "utf8").includes('params.get("status")'));
  assert.ok(fs.readFileSync(new URL("../src/components/DomainPage.tsx", import.meta.url), "utf8").includes("InsightsPanel"));
});
