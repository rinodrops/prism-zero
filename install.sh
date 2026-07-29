#!/bin/sh
# Prism Zero — install detected non-Marketplace targets (Neovim, Ptyxis).
# VS Code / Cursor / Nova: use Marketplace. iTerm / Prompt: import manually.
#
# Local:
#   sh install.sh
# One-liner (after the repo is on GitHub):
#   curl -fsSL https://raw.githubusercontent.com/rinodrops/prism-zero/main/install.sh | sh
#
# Optional env:
#   PRISM_ZERO_REF=main   # git ref / tag for archive download (curl | sh)
#   PRISM_ZERO_REPO_ROOT  # force a local repo root that contains dist/

set -eu

REPO_SLUG="${PRISM_ZERO_REPO_SLUG:-rinodrops/prism-zero}"
REF="${PRISM_ZERO_REF:-main}"
RAW_BASE="https://raw.githubusercontent.com/${REPO_SLUG}/${REF}"

CLEANUP_DIR=""
cleanup() {
  if [ -n "${CLEANUP_DIR}" ] && [ -d "${CLEANUP_DIR}" ]; then
    rm -rf "${CLEANUP_DIR}"
  fi
}
trap cleanup EXIT

say() { printf '%s\n' "$*" >&2; }
err() { printf 'prism-zero: %s\n' "$*" >&2; }

