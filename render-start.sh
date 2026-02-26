#!/bin/sh
mkdir -p /data/.openclaw
mkdir -p /home/node/.openclaw
cat > /data/.openclaw/openclaw.json << 'ENDCONFIG'
{"gateway":{"mode":"local","trustedProxies":["10.0.0.0/8"],"controlUi":{"dangerouslyDisableDeviceAuth":true,"dangerouslyAllowHostHeaderOriginFallback":true,"allowInsecureAuth":true}}}
ENDCONFIG
cp /data/.openclaw/openclaw.json /home/node/.openclaw/openclaw.json
exec node openclaw.mjs gateway --allow-unconfigured --bind lan
