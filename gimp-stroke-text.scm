; Deepak Sharma
; MIT License
; August 2021

(script-fu-register
    "script-fu-stroke-text"
    "<Image>/Layer/Stroke Text"
    "Create an antialiased stroke around text using the background color. Creates a temporary layer and merges the text down to it after processing"
    "Deepak Sharma"
    "Deepak Sharma"
    "2021-08-26"
    "RGB*, GRAY*, INDEXED*"
    SF-IMAGE "image" 0
    SF-DRAWABLE "layer" 0
    ; Default value can be adjusted by modifying the first parameter to SF-ADJUSTMENT
    SF-ADJUSTMENT "Stroke pixels" '(8 1 30 1 5 0 SF-SLIDER)
    SF-STRING "Layer append value" "-str"
)

(define (script-fu-stroke-text image layer steps layer-name)
    (let*   (
                (vectors (car (gimp-vectors-new-from-text-layer image layer))) 
                (in-w (car (gimp-image-width image)))
                (in-h (car (gimp-image-height image)))
                (new-name (string-append (car (gimp-drawable-get-name layer)) layer-name))
                (bg-layer 0)
                ; Create below the text layer to use merge-down later
                (layer-position (+ 1 (car (gimp-image-get-layer-position image layer))))
                ; input 0 RGB, 1 Gray, 2 Indexed => output 1 RGBA, 3 GrayA, 5 IndexedA
                (layer-type (+ 1 (* 2 (car (gimp-image-base-type image)))))
            )

    ; Create a new layer with the same dimensions as the image. 100% Opacity and Normal mode
    (set! bg-layer (car (gimp-layer-new image in-w in-h layer-type new-name 100 LAYER-MODE-NORMAL)))

    (gimp-context-push)
    (gimp-undo-push-group-start image)

    (gimp-image-insert-layer image bg-layer 0 layer-position)
    (gimp-drawable-edit-fill bg-layer FILL-TRANSPARENT)
    (gimp-image-insert-vectors image vectors 0 -1)
    (gimp-image-select-item image CHANNEL-OP-REPLACE vectors)
    (gimp-selection-grow image steps)
    (gimp-edit-bucket-fill bg-layer BUCKET-FILL-BG NORMAL-MODE 100 0 FALSE 0 0)
    (plug-in-autocrop-layer RUN-NONINTERACTIVE image bg-layer)
    (gimp-image-merge-down image layer 0)
    (gimp-selection-none image)

    (gimp-undo-push-group-end image)
    (gimp-context-pop)
    (gimp-displays-flush)
    )
)
