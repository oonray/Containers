#!/usr/bin/dumb-init zsh
source ~/comfy/bin/activate
cd ./ComfyUI \
    && python3 \
        main.py \
        --use-sage-attention \
        --listen 0.0.0.0 \
        --port 8080 \
        --disable-auto-launch \
        --force-fp16 \
        --preview-method none \
        --cache-classic \
        --normalvram \
        --force-non-blocking \
        --disable-smart-memory
