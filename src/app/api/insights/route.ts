import { NextRequest } from "next/server";
import { authorize } from "@/lib/api-auth";
import { prisma } from "@/lib/prisma";
import { records, errorResponse } from "@/lib/record-store";
import { recordMetadata, RequestError } from "@/lib/record-policy";
import { buildInsights, FEATURE_TITLES } from "@/lib/insights";
export const dynamic = "force-dynamic";
export async function GET(request: NextRequest) {
  try {
    await authorize();
    const entity = request.nextUrl.searchParams.get("entity") || Object.keys(recordMetadata)[0];
    if (!recordMetadata[entity]) throw new RequestError("Unknown entity", 404);
    const rows = await records(prisma, entity).findMany({ orderBy: [{ createdAt: "desc" }, { id: "desc" }], take: 500 });
    return Response.json(buildInsights(entity, rows as Record<string, unknown>[], FEATURE_TITLES));
  } catch (error) { return errorResponse(error); }
}
