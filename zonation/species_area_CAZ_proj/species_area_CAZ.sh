#!/bin/sh
zig4 -r species_area_CAZ/species_area_CAZ.dat species_area_CAZ/species_area_CAZ.spp species_area_CAZ/species_area_CAZ_out/species_area_CAZ.txt 0 0 1 0 --grid-output-formats=compressed-tif --image-output-formats=png --use-threads=4