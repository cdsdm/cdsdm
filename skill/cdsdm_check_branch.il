; cdsdm_check_branch.il
;

procedure( cdsdm_check_branch(lib @optional val )
  let( ( path cid irp num return ) 

    path = ddGetObjReadPath(ddGetObj(lib))
    cid = ipcBatchProcess( sprintf(nil "%s -C %s branch" cdsdm_git->git path ) "" "" )
    ipcWaitForProcess( cid )
    irp=ipcReadProcess( cid 10 )

    ; delete the oldest branch
    when( length(parseString(irp " *\n")) > cdsdm_git->max_branch + 1
      shell( sprintf(nil "%s -C %s branch -q -D %s" cdsdm_git->git path car(parseString(irp " *\n"))) )
    )

    if( irp && member( cdsdm_git->master parseString(irp))  then
      case( val
	  ( "list"
			return = parseString( irp " *\n" )
	  )
	  ( t
			num = length(parseString( irp "\n" )) - length(exists(x parseString( irp " \n" ) x=="*")) + 2
			return = nthelem( num parseString( irp "* \n" ) )
	  )
      )
    else
      return = nil
    )

    return

  )
)

;
;
