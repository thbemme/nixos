{lib, ...}: {
  stylix.targets.mangohud.enable = lib.mkDefault false;

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  # MangoHud renders metrics in config order, so we need ordered text
  # instead of the alphabetically-sorted `settings` attrset.
  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    horizontal
    position=top-left
    table_columns=1
    hud_no_margin
    horizontal_stretch=0
    legacy_layout=false
    no_small_font
    font_size=20
    no_display

    fps
    fps_metrics=avg,0.01
    fps_text=FPS
    fps_color_change
    fps_color=cc0000,ffaa7f,92e79a
    fps_value=30,60
    fps_limit=100,0
    fps_limit_method=late
    frame_timing
    frametime_color=00ff00

    gpu_stats
    gpu_temp
    gpu_color=2e9762
    gpu_load_change
    gpu_load_color=92e79a,ffaa7f,cc0000
    gpu_load_value=60,90
    vram
    vram_color=ad64c1

    cpu_stats
    cpu_temp
    cpu_color=2e97cb
    cpu_load_change
    cpu_load_color=92e79a,ffaa7f,cc0000
    cpu_load_value=60,90
    ram
    ram_color=c26693

    background_alpha=0.4
    background_color=020202
    text_color=ffffff
    horizontal_separator_color=ffffff

    toggle_hud=Shift_R+F12
    toggle_hud_position=Shift_R+F11
    toggle_fps_limit=Shift_R+F9
  '';
}
