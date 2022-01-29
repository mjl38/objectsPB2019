$PBExportHeader$w_principal.srw
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
type st_1 from statictext within w_principal
end type
type cbx_exclude_dw from checkbox within w_principal
end type
type cb_buscar from commandbutton within w_principal
end type
type cbx_include_dw from checkbox within w_principal
end type
type cb_borrar_repts from commandbutton within w_principal
end type
type cb_excel from commandbutton within w_principal
end type
type cb_compare from commandbutton within w_principal
end type
type cb_exportar1 from commandbutton within w_principal
end type
type sle_objeto from singlelineedit within w_principal
end type
type cbx_exacta from checkbox within w_principal
end type
type cb_printsetup from commandbutton within w_principal
end type
type cb_imprimir from commandbutton within w_principal
end type
type cb_mostrar_todos from commandbutton within w_principal
end type
type cb_repts from commandbutton within w_principal
end type
type cb_exportar2 from commandbutton within w_principal
end type
type cb_localizar from commandbutton within w_principal
end type
type sle_objeto2 from singlelineedit within w_principal
end type
type cbx_mayus_minus from checkbox within w_principal
end type
type rte_find from richtextedit within w_principal
end type
type dw_obj from datawindow within w_principal
end type
type gb_busquedas from groupbox within w_principal
end type
end forward

global type w_principal from window
integer width = 5847
integer height = 2592
boolean titlebar = true
string title = "Objets Powerbuilder (PB 2021)"
string menuname = "m_dummy"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = mdihelp!
long backcolor = 81324524
mdi_1 mdi_1
st_1 st_1
cbx_exclude_dw cbx_exclude_dw
cb_buscar cb_buscar
cbx_include_dw cbx_include_dw
cb_borrar_repts cb_borrar_repts
cb_excel cb_excel
cb_compare cb_compare
cb_exportar1 cb_exportar1
sle_objeto sle_objeto
cbx_exacta cbx_exacta
cb_printsetup cb_printsetup
cb_imprimir cb_imprimir
cb_mostrar_todos cb_mostrar_todos
cb_repts cb_repts
cb_exportar2 cb_exportar2
cb_localizar cb_localizar
sle_objeto2 sle_objeto2
cbx_mayus_minus cbx_mayus_minus
rte_find rte_find
dw_obj dw_obj
gb_busquedas gb_busquedas
end type
global w_principal w_principal

type prototypes
FUNCTION long GetWindowLong (ulong hWnd, int nIndex) & 
   LIBRARY "USER32.DLL"  ALIAS FOR "GetWindowLongA"
FUNCTION long SetWindowLong (ulong hWnd, int nIndex, long dwNewLong) & 
   LIBRARY "USER32.DLL" ALIAS FOR "SetWindowLongA"
FUNCTION long SetLayeredWindowAttributes & 
  (long hWnd, Long crKey , char /*Byte*/ bAlpha , Long dwFlags) & 
     LIBRARY "USER32.DLL" 


Function boolean AnimateWindow( long lhWnd, long lTm, long lFlags ) library 'user32.dll'
end prototypes

type variables
long il_start, il_start2
datastore ids_objetos, ids_objetos2
string is_codigo[], is_codigo2[]
string is_pbls[], is_pbls2[]

constant char NO_EXISTE_DESTINO 	= Char('~h4C')
constant char NO_EXISTE_ORIGEN 	= Char('~h4A')
constant char IGUALES 		= Char('~h4B')
constant char CAMBIADOS		= Char('~h37')
constant char NO_USADO		= Char('~h4E')

char iC_modo = 't'
constant char REPETIDOS = 'r'
constant char TODOS		= 't'
constant char COMPARACION = 'c'

end variables

forward prototypes
public function string wf_export_objeto (string as_libreria, string as_objeto, string as_tipo)
private function integer wf_importar_v5 (readonly string as_importstring, string as_tipo, readonly long al_i)
private function integer wf_importar_v5_2 (readonly string as_importstring, readonly string as_tipo, readonly long al_i)
private function libexporttype wf_tipo_objeto (readonly string as_tipo)
end prototypes

public function string wf_export_objeto (string as_libreria, string as_objeto, string as_tipo);string ls_codigo

LibExportType llet



llet = wf_tipo_objeto (as_tipo)

if isnull(llet) then // caso de por ejemplo proxy objects

	return ''

end if

ls_codigo = LibraryExport(as_libreria, as_objeto,  llet)
ls_codigo = trim(ls_codigo)

if isnull(ls_codigo) then

	messagebox("wf_export_objeto", "null value passed to function")

