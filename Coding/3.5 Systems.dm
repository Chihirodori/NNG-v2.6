

var
	SpeechBubbleSettings/SpeechBubble = new()

SpeechBubbleSettings
	var
		Font/font
		icon
SpeechBubble
	var
		layer = 88
		atom/owner
		atom/movable/text
		list/__text
		width = 5
	New(mob/a, txt)
		..()
		owner = a
		var/atom/loc = owner
		while(!isturf(loc))
			loc = loc.loc
		text = new/obj/text(loc)
		text:owner=a
		text.pixel_x = -56

		__text(txt)
		text.pixel_y=30
		spawn(200)del src
	Del()
		del text
		..()
	proc
		Move(turf/t)
			..()
			text.loc = t
		__text(t)
			t = SpeechBubble.font.wrap_text(t, width * 32 - 12)
			if(__text)
				for(var/i in __text)
					text.overlays -= i
					del i
				__text.Cut()
			else
				__text = list()
			var/check=length(t)
			var/linesam=1
			while(check>24)
				check-=24
				linesam++
			var/px = 0
			var/py = 16 + SpeechBubble.font.line_height*linesam/2
			for(var/i = 1 to length(t))
				var/char = copytext(t, i, i + 1)
				if(char == "\n")
					px = 0
					py -= SpeechBubble.font.line_height
					linesam--
					continue
				var/image/symbol = image(SpeechBubble.font.icon, icon_state = char, layer = layer)
				symbol.pixel_x = px
				symbol.pixel_y = py
				var/image/ovlay = image('sayov.dmi', "[owner:village]", layer = layer-1)
				ovlay.pixel_x = px-1
				ovlay.pixel_y = py-1
				__text += symbol
				if(linesam==1)
					symbol.pixel_x+=72-check*3
					ovlay.pixel_x+=72-check*3
				text.overlays += symbol
				text.overlays += ovlay
				px += 6 + SpeechBubble.font.spacing
mob
	proc
		speech_bubble(ownerz,txt, duration = 0)
			for(var/obj/text/G in world)
				if(G:owner==ownerz)del G
			var/SpeechBubble/s = new(ownerz, txt)
			s:owner=src
			saidstuff++
			specmove++
			if(duration)
				spawn(duration)
					specmove--
					saidstuff--
					del s
			return s
Font
	TrebuchetMS
		icon = 'sayfont.dmi'

		// see fonts.dm for descriptions of these vars
		char_width = 6
		spacing = 0
		line_height = 6
obj/text
	name=""
	animate_movement=2
	New()
		..()
		spawn(200)del src

Font
	var
		icon
		list/char_width = list()
		spacing = 1
		line_height = 16
	proc
		wrap_text(txt, line_width)
			var/list/words = list()
			var/word = ""
			for(var/i = 1 to length(txt))
				var/c = copytext(txt, i, i + 1)
				if(c == " ")
					words += word
					word = ""
				else
					word += c
			if(word)
				words += word
			var/px = 0
			var/output = ""
			var/space = ""
			for(var/i = 1 to words.len)
				word = "[space][words[i]]"
				var/word_width = word_width(word)
				if(px + word_width < line_width)
					output += "[word]"
					space = " "
					px += word_width
				else
					word = words[i]
					word_width = word_width(word)
					if(word_width > line_width)
						var/list/parts = chop_word(word, px, line_width)
						for(var/p in parts)
							output += p
						px = word_width(parts[parts.len])
						space = " "
					else
						output += "\n[word]"
						space = " "
						px = word_width
			return output
		text_width(txt)
			return word_width(txt)
		word_width(word)
			var/width = 0
			for(var/i = 1 to length(word))
				width += 6
				if(i < length(word))
					width += spacing
			return width
		cut_text(txt, width_limit)
			return cut_word(txt, width_limit)
		cut_word(word, width_limit)
			var/width = 0
			var/word_part = ""
			for(var/i = 1 to length(word))
				var/char = copytext(word, i, i + 1)
				width += 6
				if(width > width_limit)
					return word_part
				word_part += char
				if(i < length(word))
					width += spacing
			return word_part
		chop_word(word, px, line_width)
			var/line_width_left = line_width - px
			var/word_width = word_width(word)
			if(word_width <= line_width_left)
				return list(word)
			var/word_part = ""
			word_width = 0
			for(var/i = 1 to length(word))
				var/char = copytext(word, i, i + 1)
				if(word_width(word_part + char) > line_width_left)
					var/remainder = copytext(word, length(word_part) + 1)
					return list(word_part, "\n") + chop_word(remainder, 0, line_width)
				word_part += char
			return list(word_part)


obj
	Max_Obj_Letters
		layer=FLY_LAYER-1
		icon='Letters2.dmi'
	Max_Obj_Letters2
		layer=FLY_LAYER
		icon='Letters.dmi'
mob/var/Max_Red = 0
mob/var/Max_Green = 0
mob/var/Max_Blue = 0
mob/var/Max_Name = list()
mob/var/Max_Wait_Time = 25

