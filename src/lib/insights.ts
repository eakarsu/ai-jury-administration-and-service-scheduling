// Deterministic insights over this workspace's own records.
// No provider call is made here; results are labelled aiGenerated:false.
export type InsightSection = { label: string; value: string | number | boolean | null };
export type InsightFeature = { id: string; title: string; summary: string; sections: InsightSection[] };
export const INSIGHT_LABEL = "Deterministic fallback (not AI-generated)";
const DONE = new Set(["done","closed","approved","complete","completed","paid","served"]);
export function buildInsights(entity: string, rows: Record<string, unknown>[], titles: [string,string,string], now = new Date()) {
  const total = rows.length;
  const statusCounts = new Map<string, number>();
  let pastDue = 0, emptyCells = 0, falseFlags = 0, numericTotal = 0, numericField = "";
  for (const row of rows) {
    const status = String(row.status ?? "");
    if (status) statusCounts.set(status, (statusCounts.get(status) ?? 0) + 1);
    const isDone = DONE.has(status.toLowerCase());
    for (const [key, value] of Object.entries(row)) {
      if (value === null || value === undefined || value === "") emptyCells += 1;
      if (value === false) falseFlags += 1;
      if (!numericField && typeof value === "number" && Number.isFinite(value)) numericField = key;
      if (key === numericField && typeof value === "number") numericTotal += value;
      if (!isDone && /(At|Date)$/.test(key) && typeof value === "string") { const t = Date.parse(value); if (!Number.isNaN(t) && t < now.getTime()) pastDue += 1; }
    }
  }
  const open = rows.filter(r => !DONE.has(String(r.status ?? "").toLowerCase())).length;
  const topStatus = [...statusCounts.entries()].sort((a,b)=>b[1]-a[1])[0];
  const features: InsightFeature[] = [
    { id: "status-overview", title: titles[0], summary: `Status mix for ${total} ${entity} record(s) in this workspace.`, sections: [
      { label: "Total records", value: total }, { label: "Open records", value: open },
      { label: "Most common status", value: topStatus ? topStatus[0] : null }, { label: "Most common status count", value: topStatus ? topStatus[1] : 0 } ] },
    { id: "due-watch", title: titles[1], summary: "Records whose date fields have passed while not in a closed status.", sections: [
      { label: "Past-due date fields (open records)", value: pastDue }, { label: "Open records", value: open }, { label: "Total records", value: total } ] },
    { id: "completeness", title: titles[2], summary: "Empty and false values are counted, never hidden.", sections: [
      { label: "Empty cells", value: emptyCells }, { label: "False flags", value: falseFlags },
      { label: numericField ? `Sum of ${numericField}` : "Numeric total", value: numericTotal }, { label: "Total records", value: total } ] },
  ];
  return { entity, aiGenerated: false as const, source: "deterministic-fallback", label: INSIGHT_LABEL, generatedAt: now.toISOString(), features };
}
export function displayValue(value: string | number | boolean | null): string {
  if (value === null || value === undefined || value === "") return "(empty)";
  return String(value);
}

export const FEATURE_TITLES: [string, string, string] = ["Questionnaire completeness watch", "Deferral & service-request watch", "Attendance & payment watch"];
