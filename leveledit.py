import PIL.Image
import os
import re

input_img = PIL.Image.open(os.path.dirname(__file__) + "/baba.png")
img = PIL.Image.new("P", (16 * 256, 16 * 4))
pal = []
for line in open(os.path.dirname(__file__) + "/palette.asm", "rt"):
    line = line.strip()
    if line.startswith("RGB32_4"):
        line = line.replace(",", " ").replace("$", "").split()
        for n in range(1, 5):
            color = int(line[n], 16)
            pal += [(color >> 16) & 0xFF, (color >> 8) & 0xFF, (color >> 0) & 0xFF]
img.putpalette(pal)


def put_gfx_tile(x, y, tile_nr, pal_nr, flip=False):
    tile_x = (tile_nr & 0x0F) * 8
    tile_y = (tile_nr // 16) * 8
    for yp in range(8):
        for xp in range(8):
            c = input_img.getpixel((tile_x + xp, tile_y + yp))
            c = (c & 3) + pal_nr * 4
            if flip:
                img.putpixel((x + 7 - xp, y + yp), c)
            else:
                img.putpixel((x + xp, y + yp), c)

object_nr = 0
object_names = []
can_rotate = set()
for line in open(os.path.dirname(__file__) + "/objectmetadata.asm", "rt"):
    m = re.match(r" +db \$(..), \$(..), \$(..) ; .. (.+)", line)
    if not m:
        continue
    render_type, tile_id, palette, name = m.groups()
    if name == "TID_NO_OBJECT":
        continue
    object_names.append(name)
    render_type, tile_id, palette = int(render_type, 16), int(tile_id, 16), int(palette, 16)
    if render_type == 0:
        for y in range(4):
            put_gfx_tile(object_nr * 16 + 0, y * 16 + 0, tile_id, palette)
            put_gfx_tile(object_nr * 16 + 8, y * 16 + 0, tile_id, palette)
            put_gfx_tile(object_nr * 16 + 0, y * 16 + 8, tile_id, palette)
            put_gfx_tile(object_nr * 16 + 8, y * 16 + 8, tile_id, palette)
    elif render_type == 2:
        put_gfx_tile(object_nr * 16 + 0, 0, tile_id + 0, palette)
        put_gfx_tile(object_nr * 16 + 8, 0, tile_id + 1, palette)
        put_gfx_tile(object_nr * 16 + 0, 8, tile_id + 16, palette)
        put_gfx_tile(object_nr * 16 + 8, 8, tile_id + 17, palette)

        put_gfx_tile(object_nr * 16 + 0, 16, tile_id + 2, palette)
        put_gfx_tile(object_nr * 16 + 8, 16, tile_id + 3, palette)
        put_gfx_tile(object_nr * 16 + 0, 24, tile_id + 18, palette)
        put_gfx_tile(object_nr * 16 + 8, 24, tile_id + 19, palette)

        put_gfx_tile(object_nr * 16 + 0, 32, tile_id + 4, palette)
        put_gfx_tile(object_nr * 16 + 8, 32, tile_id + 5, palette)
        put_gfx_tile(object_nr * 16 + 0, 40, tile_id + 20, palette)
        put_gfx_tile(object_nr * 16 + 8, 40, tile_id + 21, palette)

        put_gfx_tile(object_nr * 16 + 0, 48, tile_id + 5, palette, flip=True)
        put_gfx_tile(object_nr * 16 + 8, 48, tile_id + 4, palette, flip=True)
        put_gfx_tile(object_nr * 16 + 0, 56, tile_id + 21, palette, flip=True)
        put_gfx_tile(object_nr * 16 + 8, 56, tile_id + 20, palette, flip=True)
        can_rotate.add(name)
    else:
        for y in range(4):
            put_gfx_tile(object_nr * 16 + 0, y * 16 + 0, tile_id, palette)
            put_gfx_tile(object_nr * 16 + 8, y * 16 + 0, tile_id + 1, palette)
            put_gfx_tile(object_nr * 16 + 0, y * 16 + 8, tile_id + 16, palette)
            put_gfx_tile(object_nr * 16 + 8, y * 16 + 8, tile_id + 17, palette)
    object_nr += 1


class Level:
    def __init__(self):
        self.name = "Unknown"
        self.layers = []
        self.layers.append([None] * 16 * 16)
        self.layers.append([None] * 16 * 16)
        self.layers.append([None] * 16 * 16)

    def add(self, yx, name, dir):
        layer_nr = 0
        while self.layers[layer_nr][yx] is not None:
            layer_nr += 1
        self.layers[layer_nr][yx] = (name, dir)


level_list = []
current_level = None
for line in open(os.path.dirname(__file__) + "/levels.asm", "rt"):
    line = line.strip()
    if line.endswith(":"):
        current_level = Level()
        current_level.name = line[:-1].strip()
        level_list.append(current_level)
    direction = 3
    m = re.match(r"db +(TID_[^,]+), \$(..)", line)
    if not m:
        m = re.match(r"db +\$(..), +(TID_[^,]+), \$(..)", line)
        if not m:
            continue
        direction, name, yx = m.groups()
        direction = int(direction, 16) - 0xF0
    else:
        name, yx = m.groups()
    current_level.add(int(yx, 16), name, direction)


import pygame
pygame.init()
img = img.convert("RGB")
surface = pygame.display.set_mode((16 * 16 + 16 * 3, 16 * 16), pygame.HWSURFACE | pygame.DOUBLEBUF | pygame.SCALED)
font = pygame.font.Font(pygame.font.get_default_font(), 12)
pygame.display.set_caption(current_level.name)

pyimg = pygame.image.fromstring(img.tobytes(), img.size, img.mode).convert()
pyimg.set_colorkey(0)

class Button:
    ALL = []
    def __init__(self, x, y, label, callback):
        self.x = x
        self.y = y
        self.label = label
        self.callback = callback
        self.ALL.append(self)
        self._text_surface = None

    def draw(self):
        surface.fill(0x202020, (256 + self.x * 16, self.y * 16, 16, 16))
        if self._text_surface is None:
            self._text_surface = font.render(self.label, True, 0xFFFFFFFF)
        surface.blit(self._text_surface, dest=(256 + self.x * 16 + 8 - self._text_surface.get_width() // 2, self.y * 16 + 8 - self._text_surface.get_height() // 2))


active_layer = 0
current_tile = None
def set_layer(nr):
    global active_layer
    active_layer = nr


def export():
    f = open(os.path.dirname(__file__) + "/levels.asm", "wt")
    f.write('#SECTION "Levels", ROMX, BANK[1] {\n')
    for level in level_list:
        f.write(f"\n{level.name}:\n")
        for layer in level.layers:
            for yx, name_dir in enumerate(layer):
                if name_dir is None:
                    continue
                name, direction = name_dir
                if direction != 3:
                    f.write(f"    db   ${direction+0xF0:02X}, {name}, ${yx:02X}\n")
                else:
                    f.write(f"    db   {name}, ${yx:02X}\n")
        f.write(f"    db   $FF\n")
    f.write('}\n')


def next_level():
    global current_level
    idx = (level_list.index(current_level) + 1) % len(level_list)
    current_level = level_list[idx]
    pygame.display.set_caption(current_level.name)


def shift_level(ox, oy):
    new_layers = []
    for layer in current_level.layers:
        new_layer = [None] * 256
        for y in range(16):
            for x in range(16):
                new_layer[x+y*16] = layer[((x+ox) & 0x0F)+((y+oy)&0x0F)*16]
        new_layers.append(new_layer)
    current_level.layers = new_layers


Button(2, 0, "1", lambda: set_layer(0))
Button(2, 1, "2", lambda: set_layer(1))
Button(2, 2, "3", lambda: set_layer(2))
Button(2, 4, "N", next_level)
Button(2, 5, "E", export)
Button(2, 7, "<", lambda: shift_level(1, 0))
Button(2, 8, ">", lambda: shift_level(-1, 0))
Button(2, 9, "^", lambda: shift_level(0, 1))
Button(2, 10, "v", lambda: shift_level(0, -1))

while True:
    for e in pygame.event.get():
        if e.type == pygame.QUIT:
            exit(0)
        elif e.type == pygame.MOUSEBUTTONDOWN or (e.type == pygame.MOUSEMOTION and any(e.buttons)):
            x = e.pos[0] // 16
            y = e.pos[1] // 16
            if x < 16:
                draw_tile = (e.button == 1) if e.type == pygame.MOUSEBUTTONDOWN else e.buttons[0] != 0
                direction = 3
                if current_level.layers[active_layer][x+y*16] is not None and current_level.layers[active_layer][x+y*16][0] == current_tile and current_tile in can_rotate:
                    direction = (current_level.layers[active_layer][x+y*16][1] + 1) % 4
                current_level.layers[active_layer][x+y*16] = (current_tile, direction) if draw_tile else None
            else:
                x -= 16
                for b in Button.ALL:
                    if b.x == x and b.y == y:
                        b.callback()
                if x * 16 + y < len(object_names):
                    current_tile = object_names[x*16 + y]

    surface.fill(0)
    surface.fill(0x100000, (0, 0, 160, 144))
    surface.fill(0x000010, (256-160, 256-144, 160, 144))
    surface.fill(0x001000, (256-160, 256-144, 64, 32))
    for layer in range(len(current_level.layers)):
        if layer == active_layer:
            pyimg.set_alpha(255)
        else:
            pyimg.set_alpha(100)
        for y in range(16):
            for x in range(16):
                if current_level.layers[layer][x+y*16] is None:
                    continue
                name, direction = current_level.layers[layer][x+y*16]
                tile_id = object_names.index(name)
                surface.blit(pyimg, (x*16, y*16), (tile_id * 16, direction * 16, 16, 16))

    pyimg.set_alpha(255)
    for idx, name in enumerate(object_names):
        x = idx // 16
        y = idx % 16
        surface.fill(0x402040 if current_tile == name else 0x202020, (256 + x * 16, y * 16, 16, 16))
        surface.blit(pyimg, (256 + x * 16, y * 16), (idx * 16, 48, 16, 16))

    for button in Button.ALL:
        button.draw()

    pygame.display.flip()
