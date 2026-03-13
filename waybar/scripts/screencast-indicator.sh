#!/usr/bin/env bash

set -euo pipefail

CACHE_FILE="/tmp/waybar-screencast-indicator-active"
GRACE_SECONDS=45

if ! command -v pw-dump >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  printf '{"text":"","tooltip":false,"class":[]}\n'
  exit 0
fi

data="$(pw-dump 2>/dev/null || true)"
if [[ -z "${data}" ]]; then
  printf '{"text":"","tooltip":false,"class":[]}\n'
  exit 0
fi

active="$(
  jq -e '
    (
      [
        .[]
        | select(.type == "PipeWire:Interface:Client")
        | select(
            (.info.props["application.name"] // "") == "xdg-desktop-portal-wlr"
            or (.info.props["application.name"] // "") == "xdg-desktop-portal"
          )
        | .id
      ] as $portal_clients
      |
      [
        .[]
        | select(.type == "PipeWire:Interface:Node")
        | .info.props as $props
        | select($props["client.id"] != null)
        | select(($portal_clients | index($props["client.id"])) != null)
        | select(($props["media.class"] // "") | test("Video"))
      ]
      | length > 0
    )
    or
    (
      [
        .[]
        | select(.type == "PipeWire:Interface:Node")
        | .info.props as $props
        | select(($props["media.class"] // "") == "Stream/Input/Video")
        | select(
            ($props["node.name"] // "") == "teams-for-linux"
            or ($props["media.name"] // "") == "webrtc-consume-stream"
          )
      ]
      | length > 0
    )
  ' >/dev/null <<< "${data}" && echo yes || echo no
)"

if [[ "${active}" == "yes" ]]; then
  date +%s > "${CACHE_FILE}"
else
  now="$(date +%s)"
  last_seen=0
  if [[ -f "${CACHE_FILE}" ]]; then
    last_seen="$(cat "${CACHE_FILE}" 2>/dev/null || echo 0)"
  fi

  if ! [[ "${last_seen}" =~ ^[0-9]+$ ]]; then
    last_seen=0
  fi

  if (( now - last_seen > GRACE_SECONDS )); then
    printf '{"text":"","tooltip":false,"class":[]}\n'
    exit 0
  fi
fi

printf '{"text":"","tooltip":"Screen sharing active","class":["active"]}\n'