elseif ls_codigo = "" then

	messagebox("wf_export_objeto", "Error exporting object: " + as_libreria + "\" + as_objeto +  " of type: " + as_tipo)

end if

// get rid of trailing enters and spaces
do while true
	if right(ls_codigo, 2) = "~r~n" then
		ls_codigo = mid(ls_codigo, 1, len(ls_codigo) - 2)
		ls_codigo = rightTrim(ls_codigo)
	else
		exit // non return found
	end if
loop

ls_codigo += "~r~n" // so you can select all cut and paste in edited source code, prefer to have one enter at the end of source code

return ls_codigo



end function

private function integer wf_importar_v5 (readonly string as_importstring, string as_tipo, readonly long al_i);//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirDataWindow!)
//	wf_importar(ls_temp, "datawindow")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirFunction!)
//	wf_importar(ls_temp, "function")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirMenu!)
//	wf_importar(ls_temp, "menu")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirPipeline!)
//	wf_importar(ls_temp, "pipeline")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirProject!)
//	wf_importar(ls_temp, "project")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirQuery!)
//	wf_importar(ls_temp, "query")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirStructure!)
//	wf_importar(ls_temp, "structure")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirUserObject!)
//	wf_importar(ls_temp, "userobject")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirWindow!)
//	wf_importar(ls_temp, "window")
int li_importadas 
long ll_j

li_importadas = ids_objetos.importString( as_importstring)
if not li_importadas > 0 then return 1

for ll_j = il_start to li_importadas + il_start - 1
	ids_objetos.object.pbl[ll_j] = is_pbls[al_i]
	ids_objetos.object.indice[ll_j] = ll_j // para luego saber con qué índice buscar is_código[], por si hay sort()
	// v5
	ids_objetos.object.tipo[ll_j] = as_tipo
	//--
	ids_objetos.object.idx_lib[ll_j] = al_i
	is_codigo[ll_j] = wf_export_objeto (is_pbls[al_i], ids_objetos.object.objeto[ll_j], as_tipo)
	SetMicroHelp("Exporting object: " + ids_objetos.object.objeto[ll_j] + ' ...')
next

il_start += li_importadas 


return 1

end function

private function integer wf_importar_v5_2 (readonly string as_importstring, readonly string as_tipo, readonly long al_i);//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirDataWindow!)
//	wf_importar(ls_temp, "datawindow")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirFunction!)
//	wf_importar(ls_temp, "function")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirMenu!)
//	wf_importar(ls_temp, "menu")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirPipeline!)
//	wf_importar(ls_temp, "pipeline")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirProject!)
//	wf_importar(ls_temp, "project")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirQuery!)
//	wf_importar(ls_temp, "query")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirStructure!)
//	wf_importar(ls_temp, "structure")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirUserObject!)
//	wf_importar(ls_temp, "userobject")
//	ls_temp = LibraryDirectory( ls_pbls[ll_i], DirWindow!)
//	wf_importar(ls_temp, "window")
int li_importadas 
long ll_j

li_importadas = ids_objetos2.importString( as_importstring)
if not li_importadas > 0 then return 1

for ll_j = il_start2 to li_importadas + il_start2 - 1
	ids_objetos2.object.pbl[ll_j] = is_pbls2[al_i]
	ids_objetos2.object.indice[ll_j] = ll_j // para luego saber con qué índice buscar is_código2[] ( sort() posible)
	// v5
	ids_objetos2.object.tipo[ll_j] = as_tipo
	//--
	ids_objetos2.object.idx_lib[ll_j] = al_i
	is_codigo2[ll_j] = wf_export_objeto (is_pbls2[al_i], ids_objetos2.object.objeto[ll_j], as_tipo)
	SetMicroHelp("Exporting object: " + ids_objetos2.object.objeto[ll_j] + ' ...')
next

il_start2 += li_importadas 


return 1

end function

private function libexporttype wf_tipo_objeto (readonly string as_tipo);// recibe string y devuelve LibExportType
LibExportType llet

choose case lower(as_tipo)
	case 'datawindow'
		llet = ExportDatawindow!
	case 'window'
		llet = 	ExportWindow!
	case 'userobject'
		llet = ExportUserObject!
	case 'application'
		llet = ExportApplication!
	case 'function'
		llet = ExportFunction!
	case 'menu'
		llet = ExportMenu!
	case 'pipeline'
		llet = ExportPipeline!
	case 'project'
		// no lo queremos ya que figuran todos los objetos !
		//llet = ExportProject!
		setnull(llet)
	case 'query'
		llet = ExportQuery!
	case 'structure'
		llet = ExportStructure!
	case 'proxy'
		// los de sybase olvidaron este tipo??
		setnull(llet)
	case else
		Messagebox("w_principal.wf_tipo_objeto", "Unknown type: " + as_tipo)
end choose

return llet

end function

on w_principal.create
if this.MenuName = "m_dummy" then this.MenuID = create m_dummy
this.mdi_1=create mdi_1
this.st_1=create st_1
this.cbx_exclude_dw=create cbx_exclude_dw
this.cb_buscar=create cb_buscar
this.cbx_include_dw=create cbx_include_dw
this.cb_borrar_repts=create cb_borrar_repts
this.cb_excel=create cb_excel
this.cb_compare=create cb_compare
this.cb_exportar1=create cb_exportar1
this.sle_objeto=create sle_objeto
this.cbx_exacta=create cbx_exacta
this.cb_printsetup=create cb_printsetup
this.cb_imprimir=create cb_imprimir
this.cb_mostrar_todos=create cb_mostrar_todos
this.cb_repts=create cb_repts
this.cb_exportar2=create cb_exportar2
this.cb_localizar=create cb_localizar
this.sle_objeto2=create sle_objeto2
this.cbx_mayus_minus=create cbx_mayus_minus
this.rte_find=create rte_find
this.dw_obj=create dw_obj
this.gb_busquedas=create gb_busquedas
this.Control[]={this.mdi_1,&
this.st_1,&
this.cbx_exclude_dw,&
this.cb_buscar,&
this.cbx_include_dw,&
this.cb_borrar_repts,&
this.cb_excel,&
this.cb_compare,&
this.cb_exportar1,&
this.sle_objeto,&
this.cbx_exacta,&
this.cb_printsetup,&
this.cb_imprimir,&
this.cb_mostrar_todos,&
this.cb_repts,&
this.cb_exportar2,&
this.cb_localizar,&
this.sle_objeto2,&
this.cbx_mayus_minus,&
this.rte_find,&
this.dw_obj,&
this.gb_busquedas}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_1)
destroy(this.cbx_exclude_dw)
destroy(this.cb_buscar)
destroy(this.cbx_include_dw)
destroy(this.cb_borrar_repts)
destroy(this.cb_excel)
destroy(this.cb_compare)
destroy(this.cb_exportar1)
destroy(this.sle_objeto)
destroy(this.cbx_exacta)
destroy(this.cb_printsetup)
destroy(this.cb_imprimir)
destroy(this.cb_mostrar_todos)
destroy(this.cb_repts)
destroy(this.cb_exportar2)
destroy(this.cb_localizar)
destroy(this.sle_objeto2)
destroy(this.cbx_mayus_minus)
destroy(this.rte_find)
destroy(this.dw_obj)
destroy(this.gb_busquedas)
end on

