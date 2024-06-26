#!/usr/bin/env xonsh

__doc__ = """
nix-prefetch-github-latest-release 74th xonsh-direnv --json 2>/dev/null
{
    "owner": "74th",
    "repo": "xonsh-direnv",
    "rev": "3bea5847b9459c5799c64966ec85e624d0be69b9",
    "hash": "sha256-h56Gx/MMCW4L6nGwLAhBkiR7bX+qfFk80LEsJMiDtjQ="
}

curl --silent  --header 'Accept: application/vnd.pypi.simple.v1+json' https://pypi.org/pypi/xontrib-dotdot/json | jq

"""

import requests
from string import Template
import json
import sys


def get_hashes(owner, repo):
    txt = $(nix-prefetch-github-latest-release @(owner) @(repo) --json 2>/dev/null)
    return json.loads(txt)


def get_pypi_info(package_name):
    url = f"https://pypi.org/pypi/{package_name}/json"
    headers = {'Accept': 'application/vnd.pypi.simple.v1+json'}
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    js = response.json()
    info = js["info"]
    try:
        url = info["project_urls"]["Code"] if "Code" in info["project_urls"] else info["project_urls"]["Homepage"]
        parts = url.split("/")
        owner = parts[-2]
        repo = parts[-1]
        return {
            "url": url, 
            "owner": owner,
            "repo": repo,
            "version": info["version"],
            "pname": info["name"],
            "license": info["license"],
            "description": info["description"]
        }
    except KeyError as e:
        print(e)
        print(json.dumps(info, indent=4))
        sys.exit(1)

def get_template(package):
    info = get_pypi_info(package)
    hashes = get_hashes(info["owner"], info["repo"])
    print(hashes)
    info["rev"] = hashes["rev"]
    info["hash"] = hashes["hash"]

    return Template("""{pkgs}:
pkgs.python3Packages.buildPythonPackage {
    pname = "$pname";
    version = "$version";
    src = pkgs.fetchFromGitHub {
        owner = "$owner";
        repo = "$repo";
        rev = "$rev";
        sha256 = "$hash";
    };

    doCheck = false;

    nativeBuildInputs = with pkgs.python3Packages; [
        setuptools
        wheel
    ];
    
    meta = {
        homepage = "$url";
        license = ''
            $license
        '';
        description = "xonsh direnv";
    };
}
""").substitute(**info)

if len(sys.argv) == 2:
    xontrib = sys.argv[1]
    output = 'overlays/xontribs/' + xontrib.replace("xontrib-", "") + ".nix"
elif len(sys.argv) < 3:
    print(f"usage: {sys.argv[0]} package file-to-write.nix")
    sys.exit(1)

template = get_template(xontrib)
open(output, "w").write(template)