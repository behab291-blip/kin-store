
import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim().replace(/\/rest\/v1\/?$/, "") || "";
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() || "";

export const configured = Boolean(url && key && url.startsWith("https://"));

export const supabase = createClient(url, key, {
  db: {
    schema: "public",
  },
});
