$PBExportHeader$objetosv11.sra
$PBExportComments$Generated Application Object
forward
global type objetosv11 from application
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

global type objetosv11 from application
string appname = "objetosv11"
string themepath = "D:\pb2021\PowerBuilder 21.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 3
long richtexteditx64type = 3
long richtexteditversion = 2
string richtexteditkey = ""
string appicon = "objetospb10_64.ico"
string appruntimeversion = "21.0.0.1506"
boolean manualsession = false
boolean unsupportedapierror = false
end type
global objetosv11 objetosv11

on objetosv11.create
appname="objetosv11"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on objetosv11.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gs_app_path = getCurrentDirectory()
open(w_principal)
end event

