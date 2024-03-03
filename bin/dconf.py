import subprocess
import os
import re
from textwrap import indent

gtk = {
    "~/.gtkrc-2.0": ["gtk2.extraConfig", False],
    "~/.config/gtk-3.0/settings.ini": ["gtk3.extraConfig", True],
    "~/.config/gtk-4.0/settings.ini": ["gtk4.extraConfig", True],
}

todo = [
    "org/gnome",
]
remove = [
    "settings-daemon/plugins/xsettings",
    "shell/extensions/bingwallpaper",
    {
        "shell": [
            "command-history",
            "app-picker-layout",
        ],
        "shell/weather": ["locations"],
    },
    "*evolution",
    "*epiphany",
    "*Console",
    "*Geary",
    "*Totem",
    "*evince",
    "*desktop/notifications",
    "software",
    "*desktop/app-folders",
    "*file-roller",
    "*Weather",
]


from configparser import ConfigParser


def sanitize_dconf(dconf) -> ConfigParser:
    ini = ConfigParser(interpolation=None)
    ini.read_string(dconf)

    for todo in remove:
        if isinstance(todo, dict):
            for section_name, keys in todo.items():
                section = ini[section_name]
                for key in keys:
                    if key in section:
                        del section[key]
            continue
        if isinstance(todo, str):
            if todo.startswith("*"):
                for section_name in ini.sections():
                    if section_name.startswith(todo[1:]):
                        ini.remove_section(section_name)
                continue
            if todo in ini.sections():
                if todo in ini:
                    ini.remove_section(todo)

    # loop thru all strings in every section and remove any string with /home/mcrowe in it
    for section_name in ini.sections():
        for key in ini[section_name]:
            if "/home/mcrowe" in ini[section_name][key]:
                del ini[section_name][key]

    # Remove empty sections
    sections_to_remove = [s for s in ini.sections() if not ini[s]]
    for section in sections_to_remove:  # type: ignore
        ini.remove_section(section)  # type: ignore

    return ini


def convert_gtk_ini_to_nix(prefix, use_attributes, gtk_ini_content):
    # Parse the GTK INI content
    lines = gtk_ini_content.strip().split("\n")
    settings = []

    # Process each line to format it correctly for Nix
    for line in lines[2:]:  # Skip the first two lines as they are not settings
        # Handle different assignment operators and potential quotes
        key_value = re.match(r"^(.*?)=(.*)$", line)
        if key_value:
            key, value = key_value.groups()
            # Preserve quotes if already present, otherwise add them for Nix strings
            formatted_value = value if value.startswith('"') else f'"{value}"'
            settings.append(f"{key}={formatted_value}")

    settings = sorted(list(set(settings)))
    if use_attributes:
        attributes = {
            k.strip(): v.strip() for k, v in [line.split("=") for line in settings]
        }
        settings = [f"{k} = {v};" for k, v in attributes.items()]
        s = indent("\n".join(settings), 2 * "  ")
        nix_config = f"""
{prefix} = {{
{s}
}};
    """.strip()
    else:
        s = indent("\n".join(settings), 1 * "  ")
        nix_config = f"""
{prefix} = ''
{s}
'';
    """.strip()

    return indent(nix_config, 3 * "  ")


def main(section):
    dconf_out = subprocess.check_output(["dconf", "dump", "/" + section + "/"]).decode(
        "utf-8"
    )
    ini = sanitize_dconf(dconf_out)
    with open("/tmp/dconf.ini", "w") as f:
        ini.write(f, space_around_delimiters=False)

    os.system(
        f"cat /tmp/dconf.ini | dconf2nix -r {section}  > modules/home/user-services/dconf.nix"
    )


def save_gtk():
    HOME = os.environ["HOME"]
    parts = ["""_: {\n    gtk = {"""]
    for file, params in gtk.items():
        with open(file.replace("~", HOME), "r") as f:
            nix_config = convert_gtk_ini_to_nix(params[0], params[1], f.read())
            parts.append(nix_config)
    parts.append("""  };\n}""")
    open("modules/home/graphical/gtk.nix", "w").write("\n".join(parts))


if __name__ == "__main__":
    for section in todo:
        main(section=section)
    save_gtk()
