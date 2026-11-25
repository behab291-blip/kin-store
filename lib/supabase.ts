
import { createClient } from "@supabase/supabase-js";

const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() || "";
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() || "";

export const configured =
  /^https:\/\/[a-zA-Z0-9-]+\.supabase\.co$/.test(url) && key.length > 0;

export const supabase = createClient(
  configured ? url : "https://placeholder.supabase.co",
  configured ? key : "placeholder-key"
);
