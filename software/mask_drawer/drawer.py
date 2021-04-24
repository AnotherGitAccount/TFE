import tkinter as tk
import tkinter.font as tkFont
from mouse import Mouse
import math
import sys

def main():
    if(len(sys.argv) < 2):
        print("Please enter the name of the file you want to edit\nUsage: python3 drawer.py <file_name>\nExample: python3 drawer.py mask\tEdits mask.bin")
        exit()

    file_name = sys.argv[1]
    print("Editing {}.bin".format(file_name))

    paint_mode = [0]
    mask = [[0 for i in range(8)] for i in range(8)]

    root = tk.Tk()
    root.title("Mask Drawer by Quentin Polet - {}.bin".format(file_name))
    root.geometry("700x740")

    mouse = Mouse()

    def setmode0():
        paint_mode[0] = 0
    def setmode1():
        paint_mode[0] = 1
    def setmode2():
        paint_mode[0] = 2
    def setmode3():
        paint_mode[0] = 3

    f_buttons = tk.Frame(root)
    b_keep = tk.Button(f_buttons, text="Keep",  command=setmode0)
    b_keep.grid(column=0, row=0, padx=(2, 2), pady=(10, 10))
    b_set1 = tk.Button(f_buttons, text="Primary", command=setmode1)
    b_set1.grid(column=1, row=0, padx=(2, 2), pady=(10, 10))
    b_set2 = tk.Button(f_buttons, text="Secondary", command=setmode2)
    b_set2.grid(column=2, row=0, padx=(2, 2), pady=(10, 10))
    b_rst  = tk.Button(f_buttons, text="Clear", command=setmode3)
    b_rst.grid(column=3, row=0, padx=(2, 2), pady=(10, 10))
    f_buttons.pack()

    canvas = tk.Canvas(root, width=640, height=640, bg="white")

    def exec_event(event):
        if(mouse.left_clicked):
            add(event)
        elif(mouse.right_clicked):
            remove(event)

    def add(event, upd_mouse=False):
        if(upd_mouse):
            mouse.onLeftClick(event)
        block_x = math.floor(event.x / 80)
        block_y = math.floor(event.y / 80)
        if(block_x >= 0 and block_x < 8 and block_y >= 0 and block_y < 8):    
            mask[block_y][block_x] = paint_mode[0]
            paint()

    def remove(event, upd_mouse=False):
        if(upd_mouse):
            mouse.onRightClick(event)
        block_x = math.floor(event.x / 80)
        block_y = math.floor(event.y / 80)
        if(block_x >= 0 and block_x < 8 and block_y >= 0 and block_y < 8):    
            mask[block_y][block_x] = 0
            paint()

    def paint():
        font = tkFont.Font(family='Helvetica', size=8, weight='bold')
        canvas.delete("all")

        for y in range(8):
            for x in range(8):
                if(mask[y][x] == 0):
                    canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#fff")
                    canvas.create_text(x * 80 + 40, y * 80 + 40,  text="KEEP", font=font)
                elif(mask[y][x] == 1):
                    canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#00a")
                    canvas.create_text(x * 80 + 40, y * 80 + 40,  text="PRIMARY", font=font, fill="#fff")
                elif(mask[y][x] == 2):
                    canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#004")
                    canvas.create_text(x * 80 + 40, y * 80 + 40, text="SECONDARY", font=font, fill="#fff")
                elif(mask[y][x] == 3):
                    canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#000")
                    canvas.create_text(x * 80 + 40, y * 80 + 40, text="CLEAR", font=font, fill="#fff")

    canvas.bind("<Button-1>", lambda event, upd_mouse=True: add(event, upd_mouse))
    canvas.bind("<ButtonRelease-1>", mouse.onLeftClick)
    canvas.bind("<Button-3>", lambda event, upd_mouse=True: remove(event, upd_mouse))
    canvas.bind("<ButtonRelease-3>", mouse.onRightClick)
    canvas.bind("<Motion>", exec_event)
    paint()
    canvas.pack()

    def generate():
        f = open("{}.bin".format(file_name), "wb")
        for y in range(8):
            for x in range(8):
                loc = y * 8 + x

                if(loc % 4 == 0):
                    byte = mask[y][x]
                elif(loc % 4 == 3):
                    byte = (byte << 2) | mask[y][x]
                    f.write(byte.to_bytes(1, byteorder='big', signed=False))
                else:
                    byte = (byte << 2) | mask[y][x]
        f.close()
        print("File {}.bin saved!".format(file_name))

    b_generate = tk.Button(root, text="Generate", command=generate)
    b_generate.pack(padx=(2, 2), pady=(10, 10))

    root.mainloop()

if __name__ == "__main__":
    main()