class Mouse:
    def __init__(self):
        self.right_clicked = False
        self.left_clicked  = False

    def onRightClick(self, event):
        self.right_clicked = ~self.right_clicked

    def onLeftClick(self, event):
        self.left_clicked = ~self.left_clicked