event open;ids_objetos = create datastore
ids_objetos2 = create datastore

ids_objetos.dataobject = 'ds_objetos'
ids_objetos2.dataobject = ids_objetos.dataobject

end event

event close;destroy ids_objetos
destroy ids_objetos2


end event

event activate;IF ic_modo <> TODOS THEN
	dw_obj.post SetFocus()
END IF

end event

type mdi_1 from mdiclient within w_principal
long BackColor=268435456
end type

type st_1 from statictext within w_principal
integer x = 2734
integer y = 2136
integer width = 146
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "AND"
boolean focusrectangle = false
end type

type cbx_exclude_dw from checkbox within w_principal
integer x = 3287
integer y = 2280
integer width = 558
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exclude dw~'s"
end type

event clicked;string ls_filtro
long ll_pos

if this.checked then
	ls_filtro = dw_obj.object.datawindow.table.filter
	if ls_filtro = '?' then
		ls_filtro = ''
	end if
	if len(ls_filtro) > 0 then
		ls_filtro = "(" + ls_filtro + ")" + " and "
	end if
	ls_filtro += " tipo <> 'DataWindow'"
else
	ll_pos = pos(ls_filtro, "tipo <> 'DataWindow'")
	if ll_pos > 0 then
		ls_filtro = mid(ls_filtro, 1, ll_pos - 2)
	end if
end if
dw_obj.SetFilter(ls_filtro)
dw_obj.Filter()
dw_obj.setsort("idx_lib, tipo, objeto")
dw_obj.sort()

setmicrohelp("Objects shown: " + string(dw_obj.rowcount(), '#,##0'))

end event

type cb_buscar from commandbutton within w_principal
integer x = 46
integer y = 2264
integer width = 581
integer height = 112
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Find Occurrences"
boolean default = true
end type

event clicked;string ls_cadena, ls_cadena2, ls_codigo
long ll_max, ll_i
boolean lb_wholeword, lb_encontrado




ls_cadena = sle_objeto.text
if not Len(ls_cadena) > 0 then
	MessageBox("Information", "You have to specify a search string")
	return
end if

ls_cadena2 = sle_objeto2.text

dw_obj.setredraw(false)
dw_obj.post setredraw(true)
dw_obj.reset()

if cbx_mayus_minus.checked then
	ls_cadena = lower(ls_cadena)
	ls_cadena2 = lower(ls_cadena2)
end if

