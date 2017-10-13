## Howto
# For each Q_OBJECT:
#   - Add *.moc.cpp to nodist_..._SOURCES
#   - Add *.cpp to ..._SOURCES
#   - Add *.hpp to ..._SOURCES
# For each UI
#   - Add *.ui to ..._UI
#   - Add *.h to nodist_..._SOURCES
# For each ressource (icon, png, ...)
#   - Add it to DEPS_res

SUFFIXES += .ui .h .hpp .moc.cpp

libqtqml_plugin_la_CPPFLAGS = $(AM_CPPFLAGS) \
	-I$(srcdir)/gui/qtqml -I$(builddir)/gui/qtqml
libqtqml_plugin_la_CXXFLAGS = $(AM_CXXFLAGS) $(QT_CFLAGS) $(CXXFLAGS_qt) -DQT_QML_DEBUG
libqtqml_plugin_la_LIBADD = $(QT_LIBS) $(LIBS_qt) $(LIBM)
libqtqml_plugin_la_LDFLAGS = $(AM_LDFLAGS) -rpath '$(guidir)'
if HAVE_DARWIN
libqtqml_plugin_la_LDFLAGS += -Wl,-framework,Cocoa
endif
if HAVE_QT5_X11
libqtqml_plugin_la_CXXFLAGS += $(QT5_X11_CFLAGS) -DQT5_HAS_X11
libqtqml_plugin_la_LIBADD += $(QT5_X11_LIBS) $(X_LIBS) $(X_PRE_LIB) -lX11
endif
if HAVE_XCB
libqtqml_plugin_la_CXXFLAGS += -DQT5_HAS_XCB
endif
if HAVE_WAYLAND
libqtqml_plugin_la_CPPFLAGS += -DQT5_HAS_WAYLAND \
	-DQPNI_HEADER=\<$(QT_VERSION)/QtGui/qpa/qplatformnativeinterface.h\>
libqtqml_plugin_la_CXXFLAGS += $(WAYLAND_CLIENT_CFLAGS)
libqtqml_plugin_la_LIBADD += $(WAYLAND_CLIENT_LIBS)
endif
if HAVE_WIN32
libqtqml_plugin_la_LIBADD += $(LIBCOM) -lcomctl32 -luuid
endif
if UPDATE_CHECK
libqtqml_plugin_la_CPPFLAGS += -DUPDATE_CHECK
endif

