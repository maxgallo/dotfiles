from powerline_shell.utils import BasicSegment
import os

class Segment(BasicSegment):
    def add_to_powerline(self):
        # bare : fish
        # bash : bash
        # zsh : zsh

        if self.powerline.args.shell == 'bare':
            self.powerline.append(' F ', self.powerline.theme.SSH_FG, self.powerline.theme.GIT_CONFLICTED_BG)
        else :
            self.powerline.append(' B ', self.powerline.theme.PATH_FG, self.powerline.theme.PATH_BG)
