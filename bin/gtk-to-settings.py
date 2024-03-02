#!/usr/bin/env python

import re
import sys
from textwrap import indent


def convert_gtk_ini_to_nix(prefix, gtk_ini_content):
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

    s = indent(chr(10).join(settings), 2 * "  ")
    nix_config = f"""
{prefix} = {{
  Settings = ''
{s}
  '';
}};
    """.strip()

    return nix_config


# Your original GTK INI settings
prefix = sys.argv[1]
gtk_ini_content = open(sys.argv[2], "r").read()

# Convert and print the Nix configuration
nix_config = indent(convert_gtk_ini_to_nix(prefix, gtk_ini_content), 2 * "  ")
print(nix_config)
