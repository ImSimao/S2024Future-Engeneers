import math

import pyb
import sensor

debug = True
min_width = 18
min_height = 35
screen_division = 3

# Color Tracking Thresholds (L Min, L Max, A Min, A Max, B Min, B Max)
green_blobs = [
    #(20, 39, -27, -3, -12, 15),
    #(24, 45, -19, -9, -9, 11),
    #(17, 43, -42, -6, -9, 18),
    #(28, 73, -65, -13, -34, 21),
    #(19, 53, -34, -6, -2, 17)
        #(45, 60, -57, -37, 6, 43),
        #(35, 59, -55, -16, -9, 40),
        #(44, 58, -54, -26, 5, 45),
        #(35, 61, -59, -32, 7, 38),
        #(29, 53, -38, -13, -8, 15)
            (39, 61, -48, -21, -9, 22),
            (36, 68, -52, -12, -15, 30),    #verde perto / pode estar mt aberto
            (25, 43, -40, -9, 0, 18),
            (32, 53, -54, -18, 0, 25)

]


pink_blobs = [

   (23, 44, 23, 57, -15, 2),
   (24, 43, 28, 58, -6, 7),
   (31, 69, 51, 72, -56, -30)



]


red_blobs = [
    #(6, 30, 11, 43, -12, 44),
    #(9, 37, 20, 64, 12, 43),
    #(15, 57, 22, 63, -11, 32)
        #(14, 30, 18, 58, -2, 53),
        #(19, 36, 28, 57, -1, 45),
        #(31, 59, 45, 76, -46, 48),
        #(15, 32, 13, 52, -2, 22)
            #(13, 27, 13, 44, 3, 23),        #valores que estam na camara mas com falta de afinação
            #(17, 35, 17, 56, -2, 39),
            #(15, 35, 24, 56, -3, 28),
            #(13, 40, 28, 75, -23, 54)
               # (20, 31, 13, 55, 3, 39),
               # (22, 39, 21, 55, -21, 21),
               # (21, 33, 25, 55, -2, 25),
               # (18, 36, 19, 58, -4, 29)
                    #(22, 39, 41, 64, 12, 51),
                    #(28, 40, 47, 64, 20, 55),
                    #(34, 42, 57, 67, 34, 53),
                    #(32, 40, 53, 63, 35, 57),
                    #(23, 37, 25, 52, -5, 32)
                        #(16, 35, 12, 56, -3, 18),
                        #(17, 37, 13, 64, -4, 30),
                        #(12, 32, 14, 53, -3, 23),
                        #(14, 40, 20, 56, -13, 17),
                        #(31, 53, 43, 61, 8, 35),
                        #(29, 39, 48, 57, 23, 46)
                            #09/05/2024
                            (21, 49, 45, 65, 7, 38),
                            (15, 31, 18, 51, 8, 28),
                            (29, 44, 49, 59, 4, 34),
                            (10, 32, 18, 42, 7, 24),
                            (26, 36, 39, 54, 13, 29),
                            (15, 37, 33, 51, 12, 37)
                                #(24, 37, 36, 60, 11, 24),
                                #(17, 42, 38, 56, 13, 41),
                                #(20, 26, 27, 45, 10, 33),
                                #(15, 32, 29, 55, 14, 35)



 ]

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
sensor.skip_frames(time=2000)
sensor.set_auto_gain(False) # must be turned off for color tracking
sensor.set_auto_whitebal(False) # must be turned off for color tracking
sensor.set_vflip(True)
sensor.set_hmirror(True)


p0 = pyb.Pin("P0", pyb.Pin.OUT_PP)
p1 = pyb.Pin("P1", pyb.Pin.OUT_PP)
p2 = pyb.Pin("P2", pyb.Pin.OUT_PP)
p3 = pyb.Pin("P3", pyb.Pin.OUT_PP)
p4 = pyb.Pin("P4", pyb.Pin.OUT_PP)
p5 = pyb.Pin("P5", pyb.Pin.OUT_PP)