libqtqml_plugin_la_SOURCES = \
	gui/qtqml/qtqml.cpp gui/qtqml/qtqml.hpp \
	gui/qtqml/menus.cpp gui/qtqml/menus.hpp \
	gui/qtqml/main_interface.cpp gui/qtqml/main_interface.hpp \
	gui/qtqml/dialogs_provider.cpp gui/qtqml/dialogs_provider.hpp \
	gui/qtqml/input_manager.cpp gui/qtqml/input_manager.hpp \
	gui/qtqml/actions_manager.cpp gui/qtqml/actions_manager.hpp \
	gui/qtqml/extensions_manager.cpp gui/qtqml/extensions_manager.hpp \
	gui/qtqml/managers/addons_manager.cpp gui/qtqml/managers/addons_manager.hpp \
	gui/qtqml/recents.cpp gui/qtqml/recents.hpp \
	gui/qtqml/adapters/seekpoints.cpp gui/qtqml/adapters/seekpoints.hpp \
	gui/qtqml/adapters/chromaprint.cpp gui/qtqml/adapters/chromaprint.hpp \
	gui/qtqml/adapters/variables.cpp gui/qtqml/adapters/variables.hpp \
	gui/qtqml/dialogs/playlist.cpp gui/qtqml/dialogs/playlist.hpp \
	gui/qtqml/dialogs/bookmarks.cpp gui/qtqml/dialogs/bookmarks.hpp \
	gui/qtqml/dialogs/preferences.cpp gui/qtqml/dialogs/preferences.hpp \
	gui/qtqml/dialogs/mediainfo.cpp gui/qtqml/dialogs/mediainfo.hpp \
	gui/qtqml/dialogs/epg.cpp gui/qtqml/dialogs/epg.hpp \
	gui/qtqml/dialogs/extended.cpp gui/qtqml/dialogs/extended.hpp \
	gui/qtqml/dialogs/messages.cpp gui/qtqml/dialogs/messages.hpp \
	gui/qtqml/dialogs/errors.cpp gui/qtqml/dialogs/errors.hpp \
	gui/qtqml/dialogs/external.cpp gui/qtqml/dialogs/external.hpp \
	gui/qtqml/dialogs/plugins.cpp gui/qtqml/dialogs/plugins.hpp \
	gui/qtqml/dialogs/sout.cpp gui/qtqml/dialogs/sout.hpp \
	gui/qtqml/dialogs/convert.cpp gui/qtqml/dialogs/convert.hpp \
	gui/qtqml/dialogs/help.cpp gui/qtqml/dialogs/help.hpp \
	gui/qtqml/dialogs/about.cpp gui/qtqml/dialogs/about.hpp \
	gui/qtqml/dialogs/gototime.cpp gui/qtqml/dialogs/gototime.hpp \
	gui/qtqml/dialogs/toolbar.cpp gui/qtqml/dialogs/toolbar.hpp \
	gui/qtqml/dialogs/open.cpp gui/qtqml/dialogs/open.hpp \
	gui/qtqml/dialogs/openurl.cpp gui/qtqml/dialogs/openurl.hpp \
	gui/qtqml/dialogs/vlm.cpp gui/qtqml/dialogs/vlm.hpp \
	gui/qtqml/dialogs/firstrun.cpp gui/qtqml/dialogs/firstrun.hpp \
	gui/qtqml/dialogs/podcast_configuration.cpp \
	gui/qtqml/dialogs/podcast_configuration.hpp \
	gui/qtqml/dialogs/extensions.cpp gui/qtqml/dialogs/extensions.hpp \
	gui/qtqml/dialogs/fingerprintdialog.cpp \
	gui/qtqml/dialogs/fingerprintdialog.hpp \
	gui/qtqml/components/extended_panels.cpp \
	gui/qtqml/components/extended_panels.hpp \
	gui/qtqml/components/info_panels.cpp gui/qtqml/components/info_panels.hpp \
	gui/qtqml/components/info_widgets.cpp gui/qtqml/components/info_widgets.hpp \
	gui/qtqml/components/preferences_widgets.cpp \
	gui/qtqml/components/preferences_widgets.hpp \
	gui/qtqml/components/complete_preferences.cpp \
	gui/qtqml/components/complete_preferences.hpp \
	gui/qtqml/components/simple_preferences.cpp \
	gui/qtqml/components/simple_preferences.hpp \
	gui/qtqml/components/open_panels.cpp gui/qtqml/components/open_panels.hpp \
	gui/qtqml/components/interface_widgets.cpp \
	gui/qtqml/components/interface_widgets.hpp \
	gui/qtqml/components/controller.cpp gui/qtqml/components/controller.hpp \
	gui/qtqml/components/controller_widget.cpp \
	gui/qtqml/components/controller_widget.hpp \
	gui/qtqml/components/video_overlay.cpp \
	gui/qtqml/components/video_overlay.hpp \
	gui/qtqml/components/epg/EPGChannels.cpp \
	gui/qtqml/components/epg/EPGChannels.hpp \
	gui/qtqml/components/epg/EPGItem.cpp \
	gui/qtqml/components/epg/EPGItem.hpp \
	gui/qtqml/components/epg/EPGProgram.cpp \
	gui/qtqml/components/epg/EPGProgram.hpp \
	gui/qtqml/components/epg/EPGRuler.cpp gui/qtqml/components/epg/EPGRuler.hpp \
	gui/qtqml/components/epg/EPGView.cpp gui/qtqml/components/epg/EPGView.hpp \
	gui/qtqml/components/epg/EPGWidget.cpp \
	gui/qtqml/components/epg/EPGWidget.hpp \
	gui/qtqml/components/playlist/views.cpp \
	gui/qtqml/components/playlist/views.hpp \
	gui/qtqml/components/playlist/vlc_model.cpp \
	gui/qtqml/components/playlist/vlc_model.hpp \
	gui/qtqml/components/playlist/mediacenter_model.cpp \
	gui/qtqml/components/playlist/mediacenter_model.hpp \
	gui/qtqml/components/playlist/mediacenter_item.cpp \
	gui/qtqml/components/playlist/mediacenter_item.hpp \
	gui/qtqml/components/playlist/standardpanel.cpp \
	gui/qtqml/components/playlist/standardpanel.hpp \
	gui/qtqml/components/playlist/playlist.cpp \
	gui/qtqml/components/playlist/playlist.hpp \
	gui/qtqml/components/playlist/plmodel.cpp \
	gui/qtqml/components/playlist/plmodel.hpp \
	gui/qtqml/components/playlist/plitem.cpp \
	gui/qtqml/components/playlist/plitem.hpp \
	gui/qtqml/components/playlist/selector.cpp \
	gui/qtqml/components/playlist/selector.hpp \
	gui/qtqml/components/playlist/sorting.h \
	gui/qtqml/components/sout/profile_selector.cpp \
	gui/qtqml/components/sout/profile_selector.hpp \
	gui/qtqml/components/sout/sout_widgets.cpp \
	gui/qtqml/components/sout/sout_widgets.hpp \
	gui/qtqml/components/sout/profiles.hpp \
	gui/qtqml/util/animators.cpp gui/qtqml/util/animators.hpp \
	gui/qtqml/util/input_slider.cpp gui/qtqml/util/input_slider.hpp \
	gui/qtqml/util/timetooltip.cpp gui/qtqml/util/timetooltip.hpp \
	gui/qtqml/util/customwidgets.cpp gui/qtqml/util/customwidgets.hpp \
	gui/qtqml/util/searchlineedit.cpp gui/qtqml/util/searchlineedit.hpp \
	gui/qtqml/util/registry.cpp gui/qtqml/util/registry.hpp \
	gui/qtqml/util/qmenuview.cpp gui/qtqml/util/qmenuview.hpp \
	gui/qtqml/util/qt_dirs.cpp gui/qtqml/util/qt_dirs.hpp \
	gui/qtqml/util/pictureflow.cpp gui/qtqml/util/pictureflow.hpp \
	gui/qtqml/util/validators.cpp gui/qtqml/util/validators.hpp \
	gui/qtqml/util/buttons/BrowseButton.cpp \
	gui/qtqml/util/buttons/BrowseButton.hpp \
	gui/qtqml/util/buttons/DeckButtonsLayout.cpp \
	gui/qtqml/util/buttons/DeckButtonsLayout.hpp \
	gui/qtqml/util/buttons/RoundButton.cpp \
	gui/qtqml/util/buttons/RoundButton.hpp \
	gui/qtqml/util/qvlcframe.hpp \
	gui/qtqml/util/qvlcapp.hpp \
	gui/qtqml/util/singleton.hpp \
	gui/qtqml/styles/seekstyle.cpp gui/qtqml/styles/seekstyle.hpp
