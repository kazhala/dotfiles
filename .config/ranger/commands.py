from ranger.api.commands import Command
from ranger.container.file import File
import subprocess
import os


class dumpput(Command):
    """dump put
    """

    def execute(self):
        selection = [
            os.path.basename(file.path) for file in self.fm.thistab.get_selection()
        ]
        if not selection:
            return
        for selected_entry in selection:
            command = "dump --put '%s'" % selected_entry
            dump_process = self.fm.execute_command(
                command, universal_newlines=True, stdout=subprocess.PIPE
            )
            stdout, stderr = dump_process.communicate()
            if stderr:
                self.fm.notify(stderr.rstrip("\n"))
            else:
                self.fm.notify(stdout.rstrip("\n"))


class dumpregret(Command):
    """dump regret
    """

    def execute(self):
        command = "dump --regret"
        dump_process = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, stderr = dump_process.communicate()
        if stderr:
            self.fm.notify(stderr.rstrip("\n"))
        else:
            self.fm.notify(stdout.rstrip("\n"))


class dumpclean(Command):
    """dump clean
    """

    def execute(self):
        command = "dump --clean"
        dump_process = self.fm.execute_command(
            command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, stderr = dump_process.communicate()
        if stderr:
            self.fm.notify(stderr.rstrip("\n"))
        else:
            self.fm.notify(stdout.rstrip("\n"))


class fbookmark(Command):
    """fbookmark ranger integration
    """

    def execute(self):
        bookmark = self.fm.execute_command(
            "exebookmark", universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = bookmark.communicate()
        dir_path = stdout.rstrip("\n")
        if dir_path and os.path.isdir(dir_path):
            self.fm.cd(dir_path)


class fzflevel1(Command):
    """Depth1 fzf search
    """

    def execute(self):
        if not self.fm.settings["show_hidden"]:
            shell_command = "fd -d 1 | fzf"
        else:
            shell_command = "fd -d 1 -H | fzf"
        search = self.fm.execute_command(
            shell_command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = search.communicate()
        if search.returncode == 0:
            result = os.path.abspath(stdout.rstrip("\n"))
            self.fm.select_file(result)


class fzfind(Command):
    """fzflevel1 search plus action, like f
    """

    def execute(self):
        if not self.fm.settings["show_hidden"]:
            shell_command = "fd -d 1 | fzf"
        else:
            shell_command = "fd -d 1 -H | fzf"
        search = self.fm.execute_command(
            shell_command, universal_newlines=True, stdout=subprocess.PIPE
        )
        stdout, _ = search.communicate()
        if search.returncode == 0:
            result = os.path.abspath(stdout.rstrip("\n"))
            if os.path.isdir(result):
                self.fm.cd(result)
            elif os.path.isfile(result):
                self.fm.execute_file(File(result))


class fzflevelx(Command):
    """no depth limit fzf, search file
    """

    def execute(self):
        search = self.fm.execute_command(
            "fzf --preview 'head -50 {}'",
            universal_newlines=True,
            stdout=subprocess.PIPE,
        )
        stdout, _ = search.communicate()
        if search.returncode == 0:
            result = os.path.abspath(stdout.rstrip("\n"))
            self.fm.select_file(result)


class fzdlevelx(Command):
    """no depth limit fzf, search dir
    """

    def execute(self):
        search = self.fm.execute_command(
            "fd --type d | fzf --preview 'tree -L 1 -C --dirsfirst {}'",
            universal_newlines=True,
            stdout=subprocess.PIPE,
        )
        stdout, _ = search.communicate()
        if search.returncode == 0:
            result = os.path.abspath(stdout.rstrip("\n"))
            self.fm.cd(result)


class show_files_in_finder(Command):
    """
    :show_files_in_finder

    Present selected files in finder
    """

    def execute(self):
        self.fm.run("open .", flags="f")
