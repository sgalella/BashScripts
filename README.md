# Bash Scripts
Collection of different bash scripts:

- _app_maker_: Creates an application folder for macOS.
- _format_text_: Add newlines to text.
- _mov_to_gif_: Transforms `mov` files into `gif`.
- _movs_to_gif_: Transforms multiple `mov` into `gif` and merges them on one.
- _png_to_gif_: Transforms group of`png` images into `gif`.
- _png_to_icns_: Creates a `icns` file out of an image in `png` format.



## Dependencies

- [FFmpeg](https://ffmpeg.org)
- [sips](https://www.lcdf.org/gifsicle/)
- [Gifsicle](https://ss64.com/osx/sips.html)
- [ImageMagick](https://imagemagick.org/index.php)



## Usage

Run the desired script as:

```bash
./script path_to_file
```

`path_to_file` denotes the location of the file to be converted, in case the chosen scripts needs one.

You can give permissions to the files using the command:
```bash
chmod 755 path_to_file
```
