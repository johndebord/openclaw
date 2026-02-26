#!/bin/sh
mkdir -p /data/.openclaw
cat > /data/.openclaw/openclaw.json << 'ENDCONFIG'
{"gateway":{"mode":"local","controlUi":{"dangerouslyDisableDeviceAuth":true,"dangerouslyAllowHostHeaderOriginFallback":true}}}
ENDCONFIG
exec node openclaw.mjs gateway --allow-unconfigured --bind lan
