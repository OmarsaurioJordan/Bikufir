extends Control

var modalidad = ""
var w = null

func _ready():
	randomize()
	AclararTodo(0.1)
	w = get_node("ViewC/View")
	w.get_node("Monigote/Piel").self_modulate = get_node("Piel/Blatin").self_modulate
	for b in get_node("Item").get_children():
		b.get_node("Back").self_modulate = get_node("Color/Bred").self_modulate
		b.get_node("Front").self_modulate = get_node("Color/Bred").self_modulate
		b.get_node("Moni").self_modulate = get_node("Piel/Bblanco").self_modulate
	CambioModo("")
	Open()

func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		Save()

func AclararTodo(factor):
	var n
	for c in get_node("Color").get_children():
		n = c.self_modulate
		c.self_modulate = Color(
			min(1, n.r + factor),
			min(1, n.g + factor),
			min(1, n.b + factor))
	for c in get_node("Piel").get_children():
		n = c.self_modulate
		c.self_modulate = Color(
			min(1, n.r + factor),
			min(1, n.g + factor),
			min(1, n.b + factor))

func CambioModo(modo):
	modalidad = modo
	var spr = GetSpriteModo(modo)
	if modo == "ojospiel":
		get_node("Piel").visible = true
		get_node("Color").visible = false
		var piel = w.get_node("Monigote/Piel")
		for c in get_node("Piel").get_children():
			if c.self_modulate == piel.self_modulate:
				c.text = "X"
			else:
				c.text = ""
	elif modo == "tatuajesu" or modo == "tatuajesd":
		get_node("Piel").visible = false
		get_node("Color").visible = false
	elif modo != "":
		get_node("Piel").visible = false
		get_node("Color").visible = true
		for c in get_node("Color").get_children():
			if c.self_modulate == spr.self_modulate:
				c.text = "X"
			else:
				c.text = ""
	else:
		get_node("Piel").visible = false
		get_node("Color").visible = false
		get_node("Item").visible = false
	if modo != "":
		get_node("Item").visible = true
		for b in get_node("Item").get_children():
			b.disabled = b.name == "B" + str(spr.frame)
			b.get_node("Back").visible = modo == "cabello"
			b.get_node("Front").visible = modo != "cabello"
			b.get_node("Back").texture = spr.texture
			b.get_node("Back").frame = int(b.name.replace("B", ""))
			b.get_node("Front").texture = spr.texture
			b.get_node("Front").frame = int(b.name.replace("B", ""))

func GetSpriteModo(modo):
	match modo:
		"sombrero":
			return w.get_node("Monigote/Sombrero")
		"cabello":
			return w.get_node("Monigote/Cabello")
		"pelo":
			return w.get_node("Monigote/Pelo")
		"gafas":
			return w.get_node("Monigote/Gafas")
		"barba":
			return w.get_node("Monigote/Barba")
		"ojospiel":
			return w.get_node("Monigote/Ojos")
		"collar":
			return w.get_node("Monigote/Cuellera")
		"camisa":
			return w.get_node("Monigote/Camisa")
		"chaqueta":
			return w.get_node("Monigote/Chaleco")
		"mangas":
			return w.get_node("Monigote/Mangas")
		"interior":
			return w.get_node("Monigote/Interior")
		"pantalon":
			return w.get_node("Monigote/Pantalon")
		"falda":
			return w.get_node("Monigote/Falda")
		"calzado":
			return w.get_node("Monigote/Calzado")
		"tatuajesu":
			return w.get_node("Monigote/TatuajeSup")
		"tatuajesd":
			return w.get_node("Monigote/TatuajeInf")
	return null

func CambioColor(colorName):
	var ext = []
	var spr = GetSpriteModo(modalidad)
	if spr.name == "Cabello" or spr.name == "Pelo" or spr.name == "Barba":
		ext = [
			w.get_node("Monigote/Barba"),
			w.get_node("Monigote/Cabello"),
			w.get_node("Monigote/Pelo")
		]
	for c in get_node("Color").get_children():
		if c.name == colorName:
			c.text = "X"
			if ext.empty():
				spr.self_modulate = c.self_modulate
			else:
				for s in ext:
					s.self_modulate = c.self_modulate
		else:
			c.text = ""

