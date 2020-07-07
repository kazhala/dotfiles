import ranger.api
from ranger.core.linemode import LinemodeBase
import shutil

extension_maps = {
    "7z": "",
    "gz": "",
    "jar": "",
    "zip": "",
    "xz": "",
    "tar": "",
    "taz": "",
    "gif": "",
    "jpeg": "",
    "jpg": "",
    "png": "",
    "svg": "",
    "gif": "",
    "ico": "",
    "mp3": "",
    "mp4": "",
    "avi": "",
    "mov": "",
    "doc": "",
    "docx": "",
    "xls": "",
    "xlsx": "",
    "xlsm": "",
    "ppt": "",
    "pptx": "",
    "pdf": "",
    "license": "",
    "sh": "",
    "zsh": "",
    "bash": "",
    "bats": "",
    "js": "",
    "yml": "",
    "yaml": "",
    "toml": "",
    "conf": "",
    "json": "ﬥ",
    "md": "",
    "css": "",
    "jsx": "",
    "tsx": "",
    "html": "",
    "xml": "",
    "py": "",
    "ts": "",
}

exact_maps = {
    ".config": "",
    ".git": "",
    "Downloads": "",
    "Pictures": "",
    "TempScreenShot": "",
    "Documents": "",
    "node_modules": "",
    ".DS_Store": "",
    ".gitignore": "",
    ".gitconfig": "",
    "Dockerfile": "",
    "docker-compose.yml": "",
    ".vimrc": "",
    ".viminfo": "",
    "init.vim": "",
}


@ranger.api.register_linemode
class NerdIconsLinemode(LinemodeBase):
    name = "nerdicons"

    uses_metadata = False

    def filetitle(self, file, metadata):
        if file.is_directory:
            icon = exact_maps.get(file.relative_path, "")
        elif file.is_link:
            icon = ""
        elif "x-python" in file.filetype:
            icon = ""
        elif shutil.which(file.path):
            icon = ""
        else:
            icon = exact_maps.get(
                file.relative_path, extension_maps.get(file.extension, "")
            )
        return icon + " " + file.relative_path
