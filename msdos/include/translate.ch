#ifndef _TRANSLATE_CH_
#define _TRANSLATE_CH_
//#DEFINE MSDOS               OK    // Ambiente MSDOS
#DEFINE MSWINDOWS           OK    // Ambiente MSWINDOWS

//#xtranslate str(<xValue>)  							=> iif(hb_isNumeric(<xValue>), hb_nToc(<xValue>), <xValue>)
//#xtranslate trim(<xValue>)  						=> ltrim(rtrim(iif(hb_isNumeric(<xValue>), hb_nToc(<xValue>), <xValue>)))
#xtranslate alltrim(<xValue>)  						=> ltrim(rtrim(<xValue>))
#translate ifNIL( <var>, <val> )        			=> if( <var> = NIL, <var> := <val>, <var> )
#translate MS_DEFAULT( <var>, <val> )    			=> if( <var> = NIL, <var> := <val>, <var> )
#translate MS_NIL( <var>, <val> )    				=> if( <var> = NIL, <var> := <val>, <var> )
#translate TrimStr(<xValue>)      					=> alltrim(<xValue>)
#translate StrTrim(<xValue>)      					=> alltrim(<xValue>)
#translate xAllTrim(<xValue>)                	=> alltrim(<xValue>)
#translate TrimStrZero(<xValue>, <nzeros>)   	=> alltrim(strzero(<xValue>, <nzeros>))
#translate AllTrimStrZero(<xValue>, <nzeros>)   => alltrim(strzero(<xValue>, <nzeros>))

#translate def         		 =>   function
#translate enddef     		 =>   
#translate Def         	    =>   function
#translate DEF         		 =>   function
#translate P_Def( <var>, <val> ) 						=> if( <var> = NIL, <var> := <val>, <var> )
#translate ifNil( <var>, <val> ) 						=> if( <var> = NIL, <var> := <val>, <var> )

#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 if <v1> == NIL ; <v1> := <x1> ; END									;
			 [; if <vn> == NIL ; <vn> := <xn> ; END ]

#Translate DEFAU				=> DEFAULT
#Translate Try					=> While
#Translate EndTry				=> EndDo
#Translate LastCol			=> MaxCol
#Translate LastRow			=> MaxRow

#ifDEF MSWINDOWS
   #UNDEF MSDOS
	#Translate Beep				 => Tone
	#Translate CapFirst			 => TokenUpper
	#Translate MsRename			 => FRename
	#Translate IsFile			    => File
	#Translate Feof			    => HB_Feof
	//#Translate MsAdvance		    => FAdvance
	#Translate MsWriteLine	    => FWriteLine
	#Translate MsReadLine	    => FReadLine
	#Translate StrCount	    	 => GT_StrCount
	#Translate ChrCount	    	 => GT_StrCount
	#Translate PutKey	  	 	 	 => HB_KeyPut
	#Translate SaveVideo	  	  	 => SaveScreen
	
	//#Translate MkDir		  	  	 => FT_MkDir
	#Translate Atotal		  	  	 => FT_Asum
	#Translate FIsPrinter  	  	 => FT_IsPrint  // Ft_Isprint("lpt1")
	#Translate IsPrinter  	  	 => PrintReady  // Printready(1)
	#Translate PrnStatus  	  	 => PrintStat
	#Translate MkDir  	 	 	 => FT_MkDir
	#Translate FChDir  	 	 	 => FT_ChDir
	#Translate Argc 	 	 	 	 => HB_Argc
	#Translate Argv 	 	 	 	 => HB_Argv
	#Translate Program 	 	 	 => HB_ProgName
	#Translate Encrypt 	 	 	 => HB_Crypt
	#Translate Decrypt			 => HB_Decrypt
	#Translate Box(				 => MS_Box(
	
	//Versao 3.2/3.4
	//#Translate WaitKey			 => HB_Inkey
	//#Translate Inkey				 => HB_Inkey
	
	//Versao 3.0
	#Translate WaitKey			 => Inkey
		
	//#Translate Roloc			    => FT_InvClr
	#Translate Standard			 => ColorStandard
	#Translate Enhanced			 => ColorEnhanced	
	#Translate Unselected   	 => ColorUnselected

	#xtranslate Single( <t>, <l>, <b>, <r> )               => hb_DispBox( <t>, <l>, <b>, <r>, B_SINGLE )
	#xtranslate Double( <t>, <l>, <b>, <r> )               => hb_DispBox( <t>, <l>, <b>, <r>, B_DOUBLE )
	#xtranslate SingleDouble( <t>, <l>, <b>, <r> )         => hb_DispBox( <t>, <l>, <b>, <r>, B_SINGLE_DOUBLE )
	#xtranslate DoubleSingle( <t>, <l>, <b>, <r> )         => hb_DispBox( <t>, <l>, <b>, <r>, B_DOUBLE_SINGLE )
	#xtranslate SingleUni( <t>, <l>, <b>, <r> )            => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_SINGLE_UNI )
	#xtranslate DoubleUni( <t>, <l>, <b>, <r> )            => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_DOUBLE_UNI )
	#xtranslate SingleDoubleUni( <t>, <l>, <b>, <r> )      => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_SINGLE_DOUBLE_UNI )
	#xtranslate DoubleSingleUni( <t>, <l>, <b>, <r> )      => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_DOUBLE_SINGLE_UNI )
	#xtranslate BkGrnd( <t>, <l>, <b>, <r>, <c> )          => hb_DispBox( <t>, <l>, <b>, <r>, Replicate( <c>, 9 ))
	
	#Translate DiskSize   	 => FT_DskSize
	//#Translate DiskFree   	 => FT_DskFree
	
	#Translate Sx_SetScope   	 => OrdScope
	#Translate Sx_ClrScope   	 => OrdScope
#endif
#endif _TRANSLATE_CH_










