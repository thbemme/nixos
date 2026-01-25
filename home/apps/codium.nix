{
  pkgs,
  ...
}: {
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
        "editor.fontFamily" = "FiraCode Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 12;
        "editor.insertSpaces" = true;
        "editor.mouseWheelZoom" = true;
        "editor.multiCursorModifier" = "alt";
        "editor.renderWhitespace" = "selection";
        "editor.tabSize" = 2;
        "editor.wordWrap" = "off";
        "files.autoSave" = "afterDelay";
        "markdown.extension.toc.slugifyMode" = "gitea";
        "nix.formatterPath" = "alejandra";
        "terminal.integrated.fontSize" = 12;
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
