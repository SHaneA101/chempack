-- Create the equipment_checks table for hourly equipment monitoring
CREATE TABLE equipment_checks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  check_date DATE NOT NULL,
  check_hour INTEGER NOT NULL CHECK (check_hour >= 0 AND check_hour <= 23),
  equipment_id TEXT NOT NULL,
  equipment_item TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('ok', 'issue', 'not_checked')),
  note TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_equipment_checks_user_id ON equipment_checks(user_id);
CREATE INDEX idx_equipment_checks_date ON equipment_checks(check_date);
CREATE INDEX idx_equipment_checks_equipment_id ON equipment_checks(equipment_id);

-- Enable Row Level Security
ALTER TABLE equipment_checks ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own equipment checks
CREATE POLICY "Users can view their own equipment checks"
  ON equipment_checks FOR SELECT
  USING (auth.uid() = user_id);

-- Allow users to insert their own equipment checks
CREATE POLICY "Users can insert their own equipment checks"
  ON equipment_checks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Allow users to update their own equipment checks
CREATE POLICY "Users can update their own equipment checks"
  ON equipment_checks FOR UPDATE
  USING (auth.uid() = user_id);

-- Allow users to delete their own equipment checks
CREATE POLICY "Users can delete their own equipment checks"
  ON equipment_checks FOR DELETE
  USING (auth.uid() = user_id);
