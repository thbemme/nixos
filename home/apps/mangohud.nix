_: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };
  home.file.".config/MangoHud/MangoHud.conf".text = ''
    background_alpha=0.4
    background_color=020202
    font_size=24
    horizontal
    hud_no_margin
    legacy_layout=0
    no_display
    output_folder=~/Documents
    position=top-left
    round_corners=0
    table_columns=30
    text_color=ffffff
    toggle_hud=Shift_R+F12

    #gpu_text=6700XT
    gpu_stats
    gpu_temp
    gpu_core_clock
    gpu_mem_clock
    gpu_power
    gpu_color=2e9762

    #cpu_text=5700X
    cpu_stats
    cpu_temp
    cpu_mhz

    vram
    vram_color=ad64c1

    #ram
    #ram_color=c26693

    fps
    frame_timing=1
    frametime_color=00ff00
  '';
}
