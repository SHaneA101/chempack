# Faulty Equipment Reporting - Setup Instructions

## Database Setup
1. Run the SQL migration in `create_faulty_equipment_table.sql` in your Supabase SQL editor
2. This creates the `faulty_equipment` table with all necessary fields and RLS policies

## Supabase Storage Setup
The faulty equipment page requires a storage bucket for equipment images:

### Create the Storage Bucket

1. Go to your Supabase project dashboard
2. Navigate to **Storage** → **Buckets**
3. Click **Create a new bucket**
4. Name it: `equipment-images`
5. Set it to **Public** (so images can be publicly accessed)
6. Click **Create bucket**

### Set Storage Policies (Optional but recommended)

Add RLS policies to allow users to upload their own images:

```sql
-- Create policy for inserting images
CREATE POLICY "Users can upload equipment images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'equipment-images' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Create policy for viewing images
CREATE POLICY "Equipment images are publicly viewable"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'equipment-images');
```

## Features

- **Equipment Name**: Name/identifier of the faulty equipment
- **Severity Levels**: Critical, High, Medium, Low
- **Photo Upload**: Capture images directly from phone/tablet camera
- **Issue Description**: Detailed description of the problem
- **WhatsApp Alert**: Automatic alert sent when equipment is reported
- **Status Tracking**: Reports marked as "reported" and can be updated

## WhatsApp Alert Format

When equipment is reported, a WhatsApp message is sent with:
- Severity level
- Equipment name
- Date and time
- Full problem description
- Notification that photo was uploaded (if included)

## Mobile Usage

On mobile devices (phone/tablet), the file input will allow:
- Taking a photo with the device camera
- Selecting from the device photo gallery
- Works on iOS and Android
