; cdsdm_clone.il
;

procedure( cdsdm_clone()
  let( ( cdslib backup work_dir repo options path work_path iport oport value lib )

    when( cdsdm_config_check()
      if( boundp('cdsdm_clone_form) && hiIsFormDisplayed(cdsdm_clone_form)  then
	hiDisplayForm('cdsdm_clone_form)
      else
	when( cdsdm_clone_form()
	  when( strlen(cdsdm_clone_form->cdsdm_clone_remote_field->value) > 0
	    work_dir = cdsdm_git->work_dir
	    repo = cdsdm_clone_form->cdsdm_clone_remote_field->value
	    options = cdsdm_clone_form->cdsdm_clone_options_field->value 

	    cdslib = ddGetStartup("cds.lib")
	    backup = cdsdm_cdslib_backup()
	    shell( sprintf( nil "%s %s %s" cdsdm_git->cp cdslib backup ) )

	    lib = car(parseString(car(reverse(parseString(repo "/"))) "."))
	    path = strcat(work_dir "/" lib)
	    if( substring(work_dir -1 1) == "/" then
	      work_path = strcat( work_dir lib )
	    else
	      work_path = strcat( work_dir "/" lib )
	    )
            if( isDir( work_path ) || member( lib ddGetLibList()~>name )  then
	      printf( sprintf(nil "*ERROR* '%s' already exists.\n" work_path ) )
	    else
	      if( shell( sprintf( nil "%s -C %s clone -q %s %s" cdsdm_git->git work_dir options repo ))  then
	        shell( sprintf( nil "%s -C %s config core.filemode false" cdsdm_git->git path) )
		cdsdm_permission(path "-")

	        iport = infile( backup )
	        oport = outfile( cdslib )
	        while( gets(value iport)
	 	  fprintf( oport "%s" value )
	        )
	        if( substring( work_dir -1 1 ) == "/" then
		  fprintf( oport "DEFINE %s %s\n" lib strcat(work_dir lib) )
	        else
		  fprintf( oport "DEFINE %s %s\n" lib strcat(work_dir "/" lib) )
	        )
	        fprintf( oport "ASSIGN %s DISPLAY cdsdm\n" lib )
	        close( oport )
	        close( iport )
	        ddUpdateLibList()
	      else
		lmgrDisplayMessage( "*ERROR* '%s' repository does not exist." repo )
	      )
	    )
	  )
        )
      )
    )

  )
)


procedure( cdsdm_clone_form()
  let( ( remote_field options_field )

      remote_field = hiCreateStringField(
        ?name           'cdsdm_clone_remote_field
        ?prompt         "Repository:"
        ?value          ""
        ?defValue       ""
      )

      options_field = hiCreateStringField(
	?name		'cdsdm_clone_options_field
	?prompt		"Options:"
	?value		cdsdm_git->clone_options
	?defValue	cdsdm_git->clone_options
      )

      hiCreateAppForm(
        ?name           'cdsdm_clone_form
        ?formTitle      "cdsDM: Clone Library"
        ?fields         list(
                          list( remote_field	10:5    600:30  80 )
			  list( options_field	10:35	600:30	80 )
                        )
        ?help           ""
        ?buttonLayout   '(OKCancel)
	?initialSize	t

      )

      hiDisplayForm('cdsdm_clone_form)

  )
)

;
;
