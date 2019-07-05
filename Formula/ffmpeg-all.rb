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
      --enable-chromaprint
      --enable-decklink
      --enable-ffplay
      --enable-frei0r
      --enable-gcrypt
      --enable-gmp
      --enable-gnutls
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
      --enable-libtls
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
      --enable-mbedtls
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
