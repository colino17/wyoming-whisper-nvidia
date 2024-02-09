#!/usr/bin/env bash
python3 -m wyoming_faster_whisper \
    --uri 'tcp://0.0.0.0:10300' \
    --data-dir /data \
    --download-dir /data "$@" \
    --model "$MODEL"
    --beam-size "$BEAM_SIZE"
    --language "$LANGUAGE"
    --device cuda
