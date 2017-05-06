; cdsdm_config.il
;

procedure( cdsdm_config()
  let( ( user_name user_email )

    when( cdsdm_config_form()
      user_name = cdsdm_config_form->user_name_field->value
      user_email = cdsdm_config_form->user_email_field->value

      if( strlen(user_name)>0 && strlen(user_email)>0 then
	shell( sprintf( nil "%s config --global user.name \"%s\"" cdsdm_git->git user_name ) )
	shell( sprintf( nil "%s config --global user.email \"%s\"" cdsdm_git->git user_email ) )
	t
      else
	nil
      )
    )

  )
)


procedure( cdsdm_config_form()
  let( ( cid irp (user_name "") (user_email "") field1 field2 )

    unless( boundp('cdsdm_config_form) && hiIsFormDisplayed(cdsdm_config_form)

	;;; get user.name
	cid = ipcBatchProcess( sprintf(nil "%s config --global user.name" cdsdm_git->git)  "" "" )
	ipcWaitForProcess( cid )
	when( irp=ipcReadProcess( cid 10 )
	  user_name = car(parseString( irp "\n" ))
	)

	;;; get user.email
	cid = ipcBatchProcess( sprintf(nil "%s config --global user.email" cdsdm_git->git)  "" "" )
	ipcWaitForProcess( cid )
	when( irp=ipcReadProcess( cid 10 )
	  user_email = car(parseString( irp "\n" ))
	)

	field1 = hiCreateStringField(
        	?name           'user_name_field
	        ?prompt         "User Name:"
	        ?value          user_name
	        ?defValue       user_name
	)

	field2 = hiCreateStringField(
        	?name           'user_email_field
	        ?prompt         "User Email:"
	        ?value          user_email
	        ?defValue       user_email
	)

	hiCreateAppForm(
	        ?name           'cdsdm_config_form
	        ?formTitle      "cdsDM: Git Config"
	        ?fields         list(
	                          list( field1  10:0   	460:30  80  )
	                          list( field2  10:30   460:30  80  )
	                        )
	        ?buttonLayout   '(OKCancel)
	)

    )


    hiDisplayForm('cdsdm_config_form)

  )
)


procedure( cdsdm_config_check()
  let( ( cid irp (user_name nil) (user_email nil) (return nil) )

    cid = ipcBatchProcess( sprintf(nil "%s config --global user.name" cdsdm_git->git) "" "")
    irp=ipcReadProcess( cid 10 ) 
    when( irp && strlen(irp) > 0 user_name = t )

    cid = ipcBatchProcess( sprintf(nil "%s config --global user.email" cdsdm_git->git) "" "")
    irp=ipcReadProcess( cid 10 ) 
    when( irp && strlen(irp) > 0 user_email = t )

    if( user_name && user_email  then
	return = t  
    else
      when(cdsdm_config()
	return = t
      )
    )

    unless( return
      lmgrDisplayMessage( "*ERROR* git configuration error.\n" )
    )

    return

  )
)

;
;