mob
	proc
		mouseovername()
			var/MAX_Name = src.name
			Max_Name = list()
			var/list/Max_Letters = list()
			var/Max_Balance =15- (lentext(MAX_Name)*3)
			for(var/M = 1, M < lentext(MAX_Name) + 1, M++)
				Max_Letters += copytext(MAX_Name, M, M+1)
			if(tmpvillage=="Leaf")
				Max_Red=30
				Max_Green=200
				Max_Blue=30
			if(tmpvillage=="Sand")
				Max_Red=210
				Max_Green=180
				Max_Blue=150
			if(tmpvillage=="Sound")
				Max_Red=155
				Max_Green=155
				Max_Blue=155
			if(tmpvillage=="None")
				Max_Red=255
				Max_Green=255
				Max_Blue=255
			if(tmpvillage=="Akatsuki")
				Max_Red=200
				Max_Green=20
				Max_Blue=20
			for(var/Max_X in Max_Letters)
				var/obj/Max_Obj_Letters/M_O_L = new /obj/Max_Obj_Letters
				M_O_L.icon_state = Max_X
				M_O_L.pixel_x = Max_Balance
				M_O_L.pixel_y = -16
				M_O_L.icon += rgb(Max_Red,Max_Green,Max_Blue)
				M_O_L.overlays+='Letters.dmi'
				src.Max_Name += M_O_L
				Max_Balance += 6











