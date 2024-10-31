local comfortable_night_vision = settings.startup["chinese-comfortable-night-vision"].value
if comfortable_night_vision then
    data.raw["night-vision-equipment"]["night-vision-equipment"].color_lookup = {{0.5, "__core__/graphics/color_luts/lut-sunset.png"}}
end
