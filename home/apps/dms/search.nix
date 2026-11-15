{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.dux-search.homeModules.default
  ];

  programs.dsearch = {
    enable = true;
    config = {
      max_file_bytes = 2097152; # 2MB
      worker_count = 4;
      index_all_files = true;
      auto_reindex = true;
      reindex_interval_hours = 24;
      index_paths = [
        {
          path = config.home.homeDirectory;
          exclude_hidden = true;
          exclude_dirs = [
            "Android"
            "Games"
            ".git"
            "target"
            "dist"
            "bin"
            "obj"
            "build"
          ];
        }
      ];
    };
  };
}