if HAVE_WIN32
libqtqml_plugin_la_SOURCES += \
	gui/qtqml/main_interface_win32.cpp gui/qtqml/main_interface_win32.hpp
endif

# Meta-object compilation

moc_verbose = $(moc_verbose_$(V))
moc_verbose_ = $(moc_verbose__$(AM_DEFAULT_VERBOSITY))
moc_verbose_0 = @echo "  MOC   " $@;
moc_verbose__0 = $(moc_verbose_0)

.hpp.moc.cpp:
	$(moc_verbose)$(MOC) $(MOC_CPPFLAGS) -o $@ $<

# These MOC files depend on the configure settings:
dialogs_provider.moc.cpp dialogs/vlm.moc.cpp: $(top_builddir)/config.h

nodist_libqtqml_plugin_la_SOURCES = \
	gui/qtqml/main_interface.moc.cpp \
	gui/qtqml/menus.moc.cpp \
	gui/qtqml/dialogs_provider.moc.cpp \
	gui/qtqml/input_manager.moc.cpp \
	gui/qtqml/actions_manager.moc.cpp \
	gui/qtqml/extensions_manager.moc.cpp \
	gui/qtqml/managers/addons_manager.moc.cpp \
	gui/qtqml/recents.moc.cpp \
	gui/qtqml/adapters/seekpoints.moc.cpp \
	gui/qtqml/adapters/chromaprint.moc.cpp \
	gui/qtqml/adapters/variables.moc.cpp \
	gui/qtqml/dialogs/playlist.moc.cpp \
	gui/qtqml/dialogs/bookmarks.moc.cpp \
	gui/qtqml/dialogs/mediainfo.moc.cpp \
	gui/qtqml/dialogs/extended.moc.cpp \
	gui/qtqml/dialogs/messages.moc.cpp \
	gui/qtqml/dialogs/epg.moc.cpp \
	gui/qtqml/dialogs/errors.moc.cpp \
	gui/qtqml/dialogs/external.moc.cpp \
	gui/qtqml/dialogs/plugins.moc.cpp \
	gui/qtqml/dialogs/preferences.moc.cpp \
	gui/qtqml/dialogs/sout.moc.cpp \
	gui/qtqml/dialogs/convert.moc.cpp \
	gui/qtqml/dialogs/help.moc.cpp \
	gui/qtqml/dialogs/about.moc.cpp \
	gui/qtqml/dialogs/gototime.moc.cpp \
	gui/qtqml/dialogs/toolbar.moc.cpp \
	gui/qtqml/dialogs/open.moc.cpp \
	gui/qtqml/dialogs/openurl.moc.cpp \
	gui/qtqml/dialogs/podcast_configuration.moc.cpp \
	gui/qtqml/dialogs/vlm.moc.cpp \
	gui/qtqml/dialogs/firstrun.moc.cpp \
	gui/qtqml/dialogs/extensions.moc.cpp \
	gui/qtqml/dialogs/fingerprintdialog.moc.cpp \
	gui/qtqml/components/extended_panels.moc.cpp \
	gui/qtqml/components/info_panels.moc.cpp \
	gui/qtqml/components/info_widgets.moc.cpp \
	gui/qtqml/components/preferences_widgets.moc.cpp \
	gui/qtqml/components/complete_preferences.moc.cpp \
	gui/qtqml/components/simple_preferences.moc.cpp \
	gui/qtqml/components/open_panels.moc.cpp \
	gui/qtqml/components/interface_widgets.moc.cpp \
	gui/qtqml/components/controller.moc.cpp \
	gui/qtqml/components/controller_widget.moc.cpp \
	gui/qtqml/components/video_overlay.moc.cpp \
	gui/qtqml/components/epg/EPGChannels.moc.cpp \
	gui/qtqml/components/epg/EPGProgram.moc.cpp \
	gui/qtqml/components/epg/EPGRuler.moc.cpp \
	gui/qtqml/components/epg/EPGView.moc.cpp \
	gui/qtqml/components/epg/EPGWidget.moc.cpp \
	gui/qtqml/components/playlist/views.moc.cpp \
	gui/qtqml/components/playlist/vlc_model.moc.cpp \
	gui/qtqml/components/playlist/mediacenter_model.moc.cpp \
	gui/qtqml/components/playlist/mediacenter_item.moc.cpp \
	gui/qtqml/components/playlist/playlist.moc.cpp \
	gui/qtqml/components/playlist/plmodel.moc.cpp \
	gui/qtqml/components/playlist/standardpanel.moc.cpp \
	gui/qtqml/components/playlist/selector.moc.cpp \
	gui/qtqml/components/sout/profile_selector.moc.cpp \
	gui/qtqml/components/sout/sout_widgets.moc.cpp \
	gui/qtqml/util/animators.moc.cpp \
	gui/qtqml/util/input_slider.moc.cpp \
	gui/qtqml/util/timetooltip.moc.cpp \
	gui/qtqml/util/customwidgets.moc.cpp \
	gui/qtqml/util/searchlineedit.moc.cpp \
	gui/qtqml/util/qmenuview.moc.cpp \
	gui/qtqml/util/qvlcapp.moc.cpp \
	gui/qtqml/util/pictureflow.moc.cpp \
	gui/qtqml/util/validators.moc.cpp \
	gui/qtqml/util/buttons/RoundButton.moc.cpp \
	gui/qtqml/util/buttons/DeckButtonsLayout.moc.cpp \
	gui/qtqml/util/buttons/BrowseButton.moc.cpp \
	gui/qtqml/styles/seekstyle.moc.cpp

