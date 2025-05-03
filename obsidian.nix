{ pkgs, ... }:

{

  # Create the Obsidian .desktop file
  environment.etc."xdg/menus/obsidian.desktop".text = ''
    [Desktop Entry]
    Name=Obsidian
    Exec=obsidian %U
    Type=Application
    Terminal=false
    MimeType=x-scheme-handler/obsidian;
  '';

  # Ensure the MIME type is associated with the .desktop file
  environment.etc."xdg/mime/packages/obsidian-mime.xml".text = ''
    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="x-scheme-handler/obsidian">
        <comment>Obsidian URI</comment>
      </mime-type>
    </mime-info>
  '';

  # Update the MIME database
  environment.systemPackages = with pkgs; [
    obsidian
    tesseract
    imagemagick
    xdg-utils
  ];
}