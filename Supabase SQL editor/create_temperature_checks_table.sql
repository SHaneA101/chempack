-- Create the temperature_checks table to store daily equipment temperatures
CREATE TABLE temperature_checks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TIME NOT NULL,
  flumes_temp NUMERIC(6,2) NOT NULL,
  flooder_temp NUMERIC(6,2) NOT NULL,
  drying_tunnel_temp NUMERIC(6,2) NOT NULL,
  wax_tunnel_temp NUMERIC(6,2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_temperature_checks_user_id ON temperature_checks(user_id);

ALTER TABLE temperature_checks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own temperature checks"
  ON temperature_checks FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own temperature checks"
  ON temperature_checks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own temperature checks"
  ON temperature_checks FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own temperature checks"
  ON temperature_checks FOR DELETE
  USING (auth.uid() = user_id);
