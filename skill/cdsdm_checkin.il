; cdsdm_checkin.il
;

procedure( cdsdm_checkin( lib )
  let( (path (add_file "") (rm_file "") cid irp message oport temp_file)

    when( cdsdm_config_check()
      path = ddGetObjReadPath(ddGetObj(lib))

      when( cdsdm_checkin_form(lib)
	when( cdsdm_checkin_form->all_list
	  ; add
	  foreach( x  cdsdm_checkin_form->cdsdm_checkin_files_field->value
	    case( car(parseString(x))
	        ( ("M" "N" "A" "R" "C" "T")
			add_file = strcat( add_file " '" cadr(parseString(x)) "'" )  
			when( strlen(add_file) > 512
			  cid = ipcBatchProcess( sprintf(nil "%s -C %s add %s" cdsdm_git->git path add_file)  "" "" )
			  while( ipcReadProcess( cid 10 )  ipcWaitForProcess( cid ) )
		          lmgrDisplayMessage( sprintf(nil "[checkin] %s\n" add_file ) )
			  add_file = ""
			)
	        )
	        ( ("D")
			rm_file = strcat( rm_file " '" cadr(parseString(x)) "'" )  
			when( strlen(rm_file) > 512
			  cid = ipcBatchProcess( sprintf(nil "%s -C %s rm %s" cdsdm_git->git path rm_file)  "" "" )
			  while( ipcReadProcess( cid 10 )  ipcWaitForProcess( cid ) )
			  lmgrDisplayMessage( sprintf(nil "[checkin] %s\n" rm_file ) )
			  rm_file=""
			)
	        )
	    )
	  )

	  when( strlen(add_file) > 0
	    cid = ipcBatchProcess( sprintf(nil "%s -C %s add %s" cdsdm_git->git path add_file)  "" "" )
	    while( ipcReadProcess( cid 10 )  ipcWaitForProcess( cid ) )
	    lmgrDisplayMessage( sprintf(nil "[checkin] %s\n" add_file ) )
	  )

	  when( strlen(rm_file) > 0
	    cid = ipcBatchProcess( sprintf(nil "%s -C %s rm %s" cdsdm_git->git path rm_file )  "" "" )
	    while( ipcReadProcess( cid 10 )  ipcWaitForProcess( cid ) )
            lmgrDisplayMessage( sprintf(nil "[checkin] %s\n" rm_file ) )
	  )

	  ; commit
          temp_file = makeTempFileName("/tmp/cdsdm")
          oport = outfile( temp_file )
          if( strlen(message=cdsdm_checkin_form->cdsdm_checkin_commit_field->value) > 0  then 
	    fprintf( oport message )
          else
	    fprintf( oport "merge branch '%s'\n" cdsdm_check_branch(lib) )
          )
          close( oport )
 	  cid = ipcBatchProcess( sprintf(nil "%s -C %s commit -F %s" cdsdm_git->git path temp_file ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess( cid 10 )
	    lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) )
	  )
	  deleteFile( temp_file )

	  ; checkin
	  cdsdm_checkin_merge(lib)

	  ; push
	  when( cdsdm_checkin_form->cdsdm_checkin_push_field->value
	    cdsdm_push(lib)
	  )

        ) 
      )
    )

  )
)