# Only blobs that with more pixels than "pixel_threshold" and more area than "area_threshold" are
# returned by "find_blobs" below. Change "pixels_threshold" and "area_threshold" if you change the
# camera resolution. Don't set "merge=True" becuase that will merge blobs which we don't want here.

while(True):
    img = sensor.snapshot()
    blob_detected = False
    largest_blob = False
    is_red_blob = False
    is_green_blob = False
    is_pink_blob = False

    try:
        for blob in img.find_blobs(green_blobs, pixels_threshold=500, area_threshold=500, merge=False):
            if (blob.cy() < img.height()/screen_division):
                continue

            if (blob.h() < min_height or blob.w() < min_width):
                continue

            # These values depend on the blob not being circular - otherwise they will be shaky.
            if largest_blob is False or blob.cy() > largest_blob.cy():
                largest_blob = blob
                is_green_blob = True

            blob_detected=True

            if not debug:
                continue

            img.draw_edges(blob.min_corners(), color=(255,0,0))
            img.draw_line(blob.major_axis_line(), color=(0,255,0))
            img.draw_line(blob.minor_axis_line(), color=(0,0,255))
            # These values are stable all the time.
            img.draw_rectangle(blob.rect(), color=(0,255,0))
            img.draw_cross(blob.cx(), blob.cy())
            # Note - the blob rotation is unique to 0-180 only.
            img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=20)

        for blob in img.find_blobs(red_blobs, pixels_threshold=500, area_threshold=500, merge=False):
            if (blob.cy() < img.height()/screen_division):
                continue

            if (blob.h() < min_height or blob.w() < min_width):
                continue

            # These values depend on the blob not being circular - otherwise they will be shaky.
            if largest_blob is False or blob.cy() > largest_blob.cy():
                largest_blob = blob
                is_red_blob = True


            blob_detected=True

            if not debug:
                continue

            img.draw_edges(blob.min_corners(), color=(255,0,0))
            img.draw_line(blob.major_axis_line(), color=(0,255,0))
            img.draw_line(blob.minor_axis_line(), color=(0,0,255))
            # These values are stable all the time.
            img.draw_rectangle(blob.rect(), color=(255,0,0))
            img.draw_cross(blob.cx(), blob.cy())

            # Note - the blob rotation is unique to 0-180 only.
            img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=20)

        for blob in img.find_blobs(pink_blobs, pixels_threshold=500, area_threshold=500, merge=False):


            # These values depend on the blob not being circular - otherwise they will be shaky.
            if largest_blob is False or blob.cy() > largest_blob.cy():
            #    largest_blob = blob
                is_pink_blob = True


            blob_detected=True

            if not debug:
                continue

            img.draw_edges(blob.min_corners(), color=(255,0,0))
            img.draw_line(blob.major_axis_line(), color=(0,255,0))
            img.draw_line(blob.minor_axis_line(), color=(0,0,255))
            # These values are stable all the time.
            img.draw_rectangle(blob.rect(),color=(0,0,0))
            img.draw_cross(blob.cx(), blob.cy())
            # Note - the blob rotation is unique to 0-180 only.
            img.draw_keypoints([(blob.cx(), blob.cy(), int(math.degrees(blob.rotation())))], size=20)

        if blob_detected is False:
            p0.low()
            p1.low()
            p2.low()
            p3.low()
            p4.low()
            p5.low()

        else:

            if is_pink_blob is True:
                if is_red_blob is True:
                    p0.high()
                    p4.low()
                    p5.high()
                elif is_green_blob is True:
                    p0.low()
                    p4.high()
                    p5.high()
                else:
                    p0.low()
                    p1.low()
                    p2.low()
                    p3.low()
                    p4.low()
                    p5.high()

            elif is_red_blob is True:
                p0.high()
                p4.low()
                p5.low()

            elif is_green_blob is True:
                p0.low()
                p4.high()
                p5.low()





            else:
                p0.low()
                p4.low()
                p5.low()

            if largest_blob.cx() > img.width()/3*2:
                p1.high()
                p2.low()
                p3.low()
            elif largest_blob.cx() < img.width()/3:
                p1.low()
                p2.low()
                p3.high()
            else:
                p1.low()
                p2.high()
                p3.low()
    except:
        continue
