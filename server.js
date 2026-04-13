const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const twilio = require('twilio');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const {
  TWILIO_ACCOUNT_SID,
  TWILIO_AUTH_TOKEN,
  TWILIO_WHATSAPP_FROM,
  WHATSAPP_TO,
} = process.env;

if (!TWILIO_ACCOUNT_SID || !TWILIO_AUTH_TOKEN || !TWILIO_WHATSAPP_FROM || !WHATSAPP_TO) {
  console.warn('Warning: WhatsApp notification environment variables are not fully configured.');
}

const client = twilio(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN);

app.post('/send-whatsapp', async (req, res) => {
  const { message } = req.body;
  if (!message) {
    return res.status(400).json({ error: 'Missing message body.' });
  }
  if (!TWILIO_ACCOUNT_SID || !TWILIO_AUTH_TOKEN || !TWILIO_WHATSAPP_FROM || !WHATSAPP_TO) {
    return res.status(500).json({ error: 'WhatsApp configuration is incomplete.' });
  }

  try {
    const sent = await client.messages.create({
      body: message,
      from: TWILIO_WHATSAPP_FROM,
      to: WHATSAPP_TO,
    });
    return res.json({ sid: sent.sid });
  } catch (error) {
    console.error('WhatsApp send failed:', error);
    return res.status(500).json({ error: error.message || 'Failed to send WhatsApp notification.' });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`WhatsApp notification server running on http://localhost:${port}`);
});
