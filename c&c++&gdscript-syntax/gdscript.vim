" Vim syntax file for Godot gdscript
" Language:     gdscript
" Maintainer:   Ghashy
" Filenames:    *.gd

if exists("b:current_syntax")
    finish
endif

syntax sync maxlines=100

syn keyword gdscriptConditional if else elif match
syn keyword gdscriptRepeat for while break continue

syn keyword gdscriptOperator ->

if get(g:, "godot_ext_hl", v:true)
    syn match gdscriptClass "\v<\u\w+>"
    syn match gdscriptConstant "\<[_A-Z]\+[0-9_A-Z]*\>"
    syn match gdscriptOperator "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>\|:\|."
    syn match gdscriptDelimiter "\V(\|)\|[\|]\|{\|}"
    syn match gdscriptBlockStart ":\s*$"
endif

syn keyword gdscriptKeyword null self owner parent tool is as not and or in
syn keyword gdscriptBoolean false true

syn keyword gdscriptStatement remote master puppet remotesync mastersync puppetsync sync
syn keyword gdscriptStatement return pass
syn keyword gdscriptStatement static const enum
syn keyword gdscriptStatement breakpoint assert
syn keyword gdscriptStatement onready
syn keyword gdscriptStatement class_name extends

syn keyword gdscriptType void bool int float String containedin=gdscriptTypeDecl,gdscriptExportTypeDecl,gdscriptFunctionParams,gdscriptFunctionCall
syn match gdscriptType "->\s*\h\w*" contains=gdscriptOperator skipwhite
syn keyword gdscriptStatement var nextgroup=gdscriptTypeDecl skipwhite
syn keyword gdscriptStatement const nextgroup=gdscriptTypeDecl skipwhite
syn match gdscriptTypeDecl "\h\w*\s*:\s*\h\w*" contains=gdscriptOperator,gdscriptType,gdscriptClass contained skipwhite
syn match gdscriptTypeDecl "\h\w*\s" contains=gdscriptOperator,gdscriptType,gdscriptClass contained skipwhite
syn match gdscriptTypeDecl "->\s*\h\w*" contains=gdscriptOperator,gdscriptType,gdscriptClass contained skipwhite
syn match gdscriptTypeDecl "\<[_A-Z]\+[0-9_A-Z]*\>" contained
syn match gdscriptTypeDecl "\<[_A-a]\+[0-9_A-z]*\>" contained

syn keyword gdscriptStatement export nextgroup=gdscriptExportTypeDecl skipwhite
syn match gdscriptExportTypeDecl "(.\{-}[,)]" contains=gdscriptOperator,gdscriptType,gdscriptClass,gdscriptDelimiter contained skipwhite

syn keyword gdscriptStatement setget nextgroup=gdscriptSetGet,gdscriptSetGetSeparator skipwhite
syn match gdscriptSetGet "\h\w*" nextgroup=gdscriptSetGetSeparator display contained skipwhite
syn match gdscriptSetGetSeparator "," nextgroup=gdscriptSetGet display contained skipwhite

syn keyword gdscriptStatement class func signal nextgroup=gdscriptFunctionName skipwhite
syn match gdscriptFunctionName "\h\w*" nextgroup=gdscriptFunctionParams display contained skipwhite
syn match gdscriptFunctionParams "(.*)" contains=gdscriptDelimiter,gdscriptTypeDecl,gdscriptType,gdscriptOperator display contained skipwhite

if get(g:, "godot_ext_hl", v:true)
    syn match gdscriptFunctionCall "\v(\.)<\w*>\s*(\()@=" contains=gdscriptLibrary,gdscriptOperator
    syn match gdscriptFunctionCall "\v<\w*>\s*(\()@=" contains=gdscriptLibrary,gdscriptType
    " Dot-properies
    syn match gdscriptPropertyCall '\v(\.)@<=[a-z][A-Za-z0-_]*' contains=gdscriptBlockStart
endif

syn match gdscriptNode "\$\h\w*\%(/\h\w*\)*"

syn match gdscriptComment "#.*$" contains=@Spell,gdscriptTodo

syn region gdscriptString matchgroup=gdscriptQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=gdscriptEscape,@Spell

syn region gdscriptString matchgroup=gdscriptTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=gdscriptEscape,@Spell