if HAVE_WIN32
nodist_libqtqml_plugin_la_SOURCES += gui/qtqml/main_interface_win32.moc.cpp
endif

nodist_libqtqml_plugin_la_SOURCES += \
	gui/qtqml/ui/equalizer.h \
	gui/qtqml/ui/video_effects.h \
	gui/qtqml/ui/open_file.h \
	gui/qtqml/ui/open_disk.h \
	gui/qtqml/ui/open_net.h \
	gui/qtqml/ui/open_capture.h \
	gui/qtqml/ui/open.h \
	gui/qtqml/ui/vlm.h \
	gui/qtqml/ui/podcast_configuration.h \
	gui/qtqml/ui/profiles.h \
	gui/qtqml/ui/sprefs_audio.h \
	gui/qtqml/ui/sprefs_input.h \
	gui/qtqml/ui/sprefs_interface.h \
	gui/qtqml/ui/sprefs_subtitles.h \
	gui/qtqml/ui/sprefs_video.h \
	gui/qtqml/ui/streampanel.h \
	gui/qtqml/ui/messages_panel.h \
	gui/qtqml/ui/about.h \
	gui/qtqml/ui/help.h \
	gui/qtqml/ui/update.h \
	gui/qtqml/ui/fingerprintdialog.h \
	gui/qtqml/ui/sout.h

