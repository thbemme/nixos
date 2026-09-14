_: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };
  home.file.".config/MangoHud/MangoHud.conf".text = ''
    fps
    fps_metrics=avg,0.01
    frame_timing
    gpu_stats
    vram
    cpu_stats
    ram
    background_alpha=0.4
    background_color=020202
    cpu_color=2e97cb
    cpu_load_change
    cpu_load_color=92e79a,ffaa7f,cc0000
    cpu_load_value=60,90
    cpu_temp
    font_size=20
    fps_color=cc0000,ffaa7f,92e79a
    fps_color_change
    fps_limit_method=late
    fps_text=FPS
    fps_value=30,60
    frametime_color=00ff00
    gpu_color=2e9762
    gpu_load_change
    gpu_load_color=92e79a,ffaa7f,cc0000
    gpu_load_value=60,90
    gpu_temp
    horizontal
    horizontal_separator_color=ffffff
    horizontal_stretch=0
    hud_no_margin
    legacy_layout=false
    no_display
    no_small_font
    output_folder=~/Documents
    position=top-left
    ram_color=c26693
    table_columns=1
    text_color=ffffff
    toggle_fps_limit=Shift_L+F1
    toggle_hud=Shift_R+F12
    toggle_hud_position=Shift_R+F11
    toggle_logging=Shift_L+F2
    vram_color=ad64c1
  '';
}
