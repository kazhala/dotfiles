#!/usr/bin/env bash
# shellcheck disable=SC2034

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

FILE_PATH="${1}"
PV_WIDTH="${2}"
PV_HEIGHT="${3}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5}"
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

handle_extension() {
	case "${FILE_EXTENSION_LOWER}" in
	a | ace | alz | arc | arj | bz | bz2 | cab | cpio | deb | gz | jar | lha | lz | lzh | lzma | lzo | \
		rpm | rz | t7z | tar | tbz | tbz2 | tgz | tlz | txz | tZ | tzo | war | xpi | xz | Z | zip)
		bsdtar --list --file "${FILE_PATH}" && exit 5
		exit 1
		;;
	json)
		env COLORTERM=8bit bat --color=always --style="plain" "${FILE_PATH}" && exit 5
		exit 2
		;;
	esac
}

handle_mime() {
	local mimetype="${1}"
	case "${mimetype}" in
	text/* | */xml)
		env COLORTERM=8bit bat --color=always --style="plain" "${FILE_PATH}" && exit 5
		exit 2
		;;
	esac
}

handle_fallback() {
	echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
	exit 1
}

MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