# User interface compilation

uic_verbose = $(uic_verbose_$(V))
uic_verbose_ = $(uic_verbose__$(AM_DEFAULT_VERBOSITY))
uic_verbose_0 = @echo "  UIC   " $@;
uic_verbose__0 = $(uic_verbose_0)

MOC_CPPFLAGS = $(DEFS) \
	-I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_builddir) \
	$(libqtqml_plugin_la_CPPFLAGS)
if HAVE_DARWIN
MOC_CPPFLAGS += -DQ_OS_MAC
endif
if HAVE_WIN32
MOC_CPPFLAGS += -D_WIN32
endif

libqtqml_plugin_la_UI = \
	gui/qtqml/ui/equalizer.ui \
	gui/qtqml/ui/video_effects.ui \
	gui/qtqml/ui/open_file.ui \
	gui/qtqml/ui/open_disk.ui \
	gui/qtqml/ui/open_net.ui \
	gui/qtqml/ui/open_capture.ui \
	gui/qtqml/ui/open.ui \
	gui/qtqml/ui/podcast_configuration.ui \
	gui/qtqml/ui/profiles.ui \
	gui/qtqml/ui/sprefs_audio.ui \
	gui/qtqml/ui/sprefs_input.ui \
	gui/qtqml/ui/sprefs_interface.ui \
	gui/qtqml/ui/sprefs_subtitles.ui \
	gui/qtqml/ui/sprefs_video.ui \
	gui/qtqml/ui/streampanel.ui \
	gui/qtqml/ui/messages_panel.ui \
	gui/qtqml/ui/about.ui \
	gui/qtqml/ui/help.ui \
	gui/qtqml/ui/update.ui \
	gui/qtqml/ui/sout.ui \
	gui/qtqml/ui/vlm.ui \
	gui/qtqml/ui/fingerprintdialog.ui
EXTRA_DIST += $(libqtqml_plugin_la_UI)

.ui.h:
	$(AM_V_at)mkdir -p -- gui/qtqml/ui
	$(AM_V_at)rm -f $@ $@.tmp
	$(AM_V_at)echo "#define Q_(a,b) QString::fromUtf8(_(a))" > $@.tmp
	$(uic_verbose)$(UIC) -tr "Q_" $< >> $@.tmp
	$(AM_V_at)sed -e 's/Q_(\"_(\\\"\(.*\)\\\")"/Q_("\1"/' $@.tmp >$@
	$(AM_V_at)rm -f $@.tmp

# Resources

