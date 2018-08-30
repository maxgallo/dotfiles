from powerline_shell.utils import BasicSegment
import subprocess


class Segment(BasicSegment):
    def add_to_powerline(self):
        try:
            p1 = subprocess.Popen(["node", "--version"], stdout=subprocess.PIPE)
            version = p1.communicate()[0].decode("utf-8").rstrip()
            version = " " + version + " "
            self.powerline.append(version, self.powerline.theme.SSH_FG, 24)
        except OSError:
            return
