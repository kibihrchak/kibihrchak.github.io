---
title:      "Mobile Phone Cameras"
tags:       camera photography mobile-phone 
---

The best camera mode is the one you have on your phone.

## Leveraging Computational Photography

Some day ago I've listened to the [MKBHD's podcast on Pixel
6](https://youtu.be/iXVdeYbgEvQ?t=1290) and heard about the new photo
modes introduced in this new lineup of Pixel phones. That got me
thinking on the overall development of mobile photography, and how it
managed to improve and get to the state where it is today.

I mean, the mobile phone photography compared to the conventional one is
at a clear disadvantage when compared to the conventional one due to the
physical limitations on what you can fit in the mobile phone form
factor. This results in mobile phones having a [smaller sensor
size](https://en.wikipedia.org/wiki/Image_sensor_format#Table_of_sensor_formats_and_sizes)
and smaller equivalent aperture, and consequently resulting in photos
lacking depth of field and being noisier when compared to the
conventional camera counterpart ones, in addition to being limited to a
single focal length (there's a [great video explaining the senosr size
differences by Tony & Chelsea
Northrup](https://www.youtube.com/watch?v=hi_CkZ0sGAw)).

So, what changed here that allowed us to move from potato cell phone
photos to what we have today? Sensor size and resolution increased
during time, alright, but aside from that two other things occured.
First one was brute-forcing the way around the fixed focal length
limitation by introducing multi-camera setup with each camera having its
own optics stack. But, what is more important to me here is the other
approach to achieving better photos, and that is through the
computational photography (CP), the ability to infer more information
about the photo and then improve it, either by computer vision, image
stacking, or sensor fusion.

Here the current application examples that come to my mind are:

-   The subject isolation, basically emulating depth of field of larger
    lenses by blurring the "out-of-focus" image areas either by
    recognizing the subject on the image, or [using LIDAR to create a
    scene depth map](https://lux.camera/iphone-12-camera-review/),
-   HDR, stacking different exposure photos of the same scene to achieve
    the greater dynamic range,
-   [Night](https://www.androidauthority.com/what-is-night-mode-and-how-does-it-work-979590/)
    and [astrophotography
    modes](https://petapixel.com/2021/11/04/google-pixel-6-pro-astrophotography-review-stellar-results/)
    as a follow-up to the HDR,
-   Automated panoramic stitching, although in the recent years
    ultrawide camera setups replaced this mode for getting the wide lens
    camera shots,
-   Improved digital zoom, where instead of having only one photo,
    [multiple photos are stacked to resolve additional detail from
    digitally zoomed
    photo](https://ai.googleblog.com/2018/10/see-better-and-further-with-super-res.html),
-   Most recently, Pixel 6 introduced [motion photo
    modes](https://youtu.be/Kp1P4S-WgvU?t=451) for getting the panning
    and long exposure shots.

## Camera as a Code

One important aspect of the CP is that the resulting image content is
not determined anymore only by the raw captured data, but by what can be
extracted out of it, and what can be retrieved from other photos and
other sensors. Thus, it is subject to change as the processing
mechanisms gets updated, allowing for better photos or even further
modes.

Ofc, the limiting factor here are the phone processing capabilities,
because if image processing takes too long it would deteriorate the user
experience. That's the reason that new features [require custom hardware
to keep them
going](https://www.tomsguide.com/news/google-pixel-6-tensor-chip-what-it-is-and-why-its-a-big-deal).

## Computational Photography is Cheating

There's one more thing to consider here, and that is that the CP can be
seen as a "cheating" when compared to the conventional photography,
basically producing image information that didn't exist in the original
photo. The counter-argument here is that indeed the photo coming out of
a compact or DSLR was of better quality and could be used straightaway,
but still for getting the most of the photo some processing in post was
needed. That could have been eg. stitching the photos to get the
panoramic shot unattainable by the used lens setup, or pulling in
shadows/highlights to get a HDR look, or even retouching the photos to
remove the undesirable elements from the photo.

Indeed, these operations as well as getting some kind of shots, like
action pan ones require more skill and effort and thus can be more
valued (putting your sweat into the photo), but from the technical
standpoint they differ not that much from what CP achieves, the only
difference being that these operations are done by hand and not by an
automated system.

## Where Do We Go Next?

The initial incentive for CP came out of overcoming the limitations of
mobile phone camera setups, and trying to achieve something what could
be got from a conventional camera. I think that for consumer use we've
reached the stage where even the mid-range smartphones offer the
functionality set that covers most of the use cases and that making
progress there becomes less important.

One non-CP direction would be to simplify the camera setup and try to
revert to a single-camera configuration with the aim to reduce the cost
and free up phone real estate. The most notable technologies there are -

-   Using the periscope camera setup allowing for horizontal stacking of
    optic elements, and thus allowing longer focal lengths and even
    [adjusting the focal
    length](https://www.gsmarena.com/sony_xperia_1_iii-review-2287p5.php),
    and
-   [Use of liquid
    lenses](https://www.theverge.com/2021/3/25/22350245/xiaomi-mi-mix-liquid-lens-autofocus-focal-length-camera).

As for the CP, the next step now could be assisting the photographer in
improving the photo content, either passively (composition assistance,
selecting the best shot out of the burst) or actively (image
retouching). Some examples would be -

-   Pixel 6 motion photo modes,
-   Pixel 6 [in-phone unwanted object
    removal](https://youtu.be/Kp1P4S-WgvU?t=204),
-   [Galaxy S10 best shot
    suggestion](https://www.youtube.com/watch?v=WmdABCNTNNE).

For now, these modes seem like a manufacturer's gimmick made for the
phone to stand out among the competition, but like with HDR or night
mode or the rest, I would assume the proliferation into general use when
the technology settles in and the supporting hardware becomes more
widespread and universal and not vendor-specific.