resolve_repo_root() {
  if [ -n "${PRISM_ZERO_REPO_ROOT:-}" ]; then
    printf '%s\n' "${PRISM_ZERO_REPO_ROOT}"
    return 0
  fi

  # When run from a checkout, $0 is the script path next to dist/.
  script=$0
  case ${script} in
  /*) ;;
  *)
    if [ -f "${script}" ] || [ -f "./${script}" ]; then
      script=$(pwd)/${script#./}
    fi
    ;;
  esac
  script_dir=""
  if [ -f "${script}" ]; then
    script_dir=$(CDPATH= cd -- "$(dirname -- "${script}")" && pwd)
  fi
  if [ -n "${script_dir}" ] && [ -d "${script_dir}/dist/nvim" ]; then
    printf '%s\n' "${script_dir}"
    return 0
  fi

  # curl | sh: download a repo archive.
  if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
    err "need curl or wget to download themes (or run from a clone)"
    return 1
  fi
  if ! command -v tar >/dev/null 2>&1; then
    err "need tar to unpack the GitHub archive"
    return 1
  fi

  CLEANUP_DIR=$(mktemp -d "${TMPDIR:-/tmp}/prism-zero.XXXXXX")
  archive="${CLEANUP_DIR}/src.tar.gz"
  say "Downloading ${REPO_SLUG}@${REF} …"
  url="https://github.com/${REPO_SLUG}/archive/refs/heads/${REF}.tar.gz"
  if command -v curl >/dev/null 2>&1; then
    if ! curl -fsSL "${url}" -o "${archive}"; then
      url="https://github.com/${REPO_SLUG}/archive/refs/tags/${REF}.tar.gz"
      curl -fsSL "${url}" -o "${archive}"
    fi
  else
    if ! wget -qO "${archive}" "${url}"; then
      url="https://github.com/${REPO_SLUG}/archive/refs/tags/${REF}.tar.gz"
      wget -qO "${archive}" "${url}"
    fi
  fi
  tar -xzf "${archive}" -C "${CLEANUP_DIR}"
  root=$(find "${CLEANUP_DIR}" -mindepth 1 -maxdepth 1 -type d ! -name '.*' | head -n 1)
  if [ -z "${root}" ] || [ ! -d "${root}/dist/nvim" ]; then
    err "archive did not contain dist/; is ${REPO_SLUG}@${REF} published?"
    return 1
  fi
  printf '%s\n' "${root}"
}

nvim_config_dir() {
  if [ -n "${XDG_CONFIG_HOME:-}" ]; then
    printf '%s\n' "${XDG_CONFIG_HOME}/nvim"
  else
    printf '%s\n' "${HOME}/.config/nvim"
  fi
}

want_nvim() {
  if command -v nvim >/dev/null 2>&1; then
    return 0
  fi
  cfg=$(nvim_config_dir)
  [ -d "${cfg}" ]
}

install_nvim() {
  root=$1
  dest="$(nvim_config_dir)/colors"
  mkdir -p "${dest}"
  for name in prism_zero_light prism_zero_dark; do
    src="${root}/dist/nvim/${name}.lua"
    if [ ! -f "${src}" ]; then
      err "missing ${src}"
      return 1
    fi
    cp "${src}" "${dest}/${name}.lua"
    say "installed ${dest}/${name}.lua"
  done
  say "Neovim: :colorscheme prism_zero_light  or  prism_zero_dark"
}

want_ptyxis() {
  case $(uname -s) in
  Linux) ;;
  *) return 1 ;;
  esac
  if command -v ptyxis >/dev/null 2>&1; then
    return 0
  fi
  if command -v flatpak >/dev/null 2>&1 && flatpak info org.gnome.Ptyxis >/dev/null 2>&1; then
    return 0
  fi
  for d in \
    "${HOME}/.local/share/org.gnome.Ptyxis/palettes" \
    "${HOME}/.var/app/org.gnome.Ptyxis/data/org.gnome.Ptyxis/palettes"; do
    parent=$(dirname -- "${d}")
    if [ -d "${d}" ] || [ -d "${parent}" ]; then
      return 0
    fi
  done
  if [ -n "${XDG_DATA_HOME:-}" ]; then
    d="${XDG_DATA_HOME}/org.gnome.Ptyxis/palettes"
    parent=$(dirname -- "${d}")
    if [ -d "${d}" ] || [ -d "${parent}" ]; then
      return 0
    fi
  fi
  return 1
}

pick_ptyxis_dir() {
  for d in \
    "${HOME}/.var/app/org.gnome.Ptyxis/data/org.gnome.Ptyxis/palettes" \
    "${HOME}/.local/share/org.gnome.Ptyxis/palettes"; do
    if [ -d "${d}" ]; then
      printf '%s\n' "${d}"
      return 0
    fi
  done
  if [ -n "${XDG_DATA_HOME:-}" ] && [ -d "${XDG_DATA_HOME}/org.gnome.Ptyxis/palettes" ]; then
    printf '%s\n' "${XDG_DATA_HOME}/org.gnome.Ptyxis/palettes"
    return 0
  fi
  if command -v flatpak >/dev/null 2>&1 && flatpak info org.gnome.Ptyxis >/dev/null 2>&1; then
    d="${HOME}/.var/app/org.gnome.Ptyxis/data/org.gnome.Ptyxis/palettes"
  else
    d="${HOME}/.local/share/org.gnome.Ptyxis/palettes"
  fi
  mkdir -p "${d}"
  printf '%s\n' "${d}"
}

install_ptyxis() {
  root=$1
  dest=$(pick_ptyxis_dir)
  for name in "Prism Zero Light.palette" "Prism Zero Dark.palette"; do
    src="${root}/dist/ptyxis/${name}"
    if [ ! -f "${src}" ]; then
      err "missing ${src}"
      return 1
    fi
    cp "${src}" "${dest}/${name}"
    say "installed ${dest}/${name}"
  done
  say "Ptyxis: Preferences → Appearance → choose Prism Zero Light or Dark"
}

print_manual_tips() {
  # Prefer durable https downloads — archive temp paths are removed on exit.
  light_url="${RAW_BASE}/dist/iterm/Prism%20Zero%20Light.itermcolors"
  dark_url="${RAW_BASE}/dist/iterm/Prism%20Zero%20Dark.itermcolors"
  dest="${HOME}/Downloads"
  say ""
  say "iTerm 2 / Prompt 3 (manual import):"
  say "  Download a preset, then Import in the app:"
  say ""
  say "    mkdir -p \"${dest}\""
  say "    curl -fsSL -o \"${dest}/Prism Zero Light.itermcolors\" \\"
  say "      ${light_url}"
  say "    curl -fsSL -o \"${dest}/Prism Zero Dark.itermcolors\" \\"
  say "      ${dark_url}"
  say ""
  say "  iTerm 2: Profiles → Colors → Color Presets… → Import"
  say "  Prompt 3: Settings → Themes → gear → Import"
  say ""
  say "Windows Terminal: see install-windows-terminal.ps1"
  say "VS Code / Cursor / Nova: Marketplace (see README)"
}

main() {
  root=$(resolve_repo_root) || exit 1
  installed=0

  if want_nvim; then
    install_nvim "${root}"
    installed=1
  else
    say "skip Neovim (nvim not found and no nvim config dir)"
  fi

  if want_ptyxis; then
    install_ptyxis "${root}"
    installed=1
  else
    say "skip Ptyxis (not detected)"
  fi

  print_manual_tips

  if [ "${installed}" -eq 0 ]; then
    say ""
    say "Nothing was auto-installed. Use the Marketplace or copy files from dist/ (see README)."
  fi
}

main "$@"
