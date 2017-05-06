; init.il
;

; sets the priority value for child processes
ipcSetPriority(0)

; make table
when( null(boundp('cdsdm_git)) || null(tablep(cdsdm_git))
  cdsdm_git = makeTable("cdsdm_git")
)

; path
cdsdm_git->path = getShellEnvVar("CDSDM_PATH")
cdsdm_git->config = strcat( cdsdm_git->path "/config" )
cdsdm_git->skill = strcat( cdsdm_git->path "/skill" )

; load
load( strcat( cdsdm_git->skill "/load.il" ) )

; var
cdsdm_git->work_dir = "./"
cdsdm_git->backup_name = ".cds.lib.cdsdm"
cdsdm_git->backup_path = cdsdm_cdslib_backup()

cdsdm_git->master = "master"
cdsdm_git->max_branch = 60
cdsdm_git->clone_options = "--depth 1"
cdsdm_git->bg = "&"	; "&" or ""
cdsdm_git->push = t	; t or nil

; command
cdsdm_git->chmod = "/bin/chmod"
cdsdm_git->cp = "/bin/cp"
cdsdm_git->git = "git"
cdsdm_git->gitk = "gitk"
cdsdm_git->rm = "/bin/rm"
cdsdm_git->xterm = "/usr/bin/xterm"

; trigger
ddRegTrigger( "PreDeleteObj" 'cdsdm_trigger )


;
;
