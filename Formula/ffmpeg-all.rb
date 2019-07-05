class FfmpegAll < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-4.1.3.tar.xz"
  sha256 "0c3020452880581a8face91595b239198078645e7d7184273b8bcc7758beb63d"
  revision 1
  head "https://github.com/FFmpeg/FFmpeg.git"

  bottle do
    sha256 "ddfb58dd5432eed657d9ecda3b4c2f06eb523815e9e7f339b1f05d1048f89d40" => :mojave
    sha256 "41dd2796b2c3136faf6d5b20e1f7774db2c21a916c1b9d752e1ea4c92ff32f22" => :high_sierra
    sha256 "3904c3b313c0a53349b2bd3a0e27b503b5448f81b319c313ee48ef80492bf5dd" => :sierra
  end

  depends_on "nasm" => :build
  depends_on "pkg-config" => :build
  depends_on "texi2html" => :build

  depends_on "aom"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "frei0r"
  depends_on "gnutls"
  depends_on "lame"
  depends_on "libass"
  depends_on "libbluray"
  depends_on "libsoxr"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "libxml2"
  depends_on "opencore-amr"
  depends_on "openjpeg"
  depends_on "opus"
  depends_on "rtmpdump"
  depends_on "rubberband"
  depends_on "sdl2"
  depends_on "snappy"
  depends_on "speex"
  depends_on "tesseract"
  depends_on "theora"
  depends_on "x264"
  depends_on "x265"
  depends_on "xvid"
  depends_on "xz"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --enable-pthreads
      --enable-version3
      --enable-hardcoded-tables
      --enable-avresample
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --disable-indev=jack
      --disable-libjack
      --enable-avisynth
      --enable-avresample
      --enable-ffplay
      --enable-frei0r
      --enable-gpl
      --enable-hardcoded-tables
      --enable-jni
      --enable-ladspa
      --enable-libaom
      --enable-libass
      --enable-libbluray
      --enable-libbs2b
      --enable-libcaca
      --enable-libcdio
      --enable-libcelt
      --enable-libcodec2
      --enable-libdavs2
      --enable-libdc1394
      --enable-libdrm
      --enable-libfdk-aac
      --enable-libflite
      --enable-libfontconfig
      --enable-libfreetype
      --enable-libfribidi
      --enable-libgme
      --enable-libgsm
      --enable-libiec61883
      --enable-libilbc
      --enable-libklvanc
      --enable-libkvazaar
      --enable-liblensfun
      --enable-libmfx
      --enable-libmodplug
      --enable-libmp3lame
      --enable-libmysofa
      --enable-libnpp
      --enable-libopencore-amrnb
      --enable-libopencore-amrwb
      --enable-libopencv
      --enable-libopenh264
      --enable-libopenjpeg
      --enable-libopenmpt
      --enable-libopus
      --enable-libpulse
      --enable-librsvg
      --enable-librtmp
      --enable-librubberband
      --enable-libshine
      --enable-libsmbclient
      --enable-libsnappy
      --enable-libsoxr
      --enable-libspeex
      --enable-libsrt
      --enable-libssh
      --enable-libtensorflow
      --enable-libtesseract
      --enable-libtheora
      --enable-libtwolame
      --enable-libv4l2
      --enable-libvidstab
      --enable-libvmaf
      --enable-libvo-amrwbenc
      --enable-libvorbis
      --enable-libvpx
      --enable-libwavpack
      --enable-libwebp
      --enable-libx264
      --enable-libx265
      --enable-libxavs
      --enable-libxavs2
      --enable-libxcb
      --enable-libxcb-shape
      --enable-libxcb-shm
      --enable-libxcb-xfixes
      --enable-libxml2
      --enable-libxvid
      --enable-libzimg
      --enable-libzmq
      --enable-libzvbi
      --enable-lv2
      --enable-lzma
      --enable-mediacodec
      --enable-mmal
      --enable-nonfree
      --enable-omx
      --enable-omx-rpi
      --enable-openal
      --enable-opencl
      --enable-opengl
      --enable-openssl
      --enable-pthreads
      --enable-rkmpp
      --enable-shared
      --enable-vapoursynth
      --enable-version3
      --enable-videotoolbox
    ]

    system "./configure", *args
    system "make", "install"

    # Build and install additional FFmpeg tools
    system "make", "alltools"
    bin.install Dir["tools/*"].select { |f| File.executable? f }
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end

