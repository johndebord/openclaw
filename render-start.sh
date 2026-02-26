#!/bin/sh
mkdir -p /data/.openclaw /home/node/.openclaw

if [ ! -f /data/.openclaw/openclaw.json ]; then
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
      "userTimezone": "America/Chicago",
      "model": {
        "primary": "anthropic/claude-sonnet-4-20250514",
        "fallbacks": ["anthropic/claude-opus-4-6"]
      },
      "subagents": {
        "model": {
          "primary": "anthropic/claude-haiku-3-5-20241022",
          "fallbacks": ["anthropic/claude-sonnet-4-20250514"]
        }
      }
    }
  }
}
ENDCONFIG
fi

cp /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
exec node openclaw.mjs gateway --allow-unconfigured --bind lan
