#!/usr/bin/env python3
import tkinter as tk
from PIL import Image, ImageTk
import subprocess
import os

class ThemeSelector(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Select Theme")
        self.geometry("1900x400")
        self.configure(bg="#000000")
        self.attributes("-topmost", True)

        screen_width = self.winfo_screenwidth()
        screen_height = self.winfo_screenheight()
        x = (screen_width - 1900) // 2
        y = (screen_height - 400) // 2
        self.geometry(f"1900x400+{x+10}+{y+10}")

        self.themes = [
            {"name": "Dark Theme", "image": "./theme-dark.jpg", "arg": "dark"},
        ]
        self.current_index = 0

        self.frame = tk.Frame(self, bg="#000000")
        self.frame.pack(pady=20, padx=20, expand=True)

        self.load_theme(self.current_index)

        self.bind("<Left>", lambda event: self.navigate(-1))
        self.bind("<Right>", lambda event: self.navigate(1))
        self.bind("<Return>", lambda event: self.select_theme())
        self.bind("<Escape>", lambda event: self.destroy())

    def load_theme(self, index):
        for widget in self.frame.winfo_children():
            widget.destroy()

        theme = self.themes[index]
        try:
            img = Image.open(theme["image"])
            img = img.resize((320, 180), Image.LANCZOS)
            photo = ImageTk.PhotoImage(img)

            button = tk.Button(
                self.frame,
                image=photo,
                bg="#00ff00",
                activebackground="#ffa500",
                borderwidth=2,
                relief="flat",
                command=lambda: self.select_theme(theme["arg"]),
            )
            button.image = photo
            button.pack()

            label = tk.Label(
                self.frame,
                text=theme["name"],
                fg="#ffffff",
                bg="#000000",
                font=("Arial", 16)
            )
            label.pack(pady=10)
        except Exception as e:
            print(f"Error loading image {theme['image']}: {e}")

    def navigate(self, direction):
        new_index = (self.current_index + direction) % len(self.themes)
        self.current_index = new_index
        self.load_theme(new_index)

    def select_theme(self, arg=None):
        if arg:
            script_path = os.path.abspath("./change-theme.sh")
            if os.path.exists(script_path):
                subprocess.run([script_path, arg])
            else:
                print(f"Script {script_path} not found")
            self.destroy()

if __name__ == "__main__":
    app = ThemeSelector()
    app.mainloop()