func CambioPiel(colorName):
	for c in get_node("Piel").get_children():
		if c.name == colorName:
			c.text = "X"
			w.get_node("Monigote/Piel").self_modulate = c.self_modulate
		else:
			c.text = ""

func CambioItem(item):
	var spr = GetSpriteModo(modalidad)
	spr.frame = item
	for b in get_node("Item").get_children():
		b.disabled = b.name == "B" + str(item)

# botones de seleccion de modalidad ....................................

func _on_Bsombrero_pressed():
	CambioModo("sombrero")

func _on_Bcabello_pressed():
	CambioModo("cabello")

func _on_Bpelo_pressed():
	CambioModo("pelo")

func _on_Bgafas_pressed():
	CambioModo("gafas")

func _on_Bfondo_pressed():
	var i = w.get_node("Monigote/Fondo").frame + 1
	if i == w.get_node("Monigote/Fondo").hframes:
		i = 0
	w.get_node("Monigote/Fondo").frame = i

func _on_BojosPiel_pressed():
	CambioModo("ojospiel")

func _on_Bbarba_pressed():
	CambioModo("barba")

func _on_Bcollar_pressed():
	CambioModo("collar")

func _on_Bcamisa_pressed():
	CambioModo("camisa")

func _on_Bchaqueta_pressed():
	CambioModo("chaqueta")

func _on_Bmangas_pressed():
	CambioModo("mangas")

func _on_Binterior_pressed():
	CambioModo("interior")

func _on_Bpantalon_pressed():
	CambioModo("pantalon")

func _on_Bfalda_pressed():
	CambioModo("falda")

func _on_Bcalzado_pressed():
	CambioModo("calzado")

func _on_BtatuajesU_pressed():
	CambioModo("tatuajesu")

func _on_BtatuajesD_pressed():
	CambioModo("tatuajesd")

# botones de color de piel .................................................

func _on_Bblanco_pressed():
	CambioPiel("Bblanco")

func _on_Blatin_pressed():
	CambioPiel("Blatin")

func _on_Bmestize_pressed():
	CambioPiel("Bmestize")

func _on_Bamarillo_pressed():
	CambioPiel("Bamarillo")

func _on_Bhindi_pressed():
	CambioPiel("Bhindi")

func _on_Brojo_pressed():
	CambioPiel("Brojo")

func _on_Bnegro_pressed():
	CambioPiel("Bnegro")

# botones de color de ropajes .............................................

func _on_Bred_pressed():
	CambioColor("Bred")

func _on_Borange_pressed():
	CambioColor("Borange")

func _on_Byellow_pressed():
	CambioColor("Byellow")

func _on_Blime_pressed():
	CambioColor("Blime")

func _on_Bgreen_pressed():
	CambioColor("Bgreen")

func _on_Btea_pressed():
	CambioColor("Btea")

func _on_Baqua_pressed():
	CambioColor("Baqua")

func _on_Bblue_pressed():
	CambioColor("Bblue")

func _on_Bpurple_pressed():
	CambioColor("Bpurple")

func _on_Bfuchsia_pressed():
	CambioColor("Bfuchsia")

func _on_Bwhite_pressed():
	CambioColor("Bwhite")

func _on_Bgray_pressed():
	CambioColor("Bgray")

func _on_Bblack_pressed():
	CambioColor("Bblack")

func _on_Bblood_pressed():
	CambioColor("Bblood")

func _on_Bskin_pressed():
	CambioColor("Bskin")

func _on_Byellow2_pressed():
	CambioColor("Byellow2")

func _on_Bmusge_pressed():
	CambioColor("Bmusge")

func _on_Bgreen2_pressed():
	CambioColor("Bgreen2")

func _on_Btea2_pressed():
	CambioColor("Btea2")

func _on_Baqua2_pressed():
	CambioColor("Baqua2")

func _on_Bblue2_pressed():
	CambioColor("Bblue2")

func _on_Bpurple2_pressed():
	CambioColor("Bpurple2")

func _on_Bfuchsia2_pressed():
	CambioColor("Bfuchsia2")

func _on_Bcaqui_pressed():
	CambioColor("Bcaqui")

func _on_Bbrown_pressed():
	CambioColor("Bbrown")

func _on_Bdark_pressed():
	CambioColor("Bdark")

# botones de seleccion de estilo .........................................

func _on_B10_pressed():
	CambioItem(10)

