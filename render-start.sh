#!/bin/sh
rm -f /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
mkdir -p /data/.openclaw /home/node/.openclaw
cat > /data/.openclaw/openclaw.json << 'ENDCONFIG'
{
  "gateway": {
    "mode": "local",
    "trustedProxies": ["10.0.0.0/8"],
    "controlUi": {
      "dangerouslyDisableDeviceAuth": true,
      "dangerouslyAllowHostHeaderOriginFallback": true,
      "allowInsecureAuth": true
    }
  }
}
ENDCONFIG
cp /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
exec node openclaw.mjs gateway --allow-unconfigured --bind lan
