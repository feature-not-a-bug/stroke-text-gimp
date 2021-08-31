# Stroke Text - Gimp Script

GIMP script that strokes text with the currently selected background color. Expects a text layer to be selected and will rasterize the text layer and merge with the background color.

## Examples

<p align="center">
  <img alt="Elephant with text" src="https://i.imgur.com/JX2hpaA.jpg">
</p>

<p align="center">
  <img alt="Elephant with text" src="https://i.imgur.com/72ERYtZ.jpg">
</p>

## Usage

This script should be copied into your GIMP scripts folder.

After copying the file and refreshing GIMP a new Layers menu item named **Stroke Text** will be available. Selecting this option will display a menu where the stoke size can be specified in pixels. This script will create a new layer and merge the text layer down, so the final layer name will be distinct from the original. The new layer name is derived from the original text layer's value, along with the append value shown in this dialog.

Copyright (c) Deepak Sharma. All rights reserved.

Licensed under the [MIT](license.txt) license.
