# Dennis Cosgrove

class Color
  attr_reader :red, :green, :blue

  def initialize(red, green, blue)
    @red = red
    @green = green
    @blue = blue
  end

  def self.from_unsigned_bytes(red, green, blue)
    Color.new(red / 255.0, green / 255.0, blue / 255.0)
  end

  def ==(other)
    if other.is_a?(Color)
      @red==other.red && @green==other.green && @blue==other.blue
    else
      false
    end
  end

  def eq?(other)
    self == other
  end

  def hash
    [@red, @green, @blue].hash
  end

  def to_ary
    [@red, @green, @blue]
  end

  def to_s
    "#{self.class.name}[#{@red}, #{@green}, #{@blue}]"
  end

  WHITE = Color.new(1, 1, 1)
  RED = Color.new(1, 0, 0)
  GREEN = Color.new(0, 1, 0)
  BLUE = Color.new(0, 0, 1)
  YELLOW = Color.new(1, 1, 0)
  CYAN = Color.new(0, 1, 1)
  MAGENTA = Color.new(1, 0, 1)
  BLACK = Color.new(0, 0, 0)

  # http://mkweb.bcgsc.ca/colorblind/img/colorblindness.palettes.v11.pdf
  #
  # http://mkweb.bcgsc.ca/colorblind/palettes/8.color.blindness.palette.txt
  # color  1-main 000000   0   0   0 black, grey, grey, grey, rich black, grey, cod grey, grey, almost black, grey
  # color  2-main 2271B2  34 113 178 honolulu blue, bluish, strong cornflower blue, spanish blue, medium persian blue, sapphire blue, ocean boat blue, french blue, windows blue, tufts blue
  # color  2-alt  AA0DB4 170  13 180 barney, strong magenta, heliotrope magenta, strong heliotrope, steel pink, barney purple, purple, violet, violet eggplant, deep magenta
  # color  3-main 3DB7E9  61 183 233 summer sky, cyan, picton blue, vivid cerulean, deep sky blue, brilliant cornflower blue, malibu, bright cerulean, cerulean, cerulean
  # color  3-alt  FF54ED 255  84 237 light magenta, violet pink, light brilliant magenta, pink flamingo, light brilliant orchid, brilliant magenta, purple pizzazz, candy pink, blush pink, shocking pink
  # color  4-main F748A5 247  72 165 barbie pink, rose bonbon, wild strawberry, brilliant rose, brilliant rose, magenta, wild strawberry, light brilliant rose, frostbite, brilliant cerise
  # color  4-alt  00B19F   0 177 159 strong opal, tealish, persian green, keppel, topaz, manganese blue, light sea green, sea green light, puerto rico, turquoise
  # color  5-main 359B73  53 155 115 ocean green, sea green, viridian, mother earth, moderate spring green, moderate aquamarine, paolo veronese green, observatory, jungle green, ocean green
  # color  5-alt  EB057A 235   5 122 vivid rose, red purple, mexican pink, bright pink, rose, strong pink, luminous vivid rose, deep pink, winter sky, hot pink
  # color  6-main d55e00 213  94   0 bamboo, smoke tree, red stage, tawny, tenn, tenne, burnt orange, rusty orange, dark orange, mars yellow
  # color  6-alt  F8071D 248   7  29 vivid red, luminous vivid amaranth, ruddy, ku crimson, vivid amaranth, light brilliant red, cherry red, red, red, bright red
  # color  7-main e69f00 230 159   0 gamboge, squash, buttercup, marigold, dark goldenrod, medium goldenrod, fuel yellow, sun, harvest gold, orange
  # color  7-alt  FF8D1A 255 141  26 dark orange, juicy, west side, tangerine, gold drop, pizazz, princeton orange, university of tennessee orange, tangerine, tahiti gold
  # color  8-main f0e442 240 228  66 holiday, buzz, paris daisy, starship, golden fizz, dandelion, gorse, lemon yellow, bright lights, sunflower
  # color  8-alt  9EFF37 158 255  55 french lime, lime, green yellow, green lizard, luminous vivid spring bud, spring frost, vivid spring bud, bright yellow green, spring bud, acid green
  HONOLULU_BLUE = Color.from_unsigned_bytes(34, 113, 178)
  SUMMER_SKY = Color.from_unsigned_bytes(61, 183, 233)
  BARBIE_PINK = Color.from_unsigned_bytes(247, 72, 165)
  OCEAN_GREEN = Color.from_unsigned_bytes(53, 155, 115)
  BAMBOO = Color.from_unsigned_bytes(213, 94, 0)
  GAMBAGE = Color.from_unsigned_bytes(230, 159, 0)
  PARIS_DAISY = Color.from_unsigned_bytes(240, 228, 66)

  # http://mkweb.bcgsc.ca/colorblind/palettes/12.color.blindness.palette.txt
  # color  1-main 9F0162 159   1  98 deep magenta, red violet, strong cerise, lipstick, fresh eggplant, jazzberry jam, dark fuchsia, flirt, dark magenta, cardinal
  # color  1-alt  006A5E   0 106  94 genoa, teal green, dark green blue, pine green, bingo, genoa, cowabunga, mosque, eden, dark aquamarine
  # color  2-main 009F81   0 159 129 paolo veronese green, gossamer, niagara, jeepers creepers, niagara, jungle green, observatory, strong opal, persian green, gossamer
  # color  2-alt  ED0D88 237  13 136 deep pink, mexican pink, hot pink, wild strawberry, deep pink, fluorescent pink, electric pink, magenta, red purple, barbie pink
  # color  3-main FF5AAF 255  90 175 brilliant rose, light brilliant rose, brilliant rose, magenta, hot pink, barbie pink, magenta, bubble gum pink, rose bonbon, bubblegum
  # color  3-alt  00BDA9   0 189 169 tealish, turquoise, puerto rico, topaz, strong opal, keppel, light sea green, sea green light, persian green, dali
  # color  4-main 00FCCF   0 252 207 bright teal, luminous vivid opal, aqua marine, aqua, light brilliant turquoise, vivid turquoise, light brilliant aquamarine, luminous vivid turquoise, vivid opal, brilliant aquamarine
  # color  4-alt  FFC4D4 255 196 212 pale crimson, bubble gum, pink, pale raspberry, orchid pink, cameo pink, pale amaranth, light rose, chantilly, princess
  # color  5-main 8400CD 132   0 205 french violet, dark violet, violet dark, blue purple, blue violet, purple, purple, purple, violet, purple
  # color  5-alt  0058CC   0  88 204 cerulean blue, flat medium blue, royal blue, new car, sapphire, absolute zero, royal blue, violet blue, cerulean blue, cobalt
  # color  6-main 008DF9   0 141 249 dodger blue, dodger blue, brilliant azure, bleu de france, blueberry, brilliant cobalt blue, luminous vivid cornflower blue, bright navy blue, navy blue, soft blue
  # color  6-alt  D208FB 210   8 251 hot purple, vivid orchid, luminous vivid heliotrope, phlox, psychedelic purple, bright purple, electric purple, luminous vivid mulberry, vivid heliotrope, neon purple
  # color  7-main 00C2F9   0 194 249 spiro disco ball, vivid sky blue, cyan, bright sky blue, capri, deep sky blue, luminous vivid cerulean, sky blue deep, deep sky blue, vivid cerulean
  # color  7-alt  FF66FD 255 102 253 pink flamingo, light brilliant magenta, light magenta, blush pink, shocking pink, ultra pink, violet pink, light brilliant heliotrope, pink flamingo, light brilliant orchid
  # color  8-main FFB2FD 255 178 253 plum, plum, rich brilliant lavender, brilliant lavender, electric lavender, plum, lavender rose, very light fuchsia, plum, pale magenta
  # color  8-alt  00EFF9   0 239 249 turquoise, turquoise, bright light blue, medium turquoise, cyan, bright cyan, vivid cyan, brilliant cyan, aqua, cyan
  # color  9-main A40122 164   1  34 strong crimson, alabama crimson, smashing, upsdell red, ruby red, carmine, carmine, red tape, scarlett, shiraz
  # color  9-alt  156D03  21 109   3 japanese laurel, pakistan green, dark green, green dark, deep green, tree green, bilbao, san felix, sap green, dark grass green
  # color 10-main E20134 226   1  52 vivid crimson, geranium lake, red ribbon, medium candy apple red, alizarin crimson, rose madder, red, imperial red, red, crimson
  # color 10-alt  009719   0 151  25 islamic green, true green, green, emerald green, irish green, strong malachite green, india green, kelly green, forest green, grass green
  # color 11-main FF6E3A 255 110  58 burning orange, orange, outrageous orange, flesh, deep carrot orange, outrageous orange, pinkish orange, vivid vermilion, flamingo, burnt orange
  # color 11-alt  00C61B   0 198  27 permanent green, vivid malachite, lime green, green, harlequin green, green, toxic green, green apple, vivid malachite green, kelly green
  # color 12-main FFC33B 255 195  59 bright spark, filmpro golden yellow, goldenrod, saffron, golden rod, goldenrod, sunglow, sunglow, bright sun, macaroni and cheese
  # color 12-alt  00FB1D   0 251  29 luminous vivid emerald green, hot green, radioactive green, electric green, highlighter green, neon green, neon green, luminous vivid sap green, bright green, electric greenend
  JAZZBERRY_JAM = Color.from_unsigned_bytes(159, 1, 98)
  JEEPERS_CREEPERS = Color.from_unsigned_bytes(0, 159, 129)
  #BARBIE_PINK = Color.from_unsigned_bytes(255, 90, 175)
  AQUAMARINE = Color.from_unsigned_bytes(0, 255, 207)
  FRENCH_VIOLET = Color.from_unsigned_bytes(132, 0, 205)
  DODGER_BLUE = Color.from_unsigned_bytes(0, 141, 249)
  CAPRI = Color.from_unsigned_bytes(0, 194, 249)
  PLUM = Color.from_unsigned_bytes(255, 178, 253)
  CARMINE = Color.from_unsigned_bytes(164, 1, 34)
  ALIZARAN_CRIMSON = Color.from_unsigned_bytes(226, 1, 52)
  OUTRAGEOUS_ORANGE = Color.from_unsigned_bytes(255, 110, 58)
  BRIGHT_SPARK = Color.from_unsigned_bytes(255, 195, 59)
end