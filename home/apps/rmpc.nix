{pkgs, ...}: let
  musicDirectory = "~/Music";
in {
  services.mpd-mpris.enable = true;
  services.mpd = {
    enable = true;
    inherit musicDirectory;
    network.startWhenNeeded = true;

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }

      auto_update "yes"
    '';
  };

  programs.rmpc = {
    enable = true;
    config = ''
          #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          album_art: (
              vertical_align: Top,
          ),
          search: (
              case_sensitive: false,
              mode: Contains,
              tags: [
                  (value: "any",         label: "Any Tag"),
                  (value: "artist",      label: "Artist"),
                  (value: "album",       label: "Album"),
                  (value: "albumartist", label: "Album Artist"),
                  (value: "title",       label: "Title"),
              ],
          ),
          tabs: [
              (
                  name: "Queue",
                  border_type: None,
                  pane: Split(
                      direction: Horizontal,
                      panes: [
                          (
                              size: "30%",
                              borders: "RIGHT",
                              pane: Pane(AlbumArt),
                          ),
                          (
                              size: "100%",
                              pane: Pane(Queue),
                          )
                      ],
                  ),
              ),
              (
                  name: "Directories",
                  border_type: None,
                  pane: Pane(Directories),
              ),
              (
                  name: "Artists",
                  border_type: None,
                  pane: Pane(Artists),
              ),
              (
                  name: "Album Artists",
                  border_type: None,
                  pane: Pane(AlbumArtists),
              ),
              (
                  name: "Albums",
                  border_type: None,
                  pane: Pane(Albums),
              ),
              (
                  name: "Playlists",
                  border_type: None,
                  pane: Pane(Playlists),
              ),
              (
                  name: "Search",
                  border_type: None,
                  pane: Pane(Search),
              ),
          ],
      )'';
  };
}
