@compat abstract type PDPageObject end

"""
*PDPageElement* type is a representation of organization of content and content
operators.

The operands are like attributes of the element to be used for any operations.
"""
type PDPageElement <: PDPageObject
  t::Symbol
  version::Tuple{Int,Int}
  noperand::Int
  operands::Vector{CosObject}
  PDPageElement(t::Symbol,ver::Tuple{Int,Int},
                nop::Int,opds::Vector{CosObject})=new(t,ver,nop,opds)
end

PDPageElement(ts::AbstractString,ver::Tuple{Int,Int},nop::Int=0)=
  PDPageElement(Symbol(ts),ver,nop,Vector{CosObject}())

type PDPageObjectGroup <: PDPageObject
  s::PDPageElement
  e::PDPageElement
  objects::Vector{PDPageObject}
end

"""
|Operator|PostScript Equivalent|Description|Table|
|:--------|:----------------------|:------------|------:|
|BX||(PDF 1.1) Begin compatibility section|32|
|EX||(PDF 1.1) End compatibility section|32|
|cm|concat|Concatenate matrix to current transformation matrix|57|
|d|setdash|Set line dash pattern|57|
|gs||(PDF 1.2) Set parameters from graphics state parameter dictionary|57|
|i|setflat|Set flatness tolerance|57|
|j|setlinejoin|Set line join style|57|
|J|setlinecap|Set line cap style|57|
|M|setmiterlimit|Set miter limit|57|
|q|gsave|Save graphics state|57|
|Q|grestore|Restore graphics state|57|
|ri||Set color rendering intent|57|
|w|setlinewidth|Set line width|57|
|c|curveto|Append curved segment to path (three control points)|59|
|h|closepath|Close subpath|59|
|l|lineto|Append straight line segment to path|59|
|m|moveto|Begin new subpath|59|
|re||Append rectangle to path|59|
|v|curveto|Append curved segment to path (initial point replicated)|59|
|y|curveto|Append curved segment to path (final point replicated)|59|
|b|closepath, fill, stroke|Close, fill, and stroke path using nonzero winding number rule|60|
|B|fill, stroke|Fill and stroke path using nonzero winding number rule|60|
|b*|closepath, eofill, stroke|Close, fill, and stroke path using even-odd rule|60|
|B*|eofill, stroke|Fill and stroke path using even-odd rule|60|
|f|fill|Fill path using nonzero winding number rule|60|
|F|fill|Fill path using nonzero winding number rule (obsolete)|60|
|f*|eofill|Fill path using even-odd rule|60|
|n||End path without filling or stroking|60|
|s|closepath, stroke|Close and stroke path|60|
|S|stroke|Stroke path|60|
|W|clip|Set clipping path using nonzero winding number rule|61|
|W*|eoclip|Set clipping path using even-odd rule|61|
|CS|setcolorspace|(PDF 1.1) Set color space for stroking operations|74|
|cs|setcolorspace|(PDF 1.1) Set color space for nonstroking operations|74|
|G|setgray|Set gray level for stroking operations|74|
|g|setgray|Set gray level for nonstroking operations|74|
|K|setcmykcolor|Set CMYK color for stroking operations|74|
|k|setcmykcolor|Set CMYK color for nonstroking operations|74|
|RG|setrgbcolor|Set RGB color for stroking operations|74|
|rg|setrgbcolor|Set RGB color for nonstroking operations|74|
|SC|setcolor|(PDF 1.1) Set color for stroking operations|74|
|sc|setcolor|(PDF 1.1) Set color for nonstroking operations|74|
|SCN|setcolor|(PDF 1.2) Set color for stroking operations\n|||(ICCBased and special colour spaces)|74|
|scn|setcolor|(PDF 1.2) Set color for nonstroking operations\n|||(ICCBased and special colour spaces)|74|
|sh|shfill|(PDF 1.3) Paint area defined by shading pattern|77|
|Do||Invoke named XObject|87|
|BI||Begin inline image object|92|
|EI||End inline image object|92|
|ID||Begin inline image data|92|
|BT||Begin text object|107|
|ET||End text object|107|
|T*||Move to start of next text line|108|
|Td||Move text position|108|
|TD||Move text position and set leading|108|
|Tj|show|Show text|109|
|TJ||Show text, allowing individual glyph positioning|109|
|\'||Move to next line and show text|109|
|\"||Set word and character spacing, move to next line, and show text|109|
|Tc||Set character spacing||
|Tf|selectfont|Set text font and size||
|TL||Set text leading||
|Tr||Set text rendering mode||
|Ts||Set text rise||
|Tw||Set word spacing||
|Tz||Set horizontal text scaling||
|d0|setcharwidth|Set glyph width in Type 3 font|113|
|d1|setcachedevice|Set glyph width and bounding box in Type 3 font|113|
|BDC||(PDF 1.2) Begin marked-content sequence with property list|320|
|BMC||(PDF 1.2) Begin marked-content sequence|320|
|DP||(PDF 1.2) Define marked-content point with property list|320|
|EMC||(PDF 1.2) End marked-content sequence|320|
|MP||(PDF 1.2) Define marked-content point|320|
"""
const PD_CONTENT_OPERATORS=Dict(
"\'"=>[PDPageElement,"\'",(1,0),0],
"\""=>[PDPageElement,"\"",(1,0),0],
"b"=>[PDPageElement,"b",(1,0),0],
"b*"=>[PDPageElement,"b*",(1,0),0],
"B"=>[PDPageElement,"B",(1,0),0],
"B*"=>[PDPageElement,"B*",(1,0),0],
"BDC"=>[PDPageElement,"BDC",(1,2),0],
"BI"=>[PDPageElement,"BI",(1,0),0],
"BMC"=>[PDPageElement,"BMC",(1,2),0],
"BT"=>[PDPageElement,"BT",(1,0),0],
"BX"=>[PDPageElement,"BX",(1,1),0],
"c"=>[PDPageElement,"c",(1,0),0],
"cm"=>[PDPageElement,"cm",(1,0),0],
"cs"=>[PDPageElement,"cs",(1,1),0],
"CS"=>[PDPageElement,"CS",(1,1),0],
"d"=>[PDPageElement,"d",(1,0),0],
"d0"=>[PDPageElement,"d0",(1,0),0],
"d1"=>[PDPageElement,"d1",(1,0),0],
"Do"=>[PDPageElement,"Do",(1,0),0],
"DP"=>[PDPageElement,"DP",(1,2),0],
"EI"=>[PDPageElement,"EI",(1,0),0],
"EMC"=>[PDPageElement,"EMC",(1,2),0],
"ET"=>[PDPageElement,"ET",(1,0),0],
"EX"=>[PDPageElement,"EX",(1,1),0],
"f"=>[PDPageElement,"f",(1,0),0],
"f*"=>[PDPageElement,"f*",(1,0),0],
"F"=>[PDPageElement,"F",(1,0),0],
"g"=>[PDPageElement,"g",(1,0),0],
"G"=>[PDPageElement,"G",(1,0),0],
"gs"=>[PDPageElement,"gs",(1,2),0],
"h"=>[PDPageElement,"h",(1,0),0],
"i"=>[PDPageElement,"i",(1,0),0],
"ID"=>[PDPageElement,"ID",(1,0),0],
"j"=>[PDPageElement,"j",(1,0),0],
"J"=>[PDPageElement,"J",(1,0),0],
"k"=>[PDPageElement,"k",(1,0),0],
"K"=>[PDPageElement,"K",(1,0),0],
"l"=>[PDPageElement,"l",(1,0),0],
"m"=>[PDPageElement,"m",(1,0),0],
"M"=>[PDPageElement,"M",(1,0),0],
"MP"=>[PDPageElement,"MP",(1,2),0],
"n"=>[PDPageElement,"n",(1,0),0],
"q"=>[PDPageElement,"q",(1,0),0],
"Q"=>[PDPageElement,"Q",(1,0),0],
"re"=>[PDPageElement,"re",(1,0),0],
"rg"=>[PDPageElement,"rg",(1,0),0],
"RG"=>[PDPageElement,"RG",(1,0),0],
"ri"=>[PDPageElement,"ri",(1,0),0],
"s"=>[PDPageElement,"s",(1,0),0],
"S"=>[PDPageElement,"S",(1,0),0],
"sc"=>[PDPageElement,"sc",(1,1),0],
"SC"=>[PDPageElement,"SC",(1,1),0],
"scn"=>[PDPageElement,"scn",(1,2),0],
"SCN"=>[PDPageElement,"SCN",(1,2),0],
"sh"=>[PDPageElement,"sh",(1,3),0],
"T*"=>[PDPageElement,"T*",(1,0),0],
"Tc"=>[PDPageElement,"Tc",(1,0),0],
"Td"=>[PDPageElement,"Td",(1,0),0],
"TD"=>[PDPageElement,"TD",(1,0),0],
"Tf"=>[PDPageElement,"Tf",(1,0),0],
"Tj"=>[PDPageElement,"Tj",(1,0),0],
"TJ"=>[PDPageElement,"TJ",(1,0),0],
"TL"=>[PDPageElement,"TL",(1,0),0],
"Tr"=>[PDPageElement,"Tr",(1,0),0],
"Ts"=>[PDPageElement,"Ts",(1,0),0],
"Tw"=>[PDPageElement,"Tw",(1,0),0],
"Tz"=>[PDPageElement,"Tz",(1,0),0],
"v"=>[PDPageElement,"v",(1,0),0],
"w"=>[PDPageElement,"w",(1,0),0],
"W"=>[PDPageElement,"W",(1,0),0],
"W*"=>[PDPageElement,"W*",(1,0),0],
"y"=>[PDPageElement,"y",(1,0),0]
)

import ..Cos: get_pdfcontentops

function get_pdfcontentops(b::Vector{UInt8})
  arr = get(PD_CONTENT_OPERATORS, String(b), CosNull)
  if (arr == CosNull)
    return CosNull
  else
    return arr[1](arr[2], arr[3], arr[4])
  end
end