setpointer(hourglass!)
ll_max = upperBound(is_codigo)
for ll_i = 1 to ll_max
	if cbx_mayus_minus.checked then
		ls_codigo = lower(is_codigo[ll_i])
	else
		ls_codigo = is_codigo[ll_i]
	end if
	if pos( ls_codigo, ls_cadena, 1) > 0 then 
		// ver si quieren palabra exacta o subcadena:
		if cbx_exacta.checked then
			lb_wholeword = true
		else
			lb_wholeword = false
		end if
		
		rte_find.SelectTextAll()
		rte_find.ReplaceText(ls_codigo)
		
		lb_encontrado = false
		if rte_find.find(ls_cadena, true, false, lb_wholeword, false) > 0 then
			// ver si hay que buscar segunda occurrencia
			if Len(ls_cadena2) > 0 and trim(ls_cadena2) <> '' then 
				if pos( ls_codigo, ls_cadena2, 1) > 0 then // encontrado
					// buscar segunda occurrencia
					if rte_find.find(ls_cadena2, true, false, lb_wholeword, false) > 0 then
						// enctonces encontrado
						lb_encontrado = true
					end if
				end if
			else
				// encontrado primera y unica occurrencia buscada
				lb_encontrado = true
			end if
			
			//TODO: habría que ver también como sacar el texto encontrado, el find devuelve sólo cantidad de carácteres encontrado
			if lb_encontrado then
				if ids_objetos.rowscopy(ll_i, ll_i, primary!, dw_obj, dw_obj.rowcount() + 1, primary!) = -1 then
					MessageBox("Error from cb_localizar", "Could not copy the row to dw_obj")
				end if
			end if
		end if
	end if
next
setpointer(arrow!)
setmicrohelp("Found objects: " + string(dw_obj.rowcount(), '#,##0') )


end event

event constructor;this.enabled = false
end event

type cbx_include_dw from checkbox within w_principal
integer x = 3991
integer y = 2280
integer width = 562
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datawindows Only"
end type

event clicked;string ls_filtro
long ll_pos

if this.checked then
	ls_filtro = dw_obj.object.datawindow.table.filter
	if ls_filtro = '?' then
		ls_filtro = ''
	end if
	if len(ls_filtro) > 0 then
		ls_filtro = "(" + ls_filtro + ")" + " and "
	end if
	ls_filtro += " tipo = 'DataWindow'"
else
	ll_pos = pos(ls_filtro, "tipo = 'DataWindow'")
	if ll_pos > 0 then
		ls_filtro = mid(ls_filtro, 1, ll_pos - 2)
	end if
end if
dw_obj.SetFilter(ls_filtro)
dw_obj.Filter()
dw_obj.setsort("idx_lib, tipo, objeto")
dw_obj.sort()

setmicrohelp("Objects shown: " + string(dw_obj.rowcount(), '#,##0'))

end event

type cb_borrar_repts from commandbutton within w_principal
integer x = 18
integer y = 328
integer width = 558
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Delete repeated dws"
end type

event clicked;long ll_filas, ll_i
string ls_obj, ls_tipo, ls_lib //, ls_borrar
int li_ret

dw_obj.setredraw(false)
dw_obj.post setredraw(true)

//dw_obj.setsort("idx_lib A, tipo A, idx_lib A")
//dw_obj.sort()

dw_obj.setsort("objeto A, tipo A, idx_lib A")
dw_obj.sort()

// ésto sería el filtro de repetidos reales: dw_obj.setfilter("(objeto = objeto[-1] and tipo = tipo[-1]) or (objeto = objeto[1] and tipo = tipo[1])")
// pero, usamos un filtro que muestre repetidos por nombre sin tener en cuenta el tipo, hay versiones en que da problemas...
ll_filas = dw_obj.rowcount()
ll_i = 0


DO WHILE ll_i < ll_filas
	ll_i ++
	ls_tipo = dw_obj.object.Tipo[ll_i]
	IF ls_tipo <> 'DataWindow' THEN
		CONTINUE
	END IF
	ls_obj = dw_obj.object.Objeto[ll_i]
	ls_lib = dw_obj.object.Pbl[ll_i]
	if ls_obj = 'd_crn4edif' then
		ls_obj = ls_obj
	end if
	DO WHILE ll_i < ll_filas AND ls_obj = dw_obj.object.Objeto[ll_i + 1] AND ls_tipo = dw_obj.object.Tipo[ll_i +1]
//		ls_borrar = dw_obj.object.Pbl[ll_i + 1]
		li_ret = libraryDelete( dw_obj.object.Pbl[ll_i + 1], ls_obj, ImportDataWindow!)
		if li_ret = -1 then
			messagebox('Error', 'Could not delete the dw')
			return 
		end if
		ll_filas --
		dw_obj.DeleteRow(ll_i + 1)
	LOOP
	
LOOP		

setmicrohelp("Remaining repeated objects (estimated): " + string(dw_obj.rowcount() / 2, '#,##0') )
halt close
end event

event constructor;this.enabled = false
end event

type cb_excel from commandbutton within w_principal
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 18
integer y = 1648
integer width = 558
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "E&xcel"
end type

event clicked;//dw_obj.SaveAs(".\objetos.xls", excel!, true )
dw_obj.SaveAs("", xlsx!, true )





end event

type cb_compare from commandbutton within w_principal
event clicked pbm_bnclicked
integer x = 18
integer y = 792
integer width = 558
integer height = 112
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "&Compare I y II"
end type

event clicked;long ll_max1, ll_max2, ll_resto, ll_i, ll_fila
string ls_buscar

ll_max1 = il_start - 1 // la última pasado por el for lo ha incrementado con 1. 
ll_max2 = il_start2 - 1


