; cdsdm_list_add.il
;

procedure( cdsdm_list_add(lib)
  let( ( path cid irp (alist "") xx update new (clist nil) (flist nil) cvlist (alllist nil) ) 

    path = ddGetObjReadPath(ddGetObj(lib))
    cid = ipcBatchProcess( sprintf(nil "%s -C %s status -s" cdsdm_git->git path)  "" "" )
    ipcWaitForProcess( cid )
    while( irp=ipcReadProcess(cid 10) alist = sprintf(nil "%s%s" alist irp) )

    when( alist
      update = new = parseString(alist "\n")

      foreach( x  update
	xx = cadr(parseString(x))
	if( length(parseString(xx "/"))>1  then
	  if( !member( car(parseString(xx "/")) clist ) then
	    clist = cons( car(parseString(xx "/")) clist )
	  )
	else
	  flist = cons( x flist )
	)
      )

      when( length(clist)>0
	foreach( f flist
	  new = remove(f new)
	) 
	foreach( c clist
	  cvlist=nil
	  foreach( n reverse(new)
	    xx = cadr(parseString(n))
	    if( c == car(parseString(xx "/"))  then
	      when( substring( n 1 2 ) == "??"
		n = strcat( " N " xx )
	      )
	      cvlist = cons( n cvlist )
	    )
	  )
	  alllist = cons( list(strcat(c "/") cvlist) alllist )
	)
      )

      when( length(flist)>0
	foreach( f flist
	  when( substring( f 1 2 ) == "??"
	    f = strcat( " N " cadr(parseString(f) ) )
	  )
	  alllist = cons( list( cadr(parseString(f)) list(f) ) alllist )
	)
      )
	  
    )

    alllist

  )
)

;
;