world/New()
	..()
	HtmlAssosciate("aliceblue","f0f8ff")
	HtmlAssosciate("antiquewhite","faebd7")
	HtmlAssosciate("aqua","00ffff")
	HtmlAssosciate("aquamarine","7fffd4")
	HtmlAssosciate("azure","f0ffff")
	HtmlAssosciate("beige","f5f5dc")
	HtmlAssosciate("bisque","ffe4c4")
	HtmlAssosciate("black","000000")
	HtmlAssosciate("blanchedalmond","ffebcd")
	HtmlAssosciate("blue","0000ff")
	HtmlAssosciate("blueviolet","8a2be2")
	HtmlAssosciate("brown","a52a2a")
	HtmlAssosciate("burlywood","deb887")
	HtmlAssosciate("cadetblue","5f9ea0")
	HtmlAssosciate("chartreuse","7fff00")
	HtmlAssosciate("chocolate","d2691e")
	HtmlAssosciate("coral","ff7f50")
	HtmlAssosciate("cornflowerblue","6495ed")
	HtmlAssosciate("cornsilk","fff8dc")
	HtmlAssosciate("crimson","dc143c")
	HtmlAssosciate("cyan","00ffff")
	HtmlAssosciate("darkblue","00008b")
	HtmlAssosciate("darkcyan","008b8b")
	HtmlAssosciate("darkgoldenrod","b8b60b")
	HtmlAssosciate("darkgrey","a9a9a9")
	HtmlAssosciate("darkgreen","006400")
	HtmlAssosciate("darkkhaki","bdb76b")
	HtmlAssosciate("darkmagenta","8b008b")
	HtmlAssosciate("darkolivegreen","556b2f")
	HtmlAssosciate("darkorange","ff8c00")
	HtmlAssosciate("darkorchid","9932cc")
	HtmlAssosciate("darkred","8b0000")
	HtmlAssosciate("darksalmon","e9967a")
	HtmlAssosciate("darkseagreen","8fbc8f")
	HtmlAssosciate("darkslateblue","483d8b")
	HtmlAssosciate("darkslategray","2f4f4f")
	HtmlAssosciate("darkturquoise","00ced1")
	HtmlAssosciate("darkviolet","9400d3")
	HtmlAssosciate("deeppink","ff1493")
	HtmlAssosciate("deepskyblue","00bfff")
	HtmlAssosciate("dimgrey","696969")
	HtmlAssosciate("dodgerblue","1e90ff")
	HtmlAssosciate("firebrick","b22222")
	HtmlAssosciate("floralwhite","fffaf0")
	HtmlAssosciate("forestgreen","228b22")
	HtmlAssosciate("fuchsia","ff00ff")
	HtmlAssosciate("gainsboro","dcdcdc")
	HtmlAssosciate("ghostwhite","f8f8ff")
	HtmlAssosciate("gold","ffd700")
	HtmlAssosciate("goldenrod","daa520")
	HtmlAssosciate("grey","808080")
	HtmlAssosciate("green","008000")
	HtmlAssosciate("greenyellow","adff2f")
	HtmlAssosciate("honeydew","f0fff0")
	HtmlAssosciate("hotpink","ff69b4")
	HtmlAssosciate("indianred","cd5c5c")
	HtmlAssosciate("indigo","4b0082")
	HtmlAssosciate("ivory","fffff0")
	HtmlAssosciate("khaki","f0e68c")
	HtmlAssosciate("lavender","e6e6fa")
	HtmlAssosciate("lavenderblush","fff0f5")
	HtmlAssosciate("lawngreen","7cfc00")
	HtmlAssosciate("lemonchiffon","fffacd")
	HtmlAssosciate("lightblue","add8e6")
	HtmlAssosciate("lightcoral","f08080")
	HtmlAssosciate("lightcyan","e0ffff")
	HtmlAssosciate("lightgoldenrodyellow","fafad2")
	HtmlAssosciate("lightgreen","90ee90")
	HtmlAssosciate("lightgrey","d3d3d3")
	HtmlAssosciate("lightpink","ffb6c1")
	HtmlAssosciate("lightsalmon","ffa07a")
	HtmlAssosciate("lightseagreen","20b2aa")
	HtmlAssosciate("lightskyblue","87cefa")
	HtmlAssosciate("lightslategrey","778899")
	HtmlAssosciate("lightsteelblue","b0c4de")
	HtmlAssosciate("lightyellow","ffffe0")
	HtmlAssosciate("lime","00ff00")
	HtmlAssosciate("limegreen","32cd32")
	HtmlAssosciate("linen","faf0e6")
	HtmlAssosciate("magenta","ff00ff")
	HtmlAssosciate("maroon","800000")
	HtmlAssosciate("mediumaquamarine","66cdaa")
	HtmlAssosciate("mediumblue","0000cd")
	HtmlAssosciate("mediumorchid","ba55d3")
	HtmlAssosciate("mediumpurple","9370db")
	HtmlAssosciate("mediumseagreen","3cb371")
	HtmlAssosciate("mediumslateblue","7b68ee")
	HtmlAssosciate("mediumspringgreen","00fa9a")
	HtmlAssosciate("mediumturquoise","48d1cc")
	HtmlAssosciate("mediumvioletred","c71585")
	HtmlAssosciate("midnightblue","191970")
	HtmlAssosciate("mintcream","f5fffa")
	HtmlAssosciate("mistyrose","ffe4e1")
	HtmlAssosciate("moccasin","ffe4b5")
	HtmlAssosciate("navajowhite","ffdead")
	HtmlAssosciate("navy","000080")
	HtmlAssosciate("oldlace","fdf5e6")
	HtmlAssosciate("olive","808000")
	HtmlAssosciate("olivedrab","6b8e23")
	HtmlAssosciate("orange","ffa500")
	HtmlAssosciate("orangered","ff4500")
	HtmlAssosciate("orchid","da70d6")
	HtmlAssosciate("palegoldenrod","eee8aa")
	HtmlAssosciate("palegreen","98fb98")
	HtmlAssosciate("paleturquoise","afeeee")
	HtmlAssosciate("palevioletred","db7093")
	HtmlAssosciate("papayawhip","ffefd5")
	HtmlAssosciate("peachpuff","ffdab9")
	HtmlAssosciate("peru","cd853f")
	HtmlAssosciate("pink","ffc0cd")
	HtmlAssosciate("plum","dda0dd")
	HtmlAssosciate("powderblue","b0e0e6")
	HtmlAssosciate("purple","800080")
	HtmlAssosciate("red","ff0000")
	HtmlAssosciate("rosybrown","bc8f8f")
	HtmlAssosciate("royalblue","4169e1")
	HtmlAssosciate("saddlebrown","8b4513")
	HtmlAssosciate("salmon","fa8072")
	HtmlAssosciate("sandybrown","f4a460")
	HtmlAssosciate("seagreen","2e8b57")
	HtmlAssosciate("seashell","fff5ee")
	HtmlAssosciate("sienna","a0522d")
	HtmlAssosciate("silver","c0c0c0")
	HtmlAssosciate("skyblue","87ceed")
	HtmlAssosciate("slateblue","6a5acd")
	HtmlAssosciate("slategray","708090")
	HtmlAssosciate("snow","fffafa")
	HtmlAssosciate("springgreen","00ff7f")
	HtmlAssosciate("steelblue","4682b4")
	HtmlAssosciate("tan","d2b48c")
	HtmlAssosciate("teal","008080")
	HtmlAssosciate("thistle","d8bfd8")
	HtmlAssosciate("tomato","ff6347")
	HtmlAssosciate("turquoise","40e0d0")
	HtmlAssosciate("violet","ee82ee")
	HtmlAssosciate("wheat","f5deb3")
	HtmlAssosciate("white","ffffff")
	HtmlAssosciate("whitesmoke","f5f5f5")
	HtmlAssosciate("yellow","ffff00")
	HtmlAssosciate("yellowgreen","a9cd32")

var/html_colours[0]

proc/HtmlAssosciate(colour, html)
	html_colours["[colour]"] = html


proc/colour2html(colour)
	var/T
	for(T in html_colours)
		if(T == colour) break
	if(!T)
		world.log << "Warning!  Could not find matching colour entry for '[colour]'."
		return "#FFFFFF"

	return ("#" + uppertext(html_colours["[colour]"]) )
