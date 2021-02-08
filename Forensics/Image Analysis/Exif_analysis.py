import exifread

f = open("image.jpg", 'rb')

tags = exifread.process_file(f)

for tag in tags.keys():
    if tag not in ('JPEGThumbnail', 'TIFFThumbnail', 'Filename', 'EXIF MakerNote'):
        print(tag)
        print(tags[tag])

    if "GPS" in tag:
        print(tag)
        print(tags[tag])

    if "EXIF DateTimeOriginal" in tag:
        print(tags[tag])
    else:
        if "GPS GPSLatitudeRef" in tag:
            print("Latitude Reference: " + tags[tag])
        else:
            if "GPS GPSLatitude" in tag:
                print("GPS Latitude: " + tags[tag])

            else:
                if "GPS GPSLongitudeRef" in tag:
                    print("Longitude Reference: " + tags[tag])
                else:
                    if "GPS GPSLongitude" in tag:
                        print("GPS Longitude: " + tags[tag])
                    else:
                        if 'Image Model' in tag:
                            print("Model " + tags[tag])

                        else:
                            if "Image Make" in tag:
                                print("Make " + tags[tag])

