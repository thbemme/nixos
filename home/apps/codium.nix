{
  config,
  pkgs,
  ...
}: {
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
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        streetsidesoftware.code-spell-checker
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "editor.cursorStyle" = "line";
        "editor.fontLigatures" = true;
        "editor.insertSpaces" = true;
        "editor.mouseWheelZoom" = true;
        "editor.multiCursorModifier" = "alt";
        "editor.renderWhitespace" = "selection";
        "editor.tabSize" = 2;
        "editor.wordWrap" = "off";
        "files.autoSave" = "afterDelay";
        "markdown.extension.toc.slugifyMode" = "gitea";
        "nix.formatterPath" = "alejandra";
        "workbench.colorTheme" = "Stylix";
        "workbench.editor.enablePreview" = false;
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
  };
}