// primero comparar ids_objetos1 con ..2 
for ll_i = 1 to ll_max1
	// buscar el objeto en ids_objetos2 si es que hay
	ls_buscar = "objeto = '" + ids_objetos.object.objeto[ll_i] + "' " + &
/*					" and pbl = '" + ids_objetos.object.pbl[ll_i] + "' " + excluir ya que path distinto */ &
					" and tipo = '" + ids_objetos.object.tipo[ll_i] + "'"
					 
	ll_fila = ids_objetos2.find(ls_buscar, 1, 9999999)
	if ll_fila = 0 then // no está en libs II, o no está en la misma pbl
		ids_objetos.object.estado[ll_i] = NO_EXISTE_DESTINO
	else
		// comparar los codigos de los dos objetos y marcar el estado
		if is_codigo[ll_i] = is_codigo2[ll_fila] then
			// iguales 
			ids_objetos.object.estado[ll_i] = IGUALES
			ids_objetos2.object.estado[ll_fila] = IGUALES
		else
			ids_objetos.object.estado[ll_i] = CAMBIADOS
			ids_objetos2.object.estado[ll_fila] = CAMBIADOS
		end if
	end if
next

// luego: los ids_objetos2 que no tengan ningún estado asignado todavía
// 		 deben de tratarse de objetos que no están en ids_objetos

ids_objetos2.setfilter("isnull(estado)")
ids_objetos2.filter()
ll_resto = ids_objetos2.rowcount()

// evitar que se reordene el dw. (los hasta ahora presentes provienen de la exportación libs I.
ids_objetos.setsort('')

dw_obj.setsort('') // por si acaso la asignación de object.data no lo cambie
dw_obj.object.data = ids_objetos.object.data

// copiar las de la exportación libs. II hacia la ds de I. para poder visualizarlas todas en el mismo dw.
ids_objetos2.rowscopy(1, ll_resto, primary!, dw_obj, il_start, primary!)

// después sólo mostrar los que no sean iguales
dw_obj.setfilter("estado <> '" + IGUALES + "'")
dw_obj.filter()

// quitar el filtro para tener todos disponibles
ids_objetos2.setfilter('')
ids_objetos2.filter()

end event

event constructor;this.enabled = false
end event

type cb_exportar1 from commandbutton within w_principal
event clicked pbm_bnclicked
integer x = 18
integer y = 32
integer width = 558
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Exp. Libs. I"
end type

event clicked;string ls_filename, ls_fullname, ls_temp
string ls_objetos[]
int   li_fileid, li_importadas
long ll_i, ll_max, ll_j

// versión 10
//if GetFileOpenName ("Open", ls_fullname, ls_filename, "txt", "Text Files (*.txt),*.txt", "d:\Miguel\geu\src", 512) < 1 then 
if GetFileOpenName ("Open", ls_fullname, ls_filename, "txt", "Text Files (*.txt),*.txt", "", 512) < 1 then 
// --10
// versión 5

//if GetFileOpenName ("Open", ls_fullname, ls_filename, "txt", "Text Files (*.txt),*.txt" ) < 1 then 
// --5
	return
end if

li_fileid = FileOpen (ls_fullname, LineMode!)
if not li_fileid > 0 then
	MessageBox("Problem at opening file", "Could not open this file:  '" + ls_fullname + "'")
	return
end if

ic_modo = TODOS

ids_objetos.reset()
ids_objetos.setsort("")
ids_objetos.sort() // evitar que se reordenen las filas mientras que importamos, deben estar primero los objetos de las primeras librerías hasta que este relleno idx_lib
dw_obj.setsort("")
dw_obj.sort()

// lectura de nombres libs/pbls

ll_i = 1
do while 	FileRead (li_fileid, ls_temp) > -1 // devuelve un 0 en caso de un intro
	ls_temp = trim(ls_temp)
	if Right(ls_temp, 1 ) = ';' then
		ls_temp = Mid(ls_temp, 1, Len(ls_temp) - 1)
	end if
	if not Len(ls_temp) > 0 then continue
	is_pbls[ll_i] = ls_temp

	ll_i ++ 
loop

FileClose (li_fileid)

// cada nombre de objeto pbls a datastore
ll_max = ll_i - 1
il_start = 1
setpointer(hourglass!)

for ll_i = 1 to ll_max
	// versión 10
	ls_temp = LibraryDirectoryEx( is_pbls[ll_i], DirAll!)
	//--10
	
//	//--- versión 5
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirApplication!)
//	wf_importar_v5(ls_temp, "application", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirDataWindow!)
//	wf_importar_v5(ls_temp, "datawindow", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirFunction!)
//	wf_importar_v5(ls_temp, "function", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirMenu!)
//	wf_importar_v5(ls_temp, "menu", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirPipeline!)
//	wf_importar_v5(ls_temp, "pipeline", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirProject!)
//	wf_importar_v5(ls_temp, "project", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirQuery!)
//	wf_importar_v5(ls_temp, "query", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirStructure!)
//	wf_importar_v5(ls_temp, "structure", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirUserObject!)
//	wf_importar_v5(ls_temp, "userobject", ll_i)
//	ls_temp = LibraryDirectory( is_pbls[ll_i], DirWindow!)
//	wf_importar_v5(ls_temp, "window", ll_i)

