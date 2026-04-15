-- Add chlorine and citrocide level columns to temperature_checks table
-- Run this migration to add support for tracking chemical levels

ALTER TABLE temperature_checks 
ADD COLUMN chlorine_level NUMERIC(6,2) DEFAULT NULL,
ADD COLUMN citrocide_level NUMERIC(6,2) DEFAULT NULL;

-- Update the table policy to allow updates including new columns
DROP POLICY "Users can update their own temperature checks" ON temperature_checks;

CREATE POLICY "Users can update their own temperature checks"
  ON temperature_checks FOR UPDATE
  USING (auth.uid() = user_id);
