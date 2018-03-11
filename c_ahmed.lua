local open = createMarker(361.82990,173.74300,1008.38281, "cylinder", 1.5,255,6,255)
setElementInterior(open,3)
triggerServerEvent("onPlayerGetData",localPlayer)

font = guiCreateFont("font.ttf",10)


GUIEditor = {
    tab = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

        GUIEditor.window[1] = guiCreateWindow(235, 288, 601, 302, "Bank System By Ahmed_Ly", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[1],false)


        GUIEditor.tabpanel[1] = guiCreateTabPanel(9, 23, 583, 270, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("السحب", GUIEditor.tabpanel[1])

        GUIEditor.button[1] = guiCreateButton(10, 207, 196, 30, "سحب الفلوس", false, GUIEditor.tab[1])
        GUIEditor.button[2] = guiCreateButton(379, 207, 196, 30, "اغلاق", false, GUIEditor.tab[1])
        GUIEditor.label[1] = guiCreateLabel(9, 31, 177, 34, ":فلوسك في المصرف ", false, GUIEditor.tab[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.label[2] = guiCreateLabel(381, 31, 177, 34, "", false, GUIEditor.tab[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
        GUIEditor.edit[1] = guiCreateEdit(84, 101, 390, 34, "", false, GUIEditor.tab[1])

        GUIEditor.tab[2] = guiCreateTab("حفظ فلوسي في المصرف", GUIEditor.tabpanel[1])

        GUIEditor.button[3] = guiCreateButton(6, 205, 210, 35, "حفظ", false, GUIEditor.tab[2])
        GUIEditor.button[4] = guiCreateButton(370, 205, 210, 35, "اغلاق", false, GUIEditor.tab[2])
        GUIEditor.label[3] = guiCreateLabel(9, 38, 193, 39, "فلوسك محفوظ في المصرف:", false, GUIEditor.tab[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
        GUIEditor.label[4] = guiCreateLabel(385, 38, 193, 39, "", false, GUIEditor.tab[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
        GUIEditor.edit[2] = guiCreateEdit(103, 102, 377, 42, "", false, GUIEditor.tab[2])

        GUIEditor.tab[3] = guiCreateTab("تحويل", GUIEditor.tabpanel[1])

        GUIEditor.gridlist[1] = guiCreateGridList(6, 5, 196, 238, false, GUIEditor.tab[3])
		 guiSetFont(GUIEditor.gridlist[1],font)
     players =  guiGridListAddColumn(GUIEditor.gridlist[1], "الاعبين", 0.9)
        GUIEditor.button[5] = guiCreateButton(207, 158, 364, 39, "تحويل", false, GUIEditor.tab[3])
        GUIEditor.button[6] = guiCreateButton(207, 208, 364, 39, "اغلاق", false, GUIEditor.tab[3])
        GUIEditor.edit[3] = guiCreateEdit(211, 96, 358, 47, "", false, GUIEditor.tab[3])
        GUIEditor.label[5] = guiCreateLabel(205, 27, 165, 48, "فلوسك في المصرف :", false, GUIEditor.tab[3])
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        GUIEditor.label[6] = guiCreateLabel(407, 27, 165, 48, " ", false, GUIEditor.tab[3])
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")    
for i = 1,3 do 
 guiSetFont(GUIEditor.edit[i],font)
 guiSetFont(GUIEditor.tab[i],font)
		 end 
 for i = 1,6 do 
 guiSetFont(GUIEditor.button[i],font)
  guiSetFont(GUIEditor.label[i],font)
end 
addEventHandler("onClientMarkerHit",open,
function (hitt)
if  localPlayer == hitt then 
guiSetVisible(GUIEditor.window[1],true)
showCursor(true)
guiGridListClear(GUIEditor.gridlist[1])
for i,v in ipairs(getElementsByType("player")) do 
row = guiGridListAddRow(GUIEditor.gridlist[1])
guiGridListSetItemText(GUIEditor.gridlist[1],row,players,getPlayerName(v),false,false)
guiGridListSetItemColor(GUIEditor.gridlist[1],row,players,math.random(0,255),math.random(0,255),math.random(0,255),255)
end
end
end 
)

addEventHandler("onClientRender",root,
function ()
local data = getElementData(localPlayer,"Bank")
if data then 
guiSetText(GUIEditor.label[2],""..data.."$")
guiSetText(GUIEditor.label[4],""..data.."$")
guiSetText(GUIEditor.label[6],""..data.."$")
else
guiSetText(GUIEditor.label[2],"0 $")
guiSetText(GUIEditor.label[4],"0 $")
guiSetText(GUIEditor.label[6],"0 $")
end
end 
)

addEventHandler("onClientGUIClick",root,
function ()
if source == GUIEditor.button[3] then 
if guiGetText(GUIEditor.edit[2]) ~= "" then 
triggerServerEvent("onPlayerSaveMoney",localPlayer,guiGetText(GUIEditor.edit[2]))
end 
elseif source == GUIEditor.button[2] then 
guiSetVisible(GUIEditor.window[1],false)
showCursor(false)
end
end
)


addEventHandler("onClientGUIClick",root,
function ()
if source ==  GUIEditor.button[1] then 
if guiGetText(GUIEditor.edit[1]) ~= "" then 
triggerServerEvent("onPlayerTakeMoneyFromBank",localPlayer,guiGetText(GUIEditor.edit[1]))
end 
elseif source == GUIEditor.button[4] then 
guiSetVisible(GUIEditor.window[1],false)
showCursor(false)
end
end
)

addEventHandler("onClientGUIClick",root,
function ()
if source  == GUIEditor.button[5] then 
rows = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
if rows ~= -1 then 
local name = guiGridListGetItemText(GUIEditor.gridlist[1],rows,players)
if guiGetText(GUIEditor.edit[3]) ~= "" then 
triggerServerEvent("onPlayerSetData",localPlayer,name,guiGetText(GUIEditor.edit[3]))
end 
end
elseif source ==   GUIEditor.button[6] then 
guiSetVisible(GUIEditor.window[1],false)
showCursor(false)
end
end
)