////--5

// versión 10
	li_importadas = ids_objetos.importString( ls_temp)
	if not li_importadas > 0 then continue
	for ll_j = il_start to li_importadas + il_start -1
		ids_objetos.object.pbl[ll_j] = is_pbls[ll_i]
		ids_objetos.object.idx_lib[ll_j] = ll_i
		ids_objetos.object.indice[ll_j] = ll_j // por si dan a ordenar en etiquetas, seguimos pudiendo encontrar el objeto correspondiente
		is_codigo[ll_j] = wf_export_objeto (is_pbls[ll_i], ids_objetos.object.objeto[ll_j], ids_objetos.object.tipo[ll_j])
		SetMicroHelp("Exporting object: " + ids_objetos.object.objeto[ll_j] + ' ...')
	next


	il_start += li_importadas 

//--10

next

// fines de depuración: ids_objetos.saveas("objetos.xls", excel!, true)
if ids_objetos.rowcount() = 0 then
	messagebox('Error', 'No librery has objects, check your txt file with the library list')
	return 0
end if

dw_obj.object.data = ids_objetos.object.data
Setpointer(arrow!)
setmicrohelp("Export finished: " + string(upperbound(is_codigo), '#,##0') + " exported objects.")

// habilitar
cb_exportar2.enabled = true
cb_buscar.enabled = true
cb_imprimir.enabled = true
cb_localizar.enabled = true
cb_mostrar_todos.enabled = true
cb_printsetup.enabled = true
cb_repts.enabled = true
sle_objeto.setfocus()

end event

type sle_objeto from singlelineedit within w_principal
integer x = 709
integer y = 2112
integer width = 1993
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_exacta from checkbox within w_principal
integer x = 2053
integer y = 2280
integer width = 841
integer height = 80
integer taborder = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Exact Occurrences (words)"
end type

type cb_printsetup from commandbutton within w_principal
event clicked pbm_bnclicked
integer x = 18
integer y = 1500
integer width = 558
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&PrintSetup"
end type

event clicked;PrintSetup()





end event

event constructor;this.enabled = false
end event

type cb_imprimir from commandbutton within w_principal
event clicked pbm_bnclicked
integer x = 18
integer y = 1352
integer width = 558
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Print"
end type

event clicked;setpointer(hourglass!)
dw_obj.print()



end event

event constructor;this.enabled = false
end event

type cb_mostrar_todos from commandbutton within w_principal
integer x = 18
integer y = 476
integer width = 558
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Show all"
end type

event clicked;ic_modo = TODOS
dw_obj.setredraw(false)

dw_obj.post setredraw(true)

dw_obj.reset()

dw_obj.object.data = ids_objetos.object.data

dw_obj.setfilter("")
dw_obj.filter()

dw_obj.setsort("idx_lib, tipo, objeto")
dw_obj.sort()

setmicrohelp("Showing all rows: " + string(dw_obj.rowcount(), '#,##0'))



end event

event constructor;this.enabled = false
end event

type cb_repts from commandbutton within w_principal
integer x = 18
integer y = 180
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Show Repeated"
end type

event clicked;ic_modo = REPETIDOS

dw_obj.setredraw(false)
dw_obj.post setredraw(true)

dw_obj.reset()
dw_obj.object.data = ids_objetos.object.data

dw_obj.setsort("objeto A, tipo A, idx_lib A")
dw_obj.sort()

// ésto sería el filtro de repetidos reales: dw_obj.setfilter("(objeto = objeto[-1] and tipo = tipo[-1]) or (objeto = objeto[1] and tipo = tipo[1])")
// pero, usamos un filtro que muestre repetidos por nombre sin tener en cuenta el tipo, hay versiones en que da problemas...
dw_obj.setfilter("(objeto = objeto[-1]) or (objeto = objeto[1])")
dw_obj.filter()
IF dw_obj.rowcount() > 0 then
	cb_borrar_repts.enabled = true
end if

setmicrohelp("Showing repeated objects: " + string(dw_obj.rowcount(), '#,##0'))

end event

event constructor;this.enabled = false
end event

type cb_exportar2 from commandbutton within w_principal
integer x = 18
integer y = 644
integer width = 558
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "E&xp. Libs. II"
end type

event clicked;string ls_filename, ls_fullname, ls_temp
string ls_objetos[]
int   li_fileid
long ll_importadas
long ll_i, ll_max, ll_j

// versión 10
if GetFileOpenName ("Open", ls_fullname, ls_filename, "txt", "Text Files (*.txt),*.txt", "", 512) < 1 then
// --10
// versión 5
//if GetFileOpenName ("Open", ls_fullname, ls_filename, "txt", "Text Files (*.txt),*.txt" ) < 1 then 
// --5
	return
