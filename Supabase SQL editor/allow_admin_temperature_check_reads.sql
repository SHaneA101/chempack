-- Allow admins to read every temperature check record for company-wide charts.
-- Run this after the existing temperature_checks table migration.

DROP POLICY IF EXISTS "Admins can view all temperature checks" ON temperature_checks;

CREATE POLICY "Admins can view all temperature checks"
  ON temperature_checks FOR SELECT
  USING (
    COALESCE(
      auth.jwt() -> 'user_metadata' ->> 'role',
      auth.jwt() -> 'app_metadata' ->> 'role'
    ) = 'admin'
  );
