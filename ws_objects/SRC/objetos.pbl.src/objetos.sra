$PBExportHeader$objetos.sra
$PBExportComments$Generated Application Object
forward
global type objetos from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_app_path
end variables

global type objetos from application
string appname = "objetos"
string themepath = "D:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 3
long richtexteditx64type = 3
long richtexteditversion = 2
string richtexteditkey = ""
string appicon = "objetospb10_64.ico"
string appruntimeversion = "19.2.0.2728"
end type
global objetos objetos

on objetos.create
appname="objetos"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on objetos.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_app_path = getCurrentDirectory()
open(w_principal)
end event

