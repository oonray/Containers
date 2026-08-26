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
        --fp16-vae \
        --fast \
        --preview-method none \
        --cache-classic \
        --lowvram \
        --reserve-vram 0.5 \
        $*
