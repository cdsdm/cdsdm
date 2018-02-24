; cdsdm_check_remote.il
;

procedure( cdsdm_check_remote( lib )
  let( ( path cid irp irp1 (irp2 nil) (return nil) )

    path = ddGetObjReadPath(ddGetObj(lib))

    if( cadr(cdsdm_check_add(lib)) then
      cdsdm_cdslib( lib "conflict" )
      return = "conflicting"
    else
      cid = ipcBatchProcess( sprintf(nil "%s -C %s remote show origin" cdsdm_git->git path)  "" "" )
      ipcWaitForProcess( cid )
      while( irp=ipcReadProcess( cid 10 ) irp1 = irp )
      foreach( x parseString(irp1 "\n") irp2=cons(schRemoveLeadingWhiteSpace( schRemoveTrailingWhiteSpace(x) ) irp2) )

      if( member( "master pushes to master (up to date)" irp2 )  then
        return = "up to date"
      else
        if( member( "master pushes to master (local out of date)" irp2 )  then
	  cdsdm_cdslib( lib "attention" )
          return = "local out of date"
        else
          when( member( "master pushes to master (fast-forwardable)" irp2 )
            return = "fast-forwardable"
	  )
	)
      )
    )

    return

  )
)

;
;