=begin
Included options (or disbaled options due to limitations on Mac) with descriptions:

  --disable-indev=jack
  --disable-libjack
  --enable-avisynth        enable reading of AviSynth script files [no]
  --enable-avresample
  --enable-ffplay
  --enable-frei0r          enable frei0r video filtering [no] **
  --enable-gpl
  --enable-hardcoded-tables
  --enable-jni             enable JNI support [no]
  --enable-ladspa          enable LADSPA audio filtering [no]
  --enable-libaom          enable AV1 video encoding/decoding via libaom [no]**
  --enable-libass          enable libass subtitles rendering, needed for subtitles and ass filter [no] **
  --enable-libbluray       enable BluRay reading using libbluray [no] **
  --enable-libbs2b         enable bs2b DSP library [no]
  --enable-libcaca         enable textual display using libcaca [no]
  --enable-libcdio         enable audio CD grabbing with libcdio [no]
  --enable-libcelt         enable CELT decoding via libcelt [no]
  --enable-libcodec2       enable codec2 en/decoding using libcodec2 [no]
  --enable-libdavs2        enable AVS2 decoding via libdavs2 [no]
  --enable-libdc1394       enable IIDC-1394 grabbing using libdc1394 and libraw1394 [no]
  --enable-libdrm          enable DRM code (Linux) [no]
  --enable-libfdk-aac      enable AAC de/encoding via libfdk-aac [no]
  --enable-libflite        enable flite (voice synthesis) support via libflite [no]
  --enable-libfontconfig   enable libfontconfig, useful for drawtext filter [no] **
  --enable-libfreetype     enable libfreetype, needed for drawtext filter [no] **
  --enable-libfribidi      enable libfribidi, improves drawtext filter [no]
  --enable-libgme          enable Game Music Emu via libgme [no]
  --enable-libgsm          enable GSM de/encoding via libgsm [no]
  --enable-libiec61883     enable iec61883 via libiec61883 [no]
  --enable-libilbc         enable iLBC de/encoding via libilbc [no]
  --enable-libjack         enable JACK audio sound server [no]
  --enable-libklvanc       enable Kernel Labs VANC processing [no]
  --enable-libkvazaar      enable HEVC encoding via libkvazaar [no]
  --enable-liblensfun      enable lensfun lens correction [no]
  --enable-libmfx          enable Intel MediaSDK (AKA Quick Sync Video) code via libmfx [no]
  --enable-libmodplug      enable ModPlug via libmodplug [no]
  --enable-libmp3lame      enable MP3 encoding via libmp3lame [no] **
  --enable-libmysofa       enable libmysofa, needed for sofalizer filter [no]
  --enable-libnpp          enable Nvidia Performance Primitives-based code [no]
  --enable-libopencore-amrnb enable AMR-NB de/encoding via libopencore-amrnb [no] **
  --enable-libopencore-amrwb enable AMR-WB decoding via libopencore-amrwb [no] **
  --enable-libopencv       enable video filtering via libopencv [no]
  --enable-libopenh264     enable H.264 encoding via OpenH264 [no]
  --enable-libopenjpeg     enable JPEG 2000 de/encoding via OpenJPEG [no] **
  --enable-libopenmpt      enable decoding tracked files via libopenmpt [no]
  --enable-libopus         enable Opus de/encoding via libopus [no] **
  --enable-libpulse        enable Pulseaudio input via libpulse [no]
  --enable-librsvg         enable SVG rasterization via librsvg [no]
  --enable-librtmp         enable RTMP[E] support via librtmp [no] **
  --enable-librubberband   enable rubberband needed for rubberband filter [no] **
  --enable-libshine        enable fixed-point MP3 encoding via libshine [no]
  --enable-libsmbclient    enable Samba protocol via libsmbclient [no]
  --enable-libsnappy       enable Snappy compression, needed for hap encoding [no] **
  --enable-libsoxr         enable Include libsoxr resampling [no] **
  --enable-libspeex        enable Speex de/encoding via libspeex [no] **
  --enable-libsrt          enable Haivision SRT protocol via libsrt [no]
  --enable-libssh          enable SFTP protocol via libssh [no]
  --enable-libtensorflow   enable TensorFlow as a DNN module backend for DNN based filters like sr [no]
  --enable-libtesseract    enable Tesseract, needed for ocr filter [no] **
  --enable-libtheora       enable Theora encoding via libtheora [no] **
  --enable-libtwolame      enable MP2 encoding via libtwolame [no]
  --enable-libv4l2         enable libv4l2/v4l-utils [no]
  --enable-libvidstab      enable video stabilization using vid.stab [no]
  --enable-libvmaf         enable vmaf filter via libvmaf [no]
  --enable-libvo-amrwbenc  enable AMR-WB encoding via libvo-amrwbenc [no]
  --enable-libvorbis       enable Vorbis en/decoding via libvorbis, native implementation exists [no] **
  --enable-libvpx          enable VP8 and VP9 de/encoding via libvpx [no] **
  --enable-libwavpack      enable wavpack encoding via libwavpack [no]
  --enable-libwebp         enable WebP encoding via libwebp [no]
  --enable-libx264         enable H.264 encoding via x264 [no] **
  --enable-libx265         enable HEVC encoding via x265 [no] **
  --enable-libxavs         enable AVS encoding via xavs [no]
  --enable-libxavs2        enable AVS2 encoding via xavs2 [no]
  --enable-libxcb          enable X11 grabbing using XCB [autodetect]
  --enable-libxcb-shape    enable X11 grabbing shape rendering [autodetect]
  --enable-libxcb-shm      enable X11 grabbing shm communication [autodetect]
  --enable-libxcb-xfixes   enable X11 grabbing mouse rendering [autodetect]
  --enable-libxml2         enable XML parsing using the C library libxml2, needed for dash demuxing support [no] **
  --enable-libxvid         enable Xvid encoding via xvidcore, native MPEG-4/Xvid encoder exists [no] **
  --enable-libzimg         enable z.lib, needed for zscale filter [no]
  --enable-libzmq          enable message passing via libzmq [no]
  --enable-libzvbi         enable teletext support via libzvbi [no]
  --enable-lv2             enable LV2 audio filtering [no]
  --enable-lzma
  --enable-mediacodec      enable Android MediaCodec support [no]
  --enable-mmal            enable Broadcom Multi-Media Abstraction Layer (Raspberry Pi) via MMAL [no]
  --enable-nonfree
  --enable-omx             enable OpenMAX IL code [no]
  --enable-omx-rpi         enable OpenMAX IL code for Raspberry Pi [no]
  --enable-openal          enable OpenAL 1.1 capture support [no]
  --enable-opencl          enable OpenCL processing [no]
  --enable-opengl          enable OpenGL rendering [no]
  --enable-openssl         enable openssl, needed for https support if gnutls, libtls or mbedtls is not used [no]
  --enable-pthreads
  --enable-rkmpp           enable Rockchip Media Process Platform code [no]
  --enable-shared
  --enable-vapoursynth     enable VapourSynth demuxer [no]
  --enable-version3
  --enable-videotoolbox

  
=end