end if

li_fileid = FileOpen (ls_fullname, LineMode!)
if not li_fileid > 0 then
	MessageBox("Problem opening File", "Could not open this file:  '" + ls_fullname + "'")
	return
end if

ic_modo = COMPARACION

ids_objetos2.reset()
ids_objetos2.setsort("")
ids_objetos2.sort()

// lectura de nombres libs/pbls

ll_i = 1
do while 	FileRead (li_fileid, ls_temp) > -1 // devuelve un 0 en caso de un intro
	ls_temp = trim(ls_temp)
	if Right(ls_temp, 1 ) = ';' then
		ls_temp = Mid(ls_temp, 1, Len(ls_temp) - 1)
	end if
	if not Len(ls_temp) > 0 then continue
	is_pbls2[ll_i] = ls_temp
	ll_i ++ 
loop

FileClose (li_fileid)

// cada nombre de objeto pbls a datastore
ll_max = ll_i - 1
il_start2 = 1
setpointer(hourglass!)

for ll_i = 1 to ll_max
	// versión 10
	ls_temp = LibraryDirectoryEx( is_pbls2[ll_i], DirAll!)
	//--10
	
//	//--- versión 5
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirApplication!)
//	wf_importar_v5_2(ls_temp, "application", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirDataWindow!)
//	wf_importar_v5_2(ls_temp, "datawindow", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirFunction!)
//	wf_importar_v5_2(ls_temp, "function", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirMenu!)
//	wf_importar_v5_2(ls_temp, "menu", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirPipeline!)
//	wf_importar_v5_2(ls_temp, "pipeline", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirProject!)
//	wf_importar_v5_2(ls_temp, "project", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirQuery!)
//	wf_importar_v5_2(ls_temp, "query", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirStructure!)
//	wf_importar_v5_2(ls_temp, "structure", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirUserObject!)
//	wf_importar_v5_2(ls_temp, "userobject", ll_i)
//	ls_temp = LibraryDirectory( is_pbls2[ll_i], DirWindow!)
//	wf_importar_v5_2(ls_temp, "window", ll_i)

////--5

// versión 10
	ll_importadas = ids_objetos2.importString( ls_temp)
	if not ll_importadas > 0 then continue
	for ll_j = il_start2 to ll_importadas + il_start2 - 1
		ids_objetos2.object.pbl[ll_j] = is_pbls2[ll_i]
		ids_objetos2.object.indice[ll_j] = ll_j // por si dan a ordenar en etiquetas, seguimos pudiendo encontrar el objeto correspondiente
		is_codigo2[ll_j] = wf_export_objeto (is_pbls2[ll_i], ids_objetos2.object.objeto[ll_j], ids_objetos2.object.tipo[ll_j])
		SetMicroHelp("Exporting object: " + ids_objetos2.object.objeto[ll_j] + ' ...')
	next

	il_start2 += ll_importadas 
//--10

next

if ids_objetos2.rowcount() = 0 then
	messagebox('Error', 'No library has objects. Check your txt file with the list of libraries.')
	return 0
end if

// fines de depuración: ids_objetos2.saveas("objetos.xls", excel!, true)

// asegurarnos el orden adecuado / por lo menos lo mismo en los dos ds's
cb_mostrar_todos.event clicked()

Setpointer(arrow!)
setmicrohelp("Export finished. " + string(upperbound(is_codigo2), "#,##0") + " exported objects.")

// habilitar
cb_compare.enabled = true
cb_compare.event clicked()


end event

event constructor;This.Enabled = false

end event

type cb_localizar from commandbutton within w_principal
integer x = 46
integer y = 2108
integer width = 581
integer height = 112
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Find Object"
end type

event clicked;string ls_cadena, ls_codigo
long ll_max, ll_i


ls_cadena = sle_objeto.text
if not Len(ls_cadena) > 0 then
	MessageBox("Information", "You have to specify a search string")
	return
end if

dw_obj.setredraw(false)
dw_obj.post setredraw(true)

// primero mostrar todos los objetos en el dw
if upperbound(is_codigo) > dw_obj.rowcount() then // se aplicó algún filtro que ahora no queremos
	cb_mostrar_todos.event clicked()
end if

if cbx_mayus_minus.checked then
	ls_cadena = lower(ls_cadena)
end if

setpointer(hourglass!)
dw_obj.setfilter("objeto like '" + ls_cadena + "'")
dw_obj.filter()
setmicrohelp("Localized objects: " + string(dw_obj.rowcount(), '#,##0') )
setpointer(arrow!)


end event

event constructor;this.enabled = false
end event

type sle_objeto2 from singlelineedit within w_principal
integer x = 2907
integer y = 2112
integer width = 1993
integer height = 112
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_mayus_minus from checkbox within w_principal
integer x = 704
integer y = 2280
integer width = 1312
integer height = 80
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ignore Upper/Lowercase"
boolean checked = true
end type