libqtqml_plugin_la_RES = \
	gui/qtqml/pixmaps/clear.png \
	gui/qtqml/pixmaps/eject.png \
	gui/qtqml/pixmaps/faster.png \
	gui/qtqml/pixmaps/faster2.png \
	gui/qtqml/pixmaps/go-next.png \
	gui/qtqml/pixmaps/addons/addon.png \
	gui/qtqml/pixmaps/addons/addon_broken.png \
	gui/qtqml/pixmaps/addons/addon_blue.png \
	gui/qtqml/pixmaps/addons/addon_cyan.png \
	gui/qtqml/pixmaps/addons/addon_green.png \
	gui/qtqml/pixmaps/addons/addon_magenta.png \
	gui/qtqml/pixmaps/addons/addon_red.png \
	gui/qtqml/pixmaps/addons/addon_yellow.png \
	gui/qtqml/pixmaps/addons/score.png \
	gui/qtqml/pixmaps/menus/exit_16px.png \
	gui/qtqml/pixmaps/menus/help_16px.png \
	gui/qtqml/pixmaps/menus/info_16px.png \
	gui/qtqml/pixmaps/menus/messages_16px.png \
	gui/qtqml/pixmaps/menus/playlist_16px.png \
	gui/qtqml/pixmaps/menus/preferences_16px.png \
	gui/qtqml/pixmaps/menus/settings_16px.png \
	gui/qtqml/pixmaps/menus/stream_16px.png \
	gui/qtqml/pixmaps/next.png \
	gui/qtqml/pixmaps/noart-64.png \
	gui/qtqml/pixmaps/noart.png \
	gui/qtqml/pixmaps/pause.png \
	gui/qtqml/pixmaps/play.png \
	gui/qtqml/pixmaps/playlist/add.png \
	gui/qtqml/pixmaps/playlist/playlist.png \
	gui/qtqml/pixmaps/playlist/remove.png \
	gui/qtqml/pixmaps/playlist/repeat_all.png \
	gui/qtqml/pixmaps/playlist/repeat_off.png \
	gui/qtqml/pixmaps/playlist/repeat_one.png \
	gui/qtqml/pixmaps/playlist/shuffle_on.png \
	gui/qtqml/pixmaps/playlist/dropzone.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/capture.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/pictures.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/disc.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/playlist.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/lan.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/podcast.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/library.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/screen.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/movie.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/mtp.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/music.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/network.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/appletrailers.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/icecast.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/katsomo.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/fmc.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/frenchtv.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/jamendo.png \
	gui/qtqml/pixmaps/playlist/sidebar-icons/sd/assembleenationale.png \
	gui/qtqml/pixmaps/prefs/advprefs_audio.png \
	gui/qtqml/pixmaps/prefs/advprefs_codec.png \
	gui/qtqml/pixmaps/prefs/advprefs_extended.png \
	gui/qtqml/pixmaps/prefs/advprefs_intf.png \
	gui/qtqml/pixmaps/prefs/advprefs_playlist.png \
	gui/qtqml/pixmaps/prefs/advprefs_sout.png \
	gui/qtqml/pixmaps/prefs/advprefs_video.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Audio_64.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Hotkeys_64.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Input_64.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Interface_64.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Subtitles_64.png \
	gui/qtqml/pixmaps/prefs/spref_cone_Video_64.png \
	gui/qtqml/pixmaps/previous.png \
	gui/qtqml/pixmaps/profile_new.png \
	gui/qtqml/pixmaps/sample_complete.png \
	gui/qtqml/pixmaps/sample_minimal.png \
	gui/qtqml/pixmaps/sample_skins.png \
	gui/qtqml/pixmaps/slower.png \
	gui/qtqml/pixmaps/slower2.png \
	gui/qtqml/pixmaps/space.png \
	gui/qtqml/pixmaps/stop.png \
	gui/qtqml/pixmaps/toolbar/arrows.png \
	gui/qtqml/pixmaps/toolbar/aspect-ratio.png \
	gui/qtqml/pixmaps/toolbar/atob.png \
	gui/qtqml/pixmaps/toolbar/atob_noa.png \
	gui/qtqml/pixmaps/toolbar/atob_nob.png \
	gui/qtqml/pixmaps/toolbar/renderer.png \
	gui/qtqml/pixmaps/toolbar/defullscreen.png \
	gui/qtqml/pixmaps/toolbar/dvd_menu.png \
	gui/qtqml/pixmaps/toolbar/dvd_next.png \
	gui/qtqml/pixmaps/toolbar/dvd_prev.png \
	gui/qtqml/pixmaps/toolbar/extended_16px.png \
	gui/qtqml/pixmaps/toolbar/frame-by-frame.png \
	gui/qtqml/pixmaps/toolbar/fullscreen.png \
	gui/qtqml/pixmaps/toolbar/play_reverse.png \
	gui/qtqml/pixmaps/toolbar/record_16px.png \
	gui/qtqml/pixmaps/toolbar/snapshot.png \
	gui/qtqml/pixmaps/toolbar/skip_for.png \
	gui/qtqml/pixmaps/toolbar/skip_back.png \
	gui/qtqml/pixmaps/toolbar/tv.png \
	gui/qtqml/pixmaps/toolbar/tvtelx.png \
	gui/qtqml/pixmaps/toolbar/visu.png \
	gui/qtqml/pixmaps/toolbar/volume-high.png \
	gui/qtqml/pixmaps/toolbar/volume-low.png \
	gui/qtqml/pixmaps/toolbar/volume-medium.png \
	gui/qtqml/pixmaps/toolbar/volume-muted.png \
	gui/qtqml/pixmaps/toolbar/volume-slider-inside.png \
	gui/qtqml/pixmaps/toolbar/volume-slider-outside.png \
	gui/qtqml/pixmaps/types/capture-card_16px.png \
	gui/qtqml/pixmaps/types/disc_16px.png \
	gui/qtqml/pixmaps/types/file-asym_16px.png \
	gui/qtqml/pixmaps/types/file-wide_16px.png \
	gui/qtqml/pixmaps/types/folder-blue_16px.png \
	gui/qtqml/pixmaps/types/folder-grey_16px.png \
	gui/qtqml/pixmaps/types/harddisk_16px.png \
	gui/qtqml/pixmaps/types/network_16px.png \
	gui/qtqml/pixmaps/types/tape_16px.png \
	gui/qtqml/pixmaps/types/type_directory.png \
	gui/qtqml/pixmaps/types/type_file.png \
	gui/qtqml/pixmaps/types/type_stream.png \
	gui/qtqml/pixmaps/types/type_node.png \
	gui/qtqml/pixmaps/types/type_playlist.png \
	gui/qtqml/pixmaps/types/type_unknown.xpm \
	gui/qtqml/pixmaps/util/wait1.png \
	gui/qtqml/pixmaps/util/wait2.png \
	gui/qtqml/pixmaps/util/wait3.png \
	gui/qtqml/pixmaps/util/wait4.png \
	gui/qtqml/pixmaps/win7/win7thumbnail_pause.png \
	gui/qtqml/pixmaps/win7/win7thumbnail_prev.png \
	gui/qtqml/pixmaps/win7/win7thumbnail_next.png \
	gui/qtqml/pixmaps/win7/win7thumbnail_play.png \
	gui/qtqml/pixmaps/update.png \
	gui/qtqml/pixmaps/valid.png \
	gui/qtqml/pixmaps/search_clear.png \
	gui/qtqml/pixmaps/lock.png \
	gui/qtqml/qml/help.qml \
	gui/qtqml/qml/about.qml \
	gui/qtqml/qml/playlist/MainInterface.qml \
	gui/qtqml/qml/playlist/InfoMovie.qml \
	gui/qtqml/qml/playlist/BannerSources.qml \
	gui/qtqml/qml/playlist/MCGridViewDelegate.qml \
	gui/qtqml/qml/playlist/PLListViewDelegate.qml \
	gui/qtqml/qml/playlist/PLDisplay.qml \
	gui/qtqml/qml/playlist/MCDisplay.qml \
	gui/qtqml/qml/playlist/MCListViewDelegate.qml
EXTRA_DIST += gui/qtqml/vlc.qrc $(libqtqml_plugin_la_RES)

nodist_libqtqml_plugin_la_SOURCES += gui/qtqml/resources.cpp

gui/qtqml/resources.cpp: gui/qtqml/vlc.qrc $(libqtqml_plugin_la_RES)
	$(AM_V_GEN)$(RCC) -name vlc -o $@ $<

if ENABLE_QT
gui_LTLIBRARIES += libqtqml_plugin.la
BUILT_SOURCES += $(nodist_libqtqml_plugin_la_SOURCES)
endif
