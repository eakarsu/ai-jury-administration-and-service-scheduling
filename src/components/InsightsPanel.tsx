"use client";
import { useEffect, useState } from "react";
import { buildInsights, displayValue, type InsightFeature } from "@/lib/insights";
type Payload = ReturnType<typeof buildInsights>;
export default function InsightsPanel({ entity }: { entity: string }) {
  const [data, setData] = useState<Payload | null>(null);
  const [error, setError] = useState("");
  useEffect(() => { let active = true;
    fetch(`/api/insights?entity=${encodeURIComponent(entity)}`).then(async r => { const d = await r.json().catch(() => null); if (!r.ok || !d) throw new Error(d?.error || "Insights unavailable"); return d as Payload; })
      .then(d => { if (active) { setData(d); setError(""); } }).catch(e => { if (active) setError(e instanceof Error ? e.message : "Insights unavailable"); });
    return () => { active = false; }; }, [entity]);
  return <section aria-label="Deterministic insights" className="space-y-3 rounded-xl border bg-slate-50 p-4">
    <h3 className="font-semibold">Deterministic insights</h3>
    <p className="text-xs text-slate-600">Deterministic fallback (not AI-generated) · aiGenerated: false · computed from this workspace&apos;s own records. No provider call is made.</p>
    {error ? <p role="alert" className="text-sm">{error}</p> : null}
    {!data && !error ? <p className="text-sm">Loading insights…</p> : null}
    {data?.features.map((f: InsightFeature) => <div key={f.id} className="rounded border bg-white p-3">
      <h4 className="text-sm font-semibold">{f.title}</h4><p className="text-sm text-slate-600">{f.summary}</p>
      <dl className="mt-2 grid gap-2 sm:grid-cols-2">{f.sections.map(s => <div key={s.label}><dt className="text-xs font-semibold uppercase tracking-wide text-slate-500">{s.label}</dt><dd className="text-sm">{displayValue(s.value)}</dd></div>)}</dl>
    </div>)}
  </section>;
}
