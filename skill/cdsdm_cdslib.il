; cdsdm_cdslib.il
;

procedure( cdsdm_cdslib(lib display)
  let( ( cdslib backup iport oport value (return nil) )

    when( ddGetObj(lib) 
      cdslib = ddGetStartup("cds.lib")
      backup = cdsdm_cdslib_backup()

      when( shell( sprintf( nil "%s %s %s" cdsdm_git->cp cdslib backup ) )
	iport = infile( backup )
	oport = outfile( cdslib )
	while( gets(value iport)
       	  if( value == sprintf( nil "ASSIGN %s DISPLAY cdsdm\n" lib ) ||
	      value == sprintf( nil "ASSIGN %s DISPLAY checkout\n" lib ) ||
	      value == sprintf( nil "ASSIGN %s DISPLAY checkin\n" lib ) ||
	      value == sprintf( nil "ASSIGN %s DISPLAY attention\n" lib ) ||
	      value == sprintf( nil "ASSIGN %s DISPLAY conflict\n" lib )  then
	    case( display 
	        ( "checkout"	fprintf( oport "ASSIGN %s DISPLAY checkout\n" lib )	)
	        ( "checkin"	fprintf( oport "ASSIGN %s DISPLAY checkin\n" lib )	)
	        ( "cdsdm"	fprintf( oport "ASSIGN %s DISPLAY cdsdm\n" lib )	)
		( "attention"	fprintf( oport "ASSIGN %s DISPLAY attention\n" lib )	)
		( "conflict"	fprintf( oport "ASSIGN %s DISPLAY conflict\n" lib )	)
		( "delete"	lmgrDisplayMessage("Deleted ASSIGN script.\n")		)
	    )
	  else
	    fprintf( oport "%s" value )
	  )
	)

	close( iport )
	close( oport )
	ddUpdateLibList()
	return=t

      )
    )

    return

  )
)

;
;
