; cdsdm_init.il
;

procedure( cdsdm_init()
  let( ( rep rep2 lib path cdslib backup iport oport value ) 

    when( cdsdm_init_form()

      rep = cdsdm_init_form->cdsdm_init_rep_field->value

      when( (rep2 = parseString( rep "/" )) && listp( rep2 )
        lib = car(parseString(car(reverse(rep2)) "."))
      )

      path = strcat( cdsdm_git->work_dir lib )

      when( shell( sprintf(nil "cd %s && %s clone -q %s" cdsdm_git->work_dir cdsdm_git->git rep) )

	; config
	shell( sprintf( nil "cd %s && %s config core.filemode false" path cdsdm_git->git ) )

	; copy
	foreach( file remove("." remove(".." getDirFiles(cdsdm_git->config)))
	  shell( sprintf( nil "%s %s/%s %s/." cdsdm_git->cp cdsdm_git->config file path ) )
	)

        ; backup
        cdslib = ddGetStartup("cds.lib")
	backup = cdsdm_cdslib_backup()
        shell( sprintf( nil "%s %s %s" cdsdm_git->cp cdslib backup ) )

	iport = infile( backup )
	oport = outfile( cdslib )
	while( gets(value iport)
	  fprintf( oport "%s" value )
	)
	fprintf( oport "DEFINE %s %s\n" lib path)
	fprintf( oport "ASSIGN %s DISPLAY cdsdm\n" lib )
	close( oport )
	close( iport )
	ddUpdateLibList()

	;;; commit
	shell( sprintf( nil "cd %s && %s add --all" path cdsdm_git->git ) )
	shell( sprintf( nil "cd %s && %s commit -q -m 'initial commit'" path cdsdm_git->git ) )
	shell( sprintf( nil "cd %s && %s push -q origin master" path cdsdm_git->git ) )

	;;; permission
	cdsdm_permission(path "-")
	
      )
    )

  )
)


procedure( cdsdm_init_form()
  let( ( rep )

    rep = hiCreateStringField(
	?name		'cdsdm_init_rep_field
	?prompt		"Repository:"
	?value		""
	?defValue	""
    )

    hiCreateAppForm(
	?name		'cdsdm_init_form
	?formTitle	"cdsDM: Repository Initialization"
	?fields		list(
			  list( rep	10:0	600:30	80 )
			)
	?buttonLayout	'(OKCancel)
    )

    hiDisplayForm('cdsdm_init_form)

  )
)

;
;
