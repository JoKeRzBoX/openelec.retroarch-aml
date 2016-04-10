################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="retroarch"
PKG_VERSION="d818578"
PKG_REV="3"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib retroarch-assets core-info retroarch-joypad-autoconfig common-shaders libretro-database ffmpeg"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Reference frontend for the libretro API."
PKG_LONGDESC="RetroArch is the reference frontend for the libretro API. Popular examples of implementations for this API includes videogame system emulators and game engines, but also more generalized 3D programs. These programs are instantiated as dynamic libraries. We refer to these as libretro cores."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
else
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL"
fi

if [ "$SAMBA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET samba"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi nss-mdns"
fi

if [ "$OPENGLES" == "no" ]; then
  RETROARCH_GL="--enable-kms"
elif [ "$OPENGLES" == "bcm2835-driver" ]; then
  RETROARCH_GL="--enable-gles --disable-kms --disable-x11"
  CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                  -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
elif [ "$OPENGLES" == "sunxi-mali" ] || [ "$OPENGLES" == "odroidc1-mali" ] || [ "$OPENGLES" == "odroidxu3-mali" ] || [ "$OPENGLES" == "opengl-meson6" ] || [ "$OPENGLES" == "opengl-meson8" ]; then
  RETROARCH_GL="--enable-gles --disable-kms --disable-x11 --enable-mali_fbdev"
elif [ "$OPENGLES" == "gpu-viv-bin-mx6q" ]; then
  RETROARCH_GL="--enable-gles --disable-kms --disable-x11 --enable-vivante_fbdev"
  CFLAGS="$CFLAGS -DLINUX -DEGL_API_FB"
fi

if [[ "$TARGET_FPU" =~ "neon" ]]; then
  RETROARCH_NEON="--enable-neon"
fi

TARGET_CONFIGURE_OPTS=""
PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
                           $RETROARCH_GL \
                           $RETROARCH_NEON \
                           --enable-fbo \
                           --enable-zlib \
                           --enable-freetype"

RA_PLAYLIST_NAMES="Atari - 2600.lpl;Atari - 5200.lpl;Atari - 7800.lpl;Atari - Jaguar.lpl;Atari - Lynx.lpl;Atari - ST.lpl;Bandai - WonderSwan Color.lpl;Bandai - WonderSwan.lpl;Coleco - ColecoVision.lpl;DOOM.lpl;FB Alpha - Arcade Games.lpl;GCE - Vectrex.lpl;Magnavox - Odyssey2.lpl;MAME.lpl;Microsoft - MSX2.lpl;Microsoft - MSX.lpl;NEC - PC Engine SuperGrafx.lpl;NEC - PC Engine - TurboGrafx 16.lpl;Nintendo - Famicom Disk System.lpl;Nintendo - Game Boy Advance (e-Cards).lpl;Nintendo - Game Boy Advance.lpl;Nintendo - Game Boy Color.lpl;Nintendo - Game Boy.lpl;Nintendo - Nintendo 64.lpl;Nintendo - Nintendo DS Decrypted.lpl;Nintendo - Nintendo DS (Download Play) (BETA).lpl;Nintendo - Nintendo DSi Decrypted.lpl;Nintendo - Nintendo DSi (DLC).lpl;Nintendo - Nintendo Entertainment System.lpl;Nintendo - Satellaview.lpl;Nintendo - Super Nintendo Entertainment System.lpl;Nintendo - Virtual Boy.lpl;Quake1.lpl;ScummVM.lpl;Sega - 32X.lpl;Sega - Game Gear.lpl;Sega - Master System - Mark III.lpl;Sega - Mega Drive - Genesis.lpl;Sega - PICO.lpl;Sega - SG-1000.lpl;Sinclair - ZX Spectrum +3.lpl;SNK - Neo Geo Pocket Color.lpl;SNK - Neo Geo Pocket.lpl;Sony - PlayStation Portable.lpl;Sony - PlayStation.lpl"
RA_PLAYLIST_CORES="/tmp/cores/stella_libretro.so;DETECT;/tmp/cores/prosystem_libretro.so;/tmp/cores/virtualjaguar_libretro.so;/tmp/cores/handy_libretro.so;/tmp/cores/hatari_libretro.so;/tmp/cores/mednafen_wswan_libretro.so;/tmp/cores/mednafen_wswan_libretro.so;/tmp/cores/bluemsx_libretro.so;/tmp/cores/prboom_libretro.so;/tmp/cores/fba_libretro.so;/tmp/cores/vecx_libretro.so;/tmp/cores/o2em_libretro.so;/tmp/cores/mame_libretro.so;/tmp/cores/bluemsx_libretro.so;/tmp/cores/bluemsx_libretro.so;/tmp/cores/mednafen_supergrafx_libretro.so;/tmp/cores/mednafen_pce_fast_libretro.so;/tmp/cores/nestopia_libretro.so;/tmp/cores/gpsp_libretro.so;/tmp/cores/gpsp_libretro.so;/tmp/cores/gambatte_libretro.so;/tmp/cores/gambatte_libretro.so;/tmp/cores/mupen64plus_libretro.so;/tmp/cores/desmume_libretro.so;/tmp/cores/desmume_libretro.so;/tmp/cores/desmume_libretro.so;/tmp/cores/desmume_libretro.so;/tmp/cores/nestopia_libretro.so;/tmp/cores/snes9x_next_libretro.so;/tmp/cores/snes9x_next_libretro.so;/tmp/cores/mednafen_vb_libretro.so;/tmp/cores/tyrquake_libretro.so;/tmp/cores/scummvm_libretro.so;/tmp/cores/picodrive_libretro.so;/tmp/cores/genesis_plus_gx_libretro.so;/tmp/cores/genesis_plus_gx_libretro.so;/tmp/cores/genesis_plus_gx_libretro.so;/tmp/cores/picodrive_libretro.so;/tmp/cores/genesis_plus_gx_libretro.so;/tmp/cores/fuse_libretro.so;/tmp/cores/mednafen_ngp_libretro.so;/tmp/cores/mednafen_ngp_libretro.so;/tmp/cores/ppsspp_libretro.so;/tmp/cores/pcsx_rearmed_libretro.so"

pre_configure_target() {
  strip_lto # workaround for https://github.com/libretro/RetroArch/issues/1078
  cd $ROOT/$PKG_BUILD
}

make_target() {
  make V=1 HAVE_LAKKA=1 HAVE_ZARCH=0 LAKKA_PROJECT='\"$PROJECT.$ARCH\"'
  make -C gfx/video_filters compiler=$CC extra_flags="$CFLAGS"
  make -C audio/audio_filters compiler=$CC extra_flags="$CFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/etc
    cp $ROOT/$PKG_BUILD/retroarch $INSTALL/usr/bin
    cp $ROOT/$PKG_BUILD/retroarch.cfg $INSTALL/etc
  mkdir -p $INSTALL/usr/share/video_filters
    cp $ROOT/$PKG_BUILD/gfx/video_filters/*.so $INSTALL/usr/share/video_filters
    cp $ROOT/$PKG_BUILD/gfx/video_filters/*.filt $INSTALL/usr/share/video_filters
  mkdir -p $INSTALL/usr/share/audio_filters
    cp $ROOT/$PKG_BUILD/audio/audio_filters/*.so $INSTALL/usr/share/audio_filters
    cp $ROOT/$PKG_BUILD/audio/audio_filters/*.dsp $INSTALL/usr/share/audio_filters
  
  # General configuration
  sed -i -e "s/# libretro_path = \"\/path\/to\/libretro.so\"/libretro_path = \"\/storage\/.kodi\/addons\/emulator.tools.retroarch\/lib\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# libretro_info_path =/libretro_info_path = \"\/storage\/.kodi\/addons\/emulator.tools.retroarch\/lib\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# core_assets_directory =/core_assets_directory =\/storage\/.kodi\/userdata\/addon_data\/emulator.tools.retroarch\/downloads/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# content_database_path =/content_database_path =\/storage\/.kodi\/addons\/emulator.tools.retroarch\/database\/rdb/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# playlist_directory =/playlist_directory =\/storage\/playlists/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savefile_directory =/savefile_directory =\/storage\/savefiles/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# savestate_directory =/savestate_directory =\/storage\/savestates/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# system_directory =/system_directory =\/storage\/system/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# screenshot_directory =/screenshot_directory =\/storage\/screenshots/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_shader_dir =/video_shader_dir =\/usr\/share\/common-shaders/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# rgui_show_start_screen = true/rgui_show_start_screen = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# assets_directory =/assets_directory =\/storage\/.kodi\/addons\/emulator.tools.retroarch\/assets/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# cheat_database_path =/cheat_database_path =\/storage\/.kodi\/addons\/emulator.tools.retroarch\/database\/cht/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# menu_driver = \"rgui\"/menu_driver = \"xmb\"/" $INSTALL/etc/retroarch.cfg
  
  # Video
  sed -i -e "s/# video_fullscreen = false/video_fullscreen = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_smooth = true/video_smooth = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_aspect_ratio_auto = false/video_aspect_ratio_auto = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_threaded = false/video_threaded = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_font_path =/video_font_path =\/usr\/share\/retroarch-assets\/xmb\/monochrome\/font.ttf/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_font_size = 48/video_font_size = 32/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_filter_dir =/video_filter_dir =\/usr\/share\/video_filters/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# video_gpu_screenshot = true/video_gpu_screenshot = false/" $INSTALL/etc/retroarch.cfg

  # Audio
  sed -i -e "s/# audio_driver =/audio_driver = \"alsathread\"/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# audio_filter_dir =/audio_filter_dir =\/usr\/share\/audio_filters/" $INSTALL/etc/retroarch.cfg
  
  # Input
  sed -i -e "s/# input_driver = sdl/input_driver = udev/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_max_users =/input_max_users = 5/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_autodetect_enable = true/input_autodetect_enable = true/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# joypad_autoconfig_dir =/joypad_autoconfig_dir = \/storage\/.kodi\/addons\/emulator.tools.retroarch\/joypads/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_remapping_directory =/input_remapping_directory = \/storage\/remappings/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# input_menu_toggle_gamepad_combo =/input_menu_toggle_gamepad_combo = \"2\"/" $INSTALL/etc/retroarch.cfg

  # Menu
  sed -i -e "s/# menu_core_enable = true/menu_core_enable = false/" $INSTALL/etc/retroarch.cfg
  sed -i -e "s/# thumbnails_directory =/thumbnails_directory = \/storage\/thumbnails/" $INSTALL/etc/retroarch.cfg

  # Playlists
  echo "playlist_names = \"$RA_PLAYLIST_NAMES\"" >> $INSTALL/etc/retroarch.cfg
  echo "playlist_cores = \"$RA_PLAYLIST_CORES\"" >> $INSTALL/etc/retroarch.cfg
}
