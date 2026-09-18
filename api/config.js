export default function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store, max-age=0');
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  let supabaseUrl = (process.env.SUPABASE_URL || '').trim().replace(/^["']|["']$/g, '');
  try {
    if (supabaseUrl) {
      const parsed = new URL(supabaseUrl.startsWith('http') ? supabaseUrl : 'https://' + supabaseUrl);
      supabaseUrl = parsed.origin;
    }
  } catch (_) {}

  const supabaseAnonKey = (process.env.SUPABASE_ANON_KEY || '').trim().replace(/^["']|["']$/g, '');

  return res.status(200).json({
    supabaseUrl,
    supabaseAnonKey
  });
}
