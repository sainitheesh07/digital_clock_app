import zlib
import struct
import shutil
import os

def unfilter_png(filename):
    with open(filename, 'rb') as f:
        data = f.read()
    w, h = struct.unpack('>II', data[16:24])
    ctype = data[25]
    bpp = 4 if ctype == 6 else 3
    
    idat = b''
    pos = 8
    while pos < len(data):
        length, ct = struct.unpack('>I4s', data[pos:pos+8])
        if ct == b'IDAT':
            idat += data[pos+8:pos+8+length]
        pos += 12 + length
    raw = zlib.decompress(idat)
    
    stride = w * bpp
    img = bytearray(w * h * bpp)
    
    for y in range(h):
        filter_type = raw[y * (stride + 1)]
        row_raw = raw[y * (stride + 1) + 1 : (y + 1) * (stride + 1)]
        row_img = bytearray(stride)
        prev_row = img[(y - 1) * stride : y * stride] if y > 0 else bytearray(stride)
        
        for x in range(stride):
            filt = row_raw[x]
            left = row_img[x - bpp] if x >= bpp else 0
            up = prev_row[x]
            corner = prev_row[x - bpp] if x >= bpp else 0
            
            if filter_type == 0: val = filt
            elif filter_type == 1: val = (filt + left) & 0xff
            elif filter_type == 2: val = (filt + up) & 0xff
            elif filter_type == 3: val = (filt + ((left + up) >> 1)) & 0xff
            elif filter_type == 4:
                p = left + up - corner
                pa = abs(p - left); pb = abs(p - up); pc = abs(p - corner)
                pred = left if (pa <= pb and pa <= pc) else (up if pb <= pc else corner)
                val = (filt + pred) & 0xff
            else: val = filt
            row_img[x] = val
        img[y * stride : (y + 1) * stride] = row_img
    return w, h, bpp, img

def save_cropped_png(output_path, img_data, orig_w, bpp, y_start, y_end):
    new_w = orig_w
    new_h = y_end - y_start
    stride = new_w * bpp
    
    raw_rows = []
    for y in range(y_start, y_end):
        row_bytes = img_data[y * stride : (y + 1) * stride]
        raw_rows.append(b'\x00' + row_bytes) # filter type 0
        
    raw_data = b''.join(raw_rows)
    
    def chunk(chunk_type, data):
        return struct.pack('>I', len(data)) + chunk_type + data + struct.pack('>I', zlib.crc32(chunk_type + data) & 0xffffffff)

    header = b'\x89PNG\r\n\x1a\n'
    # color type 6 is RGBA (bpp=4), 2 is RGB (bpp=3)
    ctype = 6 if bpp == 4 else 2
    ihdr = chunk(b'IHDR', struct.pack('>IIBBBBB', new_w, new_h, 8, ctype, 0, 0, 0))
    idat = chunk(b'IDAT', zlib.compress(raw_data, 9))
    iend = chunk(b'IEND', b'')

    with open(output_path, 'wb') as f:
        f.write(header + ihdr + idat + iend)
    print(f"Saved cleanly cropped image: {output_path} ({new_w}x{new_h})")

def process_all():
    img1 = r"C:\Users\Hanumantha Rao\.gemini\antigravity\brain\1f9434ed-0828-48b7-aeb9-43fbdc110a84\.user_uploaded\media_1793212019458_8c2fc885.png"
    img2 = r"C:\Users\Hanumantha Rao\.gemini\antigravity\brain\1f9434ed-0828-48b7-aeb9-43fbdc110a84\.user_uploaded\media_1793212031266_0240cb09.png"
    img3 = r"C:\Users\Hanumantha Rao\.gemini\antigravity\brain\1f9434ed-0828-48b7-aeb9-43fbdc110a84\.user_uploaded\media_1793212041441_904b820e.png"

    # Crop Image 1 (Main Clock Screen)
    w1, h1, bpp1, data1 = unfilter_png(img1)
    save_cropped_png("screenshots/exp02_widgets_and_layouts.png", data1, w1, bpp1, 58, 544)
    shutil.copyfile("screenshots/exp02_widgets_and_layouts.png", "screenshots/exp02_basic_ui.png")
    shutil.copyfile("screenshots/exp02_widgets_and_layouts.png", "screenshots/exp04_styled_clock.png")
    shutil.copyfile("screenshots/exp02_widgets_and_layouts.png", "screenshots/exp06_custom_widgets_and_themes.png")
    shutil.copyfile("screenshots/exp02_widgets_and_layouts.png", "screenshots/digital_clock.png")

    # Crop Image 2 (World Clock Screen)
    w2, h2, bpp2, data2 = unfilter_png(img2)
    save_cropped_png("screenshots/exp09_rest_api_integration.png", data2, w2, bpp2, 58, 544)
    shutil.copyfile("screenshots/exp09_rest_api_integration.png", "screenshots/exp09_rest_api_world_clock.png")
    shutil.copyfile("screenshots/exp09_rest_api_integration.png", "screenshots/rest_api_world_clock.png")

    # Crop Image 3 (Settings Screen)
    w3, h3, bpp3, data3 = unfilter_png(img3)
    save_cropped_png("screenshots/exp07_forms_and_validation.png", data3, w3, bpp3, 58, 544)

    print("All images cropped and updated successfully!")

if __name__ == '__main__':
    process_all()