type rte_find from richtextedit within w_principal
integer x = 64
integer y = 944
integer width = 1033
integer height = 800
integer taborder = 110
long init_backcolor = 16776960
long init_inputfieldbackcolor = 16777215
end type

on rte_find.create
BackColor=16776960
InputFieldBackColor=16777215
end on

event constructor;this.visible = false

end event

type dw_obj from datawindow within w_principal
integer x = 581
integer y = 8
integer width = 5248
integer height = 1976
integer taborder = 190
boolean bringtotop = true
string dataobject = "ds_objetos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;long ll_fila1, ll_fila2, ll_ind1, ll_ind2
integer li_FileNum, li_filenum2
string ls_pbl, ls_objeto, ls_tipo, ls_buscar, ls_run, ls_codigo1, ls_codigo2
	
if ids_objetos2.rowcount() = 0 then
	MessageBox('Information', "Before being able to compare objects, you'll have to export the second library list (~"Exp. Libs. II~" button)", information!)
	return
end if

if row < 1 then return

// primero ver si se trata de una nueva o borrada, sino: comparar
if dw_obj.object.estado[row] = NO_EXISTE_ORIGEN then // entonces ha sido copiado de la ids_objetos2 por no estar presente en ids_objetos
	MessageBox("Information", "This Object does not exist in library list I.")
	return
elseif dw_obj.object.estado[row] = NO_EXISTE_DESTINO then
	MessageBox("Information", "This Object does not exist in library list II.")
	return
end if

// seguimos con los con estado CAMBIADOS

ls_objeto = dw_obj.object.objeto[row]
ls_tipo = dw_obj.object.tipo[row]

// no incluir la pbl ya que siempre será otro path y además no importa donde esté el objeto a comparar ..?!
ls_buscar = "objeto = '" + ls_objeto + "' " + &
				" and tipo = '" + ls_tipo + "'"

// buscar el indice que corresponde al objeto en ids_objetos1				 
ll_fila1 = ids_objetos.find(ls_buscar, 1, 9999999)
if ll_fila1 = 0 then // no está en libs I, o no está en la misma pbl
	// debería de estar
	messagebox('debug', 'should never happen: 1')
	return 
end if

ll_fila2 = ids_objetos2.find(ls_buscar, 1, 9999999)
if ll_fila2 = 0 then // no está en libs II, o no está en la misma pbl
	// debería de estar
	messagebox('debug', 'should never happen: 2')
	return 
end if

// ya sabemos donde se encuentra el objeto
// debe ser el mismo objeto si hemos llegado hasta aquí
ll_ind1 = ids_objetos.object.indice[ll_fila1]
ll_ind2 = ids_objetos2.object.indice[ll_fila2]

ls_codigo1 = is_codigo[ll_ind1]
ls_codigo2 = is_codigo2[ll_ind2]

li_FileNum  = FileOpen(gs_app_path + "\temp1.txt", StreamMode!, Write!, LockWrite!, Replace!)


long 		flen, 	bytes_read
int 		loops, 	i
string 	ls_trozo

flen = Len(ls_codigo1)

// Determine how many times to call FileRead 
IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN
		loops = flen/32765
	ELSE
		loops = (flen/32765) + 1
	END IF
ELSE
	loops = 1
END IF

//  escribir 
FOR i = 1 to loops
	ls_trozo = Mid(ls_codigo1, ((i - 1) * 32765) + 1, 32765)
	FileWrite( li_FileNum, ls_trozo)
NEXT
FileClose(li_FileNum)


li_fileNum2 = FileOpen(gs_app_path + "\temp2.txt", StreamMode!, Write!, LockWrite!, Replace!)
// Determine how many times to call FileRead 
flen = Len(ls_codigo2)
IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN
		loops = flen/32765
	ELSE
		loops = (flen/32765) + 1
	END IF
ELSE
	loops = 1
END IF

//  escribir 
FOR i = 1 to loops
	ls_trozo = Mid(ls_codigo2, ((i - 1) * 32765) + 1, 32765)
	FileWrite( li_FileNum2, ls_trozo)
NEXT
FileClose(li_FileNum2)

// Araxis Merge:
//ls_run = '"' + gs_app_path + '\compare.exe" ' + '"' + gs_app_path + '\temp1.txt" ' + '"' + gs_app_path + '\temp2.txt"' 		// araxis merge
// Kdiff3:
//ls_run = '"' + gs_app_path + '\kdiff3.exe" ' + '"' + gs_app_path + '\temp1.txt" ' + '"' + gs_app_path + '\temp2.txt" -m' 	// kDiff3
// WinMerge:
ls_run = '"D:\Program Files (x86)\WinMerge\winmergeu.exe" ' + '"' + gs_app_path + '\temp1.txt" ' + '"' + gs_app_path + '\temp2.txt" /e' // /e to be able to use ESC key
run( ls_run )

end event

event constructor;this.setposition(topmost!)

end event

type gb_busquedas from groupbox within w_principal
integer x = 23
integer y = 2000
integer width = 5787
integer height = 416
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Search"
end type