syn match gdscriptEscape +\\[abfnrtv'"\\]+ contained
syn match gdscriptEscape "\\$"

" Numbers
syn match gdscriptNumber "\<0x\%(_\=\x\)\+\>"
syn match gdscriptNumber "\<0b\%(_\=[01]\)\+\>"
syn match gdscriptNumber "\<\d\%(_\=\d\)*\>"
syn match gdscriptNumber "\<\d\%(_\=\d\)*\%(e[+-]\=\d\%(_\=\d\)*\)\=\>"
syn match gdscriptNumber "\<\d\%(_\=\d\)*\.\%(e[+-]\=\d\%(_\=\d\)*\)\=\%(\W\|$\)\@="
syn match gdscriptNumber "\%(^\|\W\)\@1<=\%(\d\%(_\=\d\)*\)\=\.\d\%(_\=\d\)*\%(e[+-]\=\d\%(_\=\d\)*\)\=\>"

" XXX, TODO, etc
syn keyword gdscriptTodo TODO XXX FIXME HACK NOTE BUG contained

let s:standardLibraryTypes = ["AABB", "AnimationPlayer", "Array", "Basis", "Color", "Dictionary", "NodePath", "Object", "Plane", "PoolByteArray", "PoolIntArray", "PoolRealArray", "PoolStringArray", "PoolVector2Array", "PoolVector3Array", "PoolColorArray", "Quat", "Rect2", "RID", "Transform", "Transform2D", "Vector2", "Vector3", "ConnectFlags", "DuplicateFlags", "GenEditState", "CursorShape", "MouseMode", "MovingPlatformApplyVelocityOnLeave", "AnimationMethodCallMode", "AnimationProcessMode", "Input", "InputEvent", "InputEventAction", "InputEventJoypadButton", "InputEventJoypadMotion", "InputEventMIDI", "InputEventScreenDrag", "InputEventScreenTouch", "InputEventWithModifiers", "InputEventGesture", "InputEventMagnifyGesture", "InputEventPanGesture", "InputEventKey", "InputEventMouse", "InputEventMouseButton", "InputEventMouseMotion", "ConfigFile", "Error", "File", "CompressionMode", "ModeFlags", "KinematicBody", "KinematicBody2D", "Directory", "Resource", "MainLoop", "SceneTree", "CanvasLayer", "Viewport", "ClearMode", "DebugDraw", "MSAA", "RenderInfo", "ShadowAtlasQuadrantSubdiv", "UpdateMode", "Usage"]

for s:standardLibraryType in s:standardLibraryTypes
    execute 'syntax keyword gdscriptType ' . s:standardLibraryType
endfor

" Added @GDScript and GDScript methods&constants
let s:stantardGDScriptMembers = ["Color8", "ColorN", "abs", "acos", "asin", "assert", "atan", "atan2", "bytes2var", "cartesian2polar", "ceil", "char", "clamp", "convert", "cos", "cosh", "db2linear", "decimals", "dectime", "deep_equal", "deg2grad", "dict2inst", "ease", "exp", "floor", "fmod", "fposmod", "funcref", "get_stack", "hash", "inst2dict", "instance_from_id", "inverse_lerp", "is_equal_approx", "is_inf", "is_instance_valid", "is_nan", "is_zero_approx", "len", "lerp", "lerp_angle", "linear2db", "load", "log", "max", "min", "move_toward", "nearest_po2", "ord", "parse_json", "polar2cartesian", "posmod", "pow", "preload", "print", "print_debug", "print_stack", "printerr", "printraw", "prints", "printt", "push_error", "push_warning", "rad2deg", "rand_range", "rand_seed", "randf", "randi", "randomize", "range", "range_lerp", "round", "seed", "sign", "sin", "sinh", "smoothstep", "sqrt", "step_decimals", "stepify", "str", "str2var", "tan", "tanh", "to_json", "type_exists", "typeof", "validate_json", "var2bytes", "var2str", "weakref", "wrapf", "wrapi", "yield", "PI", "TAU", "INF", "NAN", "new", "get_as_bytecode", "get_id"]

for s:stantardGDScriptMember in s:stantardGDScriptMembers
    execute 'syntax keyword gdscriptLibrary ' . s:stantardGDScriptMember
endfor

" Added Object methods&signals&enumerations&constants
let s:stantardObjectMembers = ["_get", "_get_property_list", "_init", "_notification", "_set", "_to_string", "add_user_signal", "call", "call_deferred", "callv", "can_translate_messages", "connect", "disconnect", "emit_signal", "free", "get", "get_class", "get_incoming_connections", "get_indexed", "get_instance_id", "get_meta", "get_meta_list", "get_method_list", "get_property_list", "get_script", "get_signal_connection_list", "get_signal_list", "has_meta", "has_method", "has_signal", "has_user_signal", "is_blocking_signals", "is_class", "is_connected", "is_queued_for_deletion", "notification", "property_list_changed_notify", "remove_meta", "set", "set_block_signals", "set_deferred", "set_indexed", "set_message_translation", "set_meta", "set_script", "to_string", "tr", "script_changed", "CONNECT_DEFERRED", "CONNECT_PERSIST", "CONNECT_ONESHOT", "CONNECT_REFERENCE_COUNTED", "NOTIFICATION_POSTINITIALIZE", "NOTIFICATION_PREDELETE"]

for s:stantardObjectMember in s:stantardObjectMembers
    execute 'syntax keyword gdscriptLibrary ' . s:stantardObjectMember
endfor

hi def link gdscriptStatement Statement
hi def link gdscriptKeyword Keyword
hi def link gdscriptConditional Conditional
hi def link gdscriptBoolean Boolean
hi def link gdscriptOperator Operator
hi def link gdscriptRepeat Repeat
hi def link gdscriptSetGet Function
hi def link gdscriptFunctionName Function
hi def link gdscriptTypeDecl Identifier
hi def link gdscriptExportTypeDecl Identifier
hi def link gdscriptSetGetSeparator Normal
hi def link gdscriptLibrary Operator
if get(g:, "godot_ext_hl", v:true)
    hi def link gdscriptClass Type
    hi def link gdscriptFunctionCall Function
    hi def link gdscriptPropertyCall Identifier
    hi def link gdscriptDelimiter Delimiter
    hi def link gdscriptConstant Constant
endif
hi def link gdscriptBuiltinStruct Typedef
hi def link gdscriptComment Comment
hi def link gdscriptString String
hi def link gdscriptQuotes String
hi def link gdscriptTripleQuotes String
hi def link gdscriptEscape Special
hi def link gdscriptNode Label
hi def link gdscriptType Type
hi def link gdscriptNumber Number
hi def link gdscriptBlockStart Operator
hi def link gdscriptTodo Todo


let b:current_syntax = "gdscript"
