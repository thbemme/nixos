{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".config/hexchat/colors.conf".source = ./dotfiles/hexchat;
  };

  # Fix vscodium settings.json readonly issue
  home.activation.removeVSCodeSettingsBackup = let
    configDirName =
      {
        "vscode" = "Code";
        "vscode-insiders" = "Code - Insiders";
        "vscodium" = "VSCodium";
      }
      .${
        config.programs.vscode.package.pname
      };
  in {
    after = [];
    before = ["checkLinkTargets"];
    data = ''
      userDir=${config.xdg.configHome}/${configDirName}/User
      rm -rf $userDir/settings.json*
    '';
  };

  home.activation.makeVSCodeConfigWritable = let
    configDirName =
      {
        "vscode" = "Code";
        "vscode-insiders" = "Code - Insiders";
        "vscodium" = "VSCodium";
      }
      .${
        config.programs.vscode.package.pname
      };
    configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
  in {
    after = ["writeBoundary"];
    before = [];
    data = ''
      install -m 0640 "$(readlink ${configPath})" ${configPath}
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.enableUpdateCheck = false;
    profiles.default.enableExtensionUpdateCheck = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
      esbenp.prettier-vscode
      streetsidesoftware.code-spell-checker
    ];
    profiles.default.userSettings = {
      "files.autoSave" = "afterDelay";
      "editor.fontSize" = 12;
      "terminal.integrated.fontSize" = 12;
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "Fira Code";
      "editor.tabSize" = 2;
      "editor.mouseWheelZoom" = true;
      "editor.renderWhitespace" = "selection";
      "editor.cursorStyle" = "line";
      "editor.multiCursorModifier" = "alt";
      "editor.insertSpaces" = true;
      "editor.wordWrap" = "off";
      "workbench.colorTheme" = "Dracula Theme";
      "nix.formatterPath" = "alejandra";
      "ollama-autocoder.model" = "deepseek-coder-v2:latest";
      "markdown.extension.toc.slugifyMode" = "gitea";
      "files.exclude" = {
        "**/.git" = true;
        "**/.svn" = true;
        "**/.hg" = true;
        "**/CVS" = true;
        "**/.DS_Store" = true;
        "**/Thumbs.db" = true;
      };
    };
  };
}
