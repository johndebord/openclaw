#!/bin/sh
rm -f /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
mkdir -p /data/.openclaw /home/node/.openclaw
cat > /data/.openclaw/openclaw.json << ENDCONFIG
{
  "gateway": {
    "mode": "local",
    "trustedProxies": ["10.0.0.0/8"],
    "controlUi": {
      "dangerouslyDisableDeviceAuth": true,
      "dangerouslyAllowHostHeaderOriginFallback": true,
      "allowInsecureAuth": true
    }
  },
  "channels": {
    "whatsapp": {
      "enabled": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["${WHATSAPP_NUMBER}"]
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-6"
      }
    }
  }
}
ENDCONFIG
cp /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
exec node openclaw.mjs gateway --allow-unconfigured --bind lan
