//******************************************************************
// 
//  Generated by RoboCompDSL
//  
[[[cog

import sys
sys.path.append('/opt/robocomp/python')

import cog
def A():
	cog.out('<@@<')
def Z():
	cog.out('>@@>')
def TAB():
	cog.out('<TABHERE>')
def SPACE(i=0):
	s = ''
	if i>0:
		s = str(i)
	cog.out('<S'+s+'>')
cog.outl("//  File name: "+theIDSL.split('.')[0]+".ice")
cog.outl("//  Source: "+theIDSL)
]]]
[[[end]]]
//  
//****************************************************************** 
[[[cog
from parseIDSL import *
idsl = IDSLParsing.fromFileIDSL(theIDSL)
cog.outl("#ifndef "+idsl['module']['name'].upper()+"_ICE")
cog.outl("#define "+idsl['module']['name'].upper()+"_ICE")
if 'imports' in idsl.keys():
	for imp in idsl['imports']:
		cog.outl("#include <"+imp.split('.')[0]+".ice>")
cog.outl("module "+idsl['module']['name']+"\n{")
for content in idsl['module']['contents']:
	if content['type'] == 'exception':
		cog.outl("<TABHERE>exception "+content['name']+"{"+content['content']+"};")
	if content['type'] == 'sequence':
		cog.outl("<TABHERE>sequence <"+content['typeSequence']+"> "+content['name']+";")
	if content['type'] == 'dictionary':
		cog.outl("<TABHERE>dictionary <"+content['content']+"> "+content['name']+";")
	if content['type'] == 'enum':
		cog.outl("<TABHERE>enum "+content['name']+" { "+content['content']+" };")
	if content['type'] == 'struct':
		cog.outl("<TABHERE>struct "+content['name']+"\n<TABHERE>{")
		for var in content['structIdentifiers']:
			cog.out("<TABHERE><TABHERE> "+var['type']+" "+var['identifier'])
			try:
				cog.outl(" =" + var['defaultValue'] + ";")
			except:
				cog.outl(";")
		cog.outl("<TABHERE>};")
	if content['type'] == 'interface':
		cog.outl("<TABHERE>interface "+content['name']+"\n<TABHERE>{")
		for method in content['methods']:
			try:
				cog.out("<TABHERE><TABHERE>"+method['decorator']+" "+method['ret']+" ")
				
			except:
				cog.out("<TABHERE><TABHERE>"+method['ret']+" ")
			cog.out(method['name']+" (")
			try:
				paramStrA = ''
				for p in method['params']:
					# delim
					if paramStrA == '': delim = ''
					else: delim = ', '
					# STR
					try:
						paramStrA += delim + p['decorator'] + ' ' + p['type'] + ' ' + p['name']
					except:
						paramStrA += delim + p['type'] + ' ' + p['name']
				cog.out(paramStrA + ")")
			except:
				cog.out(")")
			try:
				if len(method['raise']) > 0:
					cog.out(" throws ")
					for p in method['raise']:
						# STR
						cog.out(p)
			except:
				pass
			cog.outl(";")
		cog.outl("<TABHERE>};")
]]]
[[[end]]]
};

#endif
