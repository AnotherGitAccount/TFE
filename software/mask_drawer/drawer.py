import tkinter as tk
from mouse import Mouse
import math

paint_mode = [0]
mask = [[0 for i in range(8)] for i in range(8)]

root = tk.Tk()
root.title("Mask Drawer - POLET Quentin")
root.geometry("700x900")

mouse = Mouse()

def setmode0():
    paint_mode[0] = 0
def setmode1():
    paint_mode[0] = 1
def setmode2():
    paint_mode[0] = 2
def setmode3():
    paint_mode[0] = 3

b_keep = tk.Button(root, text="Keep",  command=setmode0)
b_keep.pack()
b_set1 = tk.Button(root, text="Set 1", command=setmode1)
b_set1.pack()
b_set2 = tk.Button(root, text="Set 2", command=setmode2)
b_set2.pack()
b_rst  = tk.Button(root, text="Reset", command=setmode3)
b_rst.pack()

canvas = tk.Canvas(root, width=640, height=640, bg="white")

def motion(event):
    block_x = math.floor(event.x / 80)
    block_y = math.floor(event.y / 80)
    if(mouse.left_clicked):
        mask[block_y][block_x] = paint_mode[0]
    elif(mouse.right_clicked):
        mask[block_y][block_x] = 0
    paint()

def paint():
    canvas.delete("all")

    for y in range(8):
        for x in range(8):
            if(mask[y][x] == 0):
                canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#fff")
            elif(mask[y][x] == 1):
                canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#00a")
            elif(mask[y][x] == 2):
                canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#004")
            elif(mask[y][x] == 3):
                canvas.create_rectangle(x * 80, y * 80, (x + 1) * 80, (y + 1) * 80, fill="#000")

canvas.bind("<Button-1>", mouse.onLeftClick)
canvas.bind("<ButtonRelease-1>", mouse.onLeftClick)
canvas.bind("<Button-3>", mouse.onRightClick)
canvas.bind("<ButtonRelease-3>", mouse.onRightClick)
canvas.bind("<Motion>", motion)
paint()
canvas.pack()

def generate():
    

b_generate = tk.Button(root, text="Generate", command=generate)

root.mainloop()

