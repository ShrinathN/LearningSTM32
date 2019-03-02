#!/bin/python
#just a little script to test my mad 1334 h4xx0r python skills

import tkinter
from subprocess import call

def Mak():
	lab['text'] = "Compiling..."
	call('make', shell=True)
	lab['text'] = "Idle"

def Makcln():
	lab['text'] = "Cleaning..."
	call('make clean', shell=True)
	lab['text'] = "Idle"
top=tkinter.Tk()
lab = tkinter.Label(text='Idle')
lab.pack()
b1=tkinter.Button(top, text="Make", command=Mak)
b2=tkinter.Button(top, text="Clean", command=Makcln)
b1.pack()
b2.pack()
top.mainloop()