{ config, pkgs, ... }:

{

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through "home.file".
  home.file = {
    # # Building this configuration will create a copy of "dotfiles/screenrc" in
    # # the Nix store. Activating the configuration will then make "~/.screenrc" a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ""
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # "";
    ".config/MangoHud/MangoHud.conf".source = ./dotfiles/MangoHud.conf;
    ".config/ghostty/config".source = ./dotfiles/ghostty;
    ".config/hexchat/colors.conf".source = ./dotfiles/hexchat;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  # Fix vscodium settings.json readonly issue
  home.activation.removeVSCodeSettingsBackup =
    let
      configDirName =
        {
          "vscode" = "Code";
          "vscode-insiders" = "Code - Insiders";
          "vscodium" = "VSCodium";
        }.${config.programs.vscode.package.pname};
    in
    {
      after = [ ];
      before = [ "checkLinkTargets" ];
      data = ''
        userDir=${config.xdg.configHome}/${configDirName}/User
        rm -rf $userDir/settings.json*
      '';
    };

  home.activation.makeVSCodeConfigWritable =
    let
      configDirName =
        {
          "vscode" = "Code";
          "vscode-insiders" = "Code - Insiders";
          "vscodium" = "VSCodium";
        }.${config.programs.vscode.package.pname};
      configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
    in
    {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        install -m 0640 "$(readlink ${configPath})" ${configPath}
      '';
    };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
      timonwong.shellcheck
      streetsidesoftware.code-spell-checker

    ];
    userSettings = {
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
      "nix.formatterPath" = "nixpkgs-fmt";
      "ollama-autocoder.model" = "deepseek-coder-v2:latest";
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