func _on_B9_pressed():
	CambioItem(9)

func _on_B8_pressed():
	CambioItem(8)

func _on_B7_pressed():
	CambioItem(7)

func _on_B6_pressed():
	CambioItem(6)

func _on_B5_pressed():
	CambioItem(5)

func _on_B4_pressed():
	CambioItem(4)

func _on_B3_pressed():
	CambioItem(3)

func _on_B2_pressed():
	CambioItem(2)

func _on_B1_pressed():
	CambioItem(1)

func _on_B0_pressed():
	CambioItem(0)

# guardar y abrir personajes

func Save():
	var file = File.new()
	file.open("user://config.save", File.WRITE)
	var s = SaveMan()
	file.store_string(s)
	file.close()

func Open():
	var file = File.new()
	if file.file_exists("user://config.save"):
		file.open("user://config.save", File.READ)
		var s = file.get_as_text()
		file.close()
		OpenMan(s)

func SaveMan():
	var txt = []
	for t in w.get_node("Monigote").get_children():
		txt.append(t.frame)
		txt.append(t.self_modulate.r)
		txt.append(t.self_modulate.g)
		txt.append(t.self_modulate.b)
	return ",".join(txt)

func OpenMan(txt):
	var pts = txt.split(",")
	if pts.size() != w.get_node("Monigote").get_child_count() * 4:
		return false
	var n = 0
	var c
	for t in w.get_node("Monigote").get_children():
		t.frame = int(pts[n])
		c = Color(float(pts[n + 1]), float(pts[n + 2]), float(pts[n + 3]))
		t.self_modulate = c
		n += 4
	return true

# administracion botones ..............................................

func _on_Bexport_pressed():
	get_node("FileSave").show()

func _on_Bcopy_pressed():
	Save()
	OS.clipboard = SaveMan()
	get_node("AudSave").play()

func _on_Bpaste_pressed():
	if OpenMan(OS.clipboard):
		get_node("AudOpen").play()

func _on_Bclear_pressed():
	for p in w.get_node("Monigote").get_children():
		p.frame = 0
		p.self_modulate = Color(1, 1, 1)
	w.get_node("Monigote/Piel").self_modulate = get_node("Piel/Blatin").self_modulate
	CambioModo("")

func _on_BrCloths_pressed():
	var filtro = ["Calzado", "Interior", "Pantalon", "Falda", "Mangas",
		"Camisa", "Chaleco", "Cuellera", "Gafas", "Sombrero"]
	RandomMonigote(filtro)

func _on_BrFace_pressed():
	var filtro = ["Pelo", "Barba", "Ojos", "Piel", "TatuajeInf", "TatuajeSup",
		"Cabello"]
	RandomMonigote(filtro)

func _on_BrAll_pressed():
	RandomMonigote()

func RandomMonigote(filtro=[]):
	var tot
	var aux
	var prop = lerp(0.1, 0.9, randf())
	for p in w.get_node("Monigote").get_children():
		if not filtro.has(p.name) and not filtro.empty():
			continue
		if p.name == "Fondo":
			p.frame = randi() % 11
		elif randf() < prop:
			p.frame = 0
			p.self_modulate = Color(1, 1, 1)
			if p.name == "Piel":
				w.get_node("Monigote/Piel").self_modulate =\
					get_node("Piel/Blatin").self_modulate
		elif p.name == "Piel":
			tot = get_node("Piel").get_child_count()
			aux = get_node("Piel").get_children()[randi() % tot]
			p.self_modulate = aux.self_modulate
		elif p.name == "Ojos" or p.name == "TatuajeSup" or p.name == "TatuajeInf":
			p.frame = randi() % 11
		else:
			p.frame = randi() % 11
			tot = get_node("Color").get_child_count()
			aux = get_node("Color").get_children()[randi() % tot]
			p.self_modulate = aux.self_modulate
			if p.name == "Pelo" or p.name == "Barba" or p.name == "Cabello":
				w.get_node("Monigote/Pelo").self_modulate = aux.self_modulate
				w.get_node("Monigote/Barba").self_modulate = aux.self_modulate
				w.get_node("Monigote/Cabello").self_modulate = aux.self_modulate
	CambioModo("")

func _on_FileDialog_file_selected(path):
	var img = get_node("ViewC/View").get_texture().get_data()
	img.flip_y()
	img.save_png(path)
