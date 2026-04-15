-- Create the packhouse_sanitation table to store sanitation records
CREATE TABLE packhouse_sanitation (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TIME NOT NULL,
  sanitation_type VARCHAR(255) NOT NULL,
  areas_sanitized TEXT,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_packhouse_sanitation_user_id ON packhouse_sanitation(user_id);

ALTER TABLE packhouse_sanitation ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own sanitation records"
  ON packhouse_sanitation FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own sanitation records"
  ON packhouse_sanitation FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own sanitation records"
  ON packhouse_sanitation FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own sanitation records"
  ON packhouse_sanitation FOR DELETE
  USING (auth.uid() = user_id);
