#!/bin/bash

VPN_HOST="fvpn.nilu.no"
VPN_PORT="10443"

echo "Connecting to ${VPN_HOST}:${VPN_PORT} via SSO..."

sudo openfortivpn "${VPN_HOST}:${VPN_PORT}" --saml-login &
OFV_PID=$!

# Wait for openfortivpn's local SAML callback server (127.0.0.1:8020) before opening the browser.
# Use a passive check (kernel's listening-socket table) rather than an active connect —
# openfortivpn only accepts 5 connections total on this port, and a real TCP connection
# with no valid HTTP request burns one of those attempts before the browser gets there.
for i in $(seq 1 25); do
	ss -tln 2>/dev/null | grep -q ':8020[[:space:]]' && break
	sleep 0.2
done

xdg-open "https://${VPN_HOST}:${VPN_PORT}/remote/saml/start?redirect=1" >/dev/null 2>&1 &

wait "$OFV_PID"
