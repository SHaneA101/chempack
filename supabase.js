import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm';

const SUPABASE_URL = 'https://jckquhdvdzkzcoppbduz.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impja3F1aGR2ZHpremNvcHBiZHV6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ5NjY4MDQsImV4cCI6MjA5MDU0MjgwNH0.lxnihW7rVQtTqsOeYjJMQti6xh--KcAo6OwH8BC7RYI';

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

export async function getSessionUser() {
  const { data, error } = await supabase.auth.getSession();
  if (error) {
    return null;
  }
  return data?.session?.user ?? null;
}

export async function redirectToLoginIfNotAuthenticated() {
  const user = await getSessionUser();
  if (!user) {
    window.location.href = 'index.html';
  }
  return user;
}
