# cdsDM
Cadence Virtuoso Design Management System

## What is cdsDM?
cdsDM is design management system using Git.

## Installation and setup

* Clone this repository

* Add to your environment  
  for the bourne shell  
  export CDSDM_PATH="{cloned_dir}/cdsdm"  
  export CDS_WORKAREA=$CDSDM_PATH

  .cdsinit  
  add the following line to your .cdsinit  
  load( strcat(getShellEnvVar("CDSDM_PATH") "/init.il") )  

## Initial setup

* Git init  
create empty shared git repository in your local or github, gitlab, gitolite, gitbucket, etc.  
e.g.)
 git init --bare --shared {remote_repository_path}/myLib.git

* Init (execute only by owner)  
configure required files for the cadence library to an empty git repository.  
Library Manager=>cdsDM=>Setup=>Init...  
enter an empty git repository in the repository field and click OK.  
e.g.)
 Repository: {remote_repository_path}/myLib.git

* Clone (execute other members)  
clone library in local directory.  
Library Manager=>cdsDM=>Clone...  
enter remote repository and click OK.  
e.g.)
 Repository: {remote_repository_path}/myLib.git
 Options: --depth 1

![Alt text](/img/image1.png)

## How to use

* Checkout  
Library Manager=>cdsDM=>Checkout  
to edit cellviews, you check out library.  
library is read-only until you check it out for editing.  

![Alt text](/img/image2.png)

* Checkin  
Library Manager=>cdsDM=>Checkin  
when you check and save all cellviews, you checkin library.  
library returns to read-only.  

![Alt text](/img/image3.png)

* Cancel Checkout  
Library Manager=>cdsDM=>Cancel Checkout  
discard editing cellviews and cancel checkout  

* Push  
Library Manager=>cdsDM=>Push  
push the modified cellviews to the remote repository.  

* Pull  
Library Manager=>cdsDM=>Pull  
pull the updated cellviews from the remote repository.  