procedure( cdsdm_checkin_form(lib)
  let( (all_list cells_label cells_field files_label files_field commit_label commit_field push_field)

    all_list = cdsdm_list_add(lib)

    cells_label = hiCreateLabel(
	?name           'cdsdm_checkin_cells_label
	?labelText      "Cells"
    )
    cells_field = hiCreateListBoxField(
	?name		'cdsdm_checkin_cells_field
	?prompt		"Cells:"
	?choices	foreach(mapcar x all_list car(x) )
	?numRows	min( 2 20 )
	?multipleSelect	t
	?changeCB	"cdsdm_checkin_cells_field_cb()"
    )

    files_label = hiCreateLabel(
	?name           'cdsdm_checkin_files_label
	?labelText      "Files"
    )
    files_field = hiCreateListBoxField(
	?name		'cdsdm_checkin_files_field
	?prompt		"Files:"
	?choices	nil
	?numRows	min( 2 20 )
	?multipleSelect	t
    )

    commit_label = hiCreateLabel(
	?name           'cdsdm_checkin_commit_label
	?labelText      "Commit Message"
    )
    commit_field = hiCreateMLTextField(
	?name		'cdsdm_checkin_commit_field
	?prompt		"Message:"
	?value		""
	?defValue	""
	?editable	t
	?hasVerticalScrollbar	t
	?hasHorizontalScrollbar	t
	?callback	"cdsdm_checkin_commit_field_cb()"
    )
    push_field = hiCreateBooleanButton(
	?name		'cdsdm_checkin_push_field
	?buttonText	"Push:"
	?value		cdsdm_git->push
	?defValue	cdsdm_git->push
    )

    hiCreateAppForm(
	?name		'cdsdm_checkin_form
	?formTitle	"cdsDM: Checkin"
	?fields		list(
			  list( cells_label	5:0	100:30	0 )
			  list( cells_field	5:25	200:320 0 )
			  list( files_label	200:0	100:30	0 )
			  list( files_field	200:25	470:320 0 )
			  list( commit_label	5:345	100:30	0 )
			  list( commit_field	5:370	665:120	0 )
			  list( push_field	590:345	80:30	40 )
			)
	?buttonLayout	'(OKCancel)
	?initialSize	t
    )

    cdsdm_checkin_form->all_list = all_list
    cdsdm_checkin_form->cdsdm_checkin_cells_field->value=cdsdm_checkin_form->cdsdm_checkin_cells_field->choices
    cdsdm_checkin_cells_field_cb()

    hiDisplayForm('cdsdm_checkin_form)

  )
)


procedure( cdsdm_checkin_cells_field_cb()
  let( ( (commit_list nil) )

    foreach( x  reverse(cdsdm_checkin_form->cdsdm_checkin_cells_field->value)
      foreach( y  cdsdm_checkin_form->all_list
	when( x==car(y)
	  commit_list = append(cadr(y) commit_list)
	)
      )
    )

    cdsdm_checkin_form->cdsdm_checkin_files_field->choices = commit_list
    cdsdm_checkin_form->cdsdm_checkin_files_field->value = commit_list

  )
)


procedure( cdsdm_checkin_commit_field_cb()
  let( (string)

    rexCompile( "(" )
    string = rexReplace( cdsdm_checkin_form->cdsdm_checkin_commit_field->value "[" 0 )
    rexCompile( ")" )
    string = rexReplace( string "]" 0 )
    rexCompile( "\"" )
    cdsdm_checkin_form->cdsdm_checkin_commit_field->value = rexReplace( string "'" 0 )

  )
)


procedure( cdsdm_checkin_merge(lib)
  let( ( path branch master cid irp db )

      path = ddGetObjReadPath(ddGetObj(lib))
      branch = cdsdm_check_branch(lib)
      master = cdsdm_git->master

      when( branch != master
	; close DB
	foreach( cell ddGetObj(lib)~>cells
	  foreach( view cell~>views
	    db = dbFindOpenCellView( ddGetObj(lib) cell~>name view~>name )
	    when( db  dbClose( db )) 
	  )
	)

        cid = ipcBatchProcess( sprintf(nil "%s -C %s checkout %s" cdsdm_git->git path master ) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )
        cid = ipcBatchProcess( sprintf(nil "%s -C %s merge %s" cdsdm_git->git path branch ) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )
	cid = ipcBatchProcess( sprintf(nil "%s -C %s checkout %s" cdsdm_git->git path branch ) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )
        cid = ipcBatchProcess( sprintf(nil "%s -C %s add --all" cdsdm_git->git path) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )
        cid = ipcBatchProcess( sprintf(nil "%s -C %s commit -m '%s'" cdsdm_git->git path branch ) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )
        cid = ipcBatchProcess( sprintf(nil "%s -C %s checkout %s" cdsdm_git->git path master ) "" "" )
	ipcWaitForProcess(cid)
        while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[checkin] %s" irp) ) )

        cdsdm_cdslib( lib "checkin" )
    
	cdsdm_permission(path "-")

	ddUpdateLibList()
      )

  )
)

;
;
