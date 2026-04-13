-- Create the faulty_equipment table to store equipment damage/fault reports
CREATE TABLE faulty_equipment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  time TIME NOT NULL,
  equipment_name VARCHAR(255) NOT NULL,
  issue_description TEXT NOT NULL,
  severity VARCHAR(50) NOT NULL,
  image_url TEXT,
  status VARCHAR(50) DEFAULT 'reported',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_faulty_equipment_user_id ON faulty_equipment(user_id);

ALTER TABLE faulty_equipment ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own faulty equipment reports"
  ON faulty_equipment FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own faulty equipment reports"
  ON faulty_equipment FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own faulty equipment reports"
  ON faulty_equipment FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own faulty equipment reports"
  ON faulty_equipment FOR DELETE
  USING (auth.uid() = user_id);
