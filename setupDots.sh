#!/bin/bash

# CREATE THE BACKUP DIRECTORY
BAK_DIR="${HOME}/.dotfile_bak"
echo $BAK_DIR
if [ ! -d "${BAK_DIR}" ]; then
	mkdir ${BAK_DIR}
fi

# CREATE DATE DIRECTORY
CUR_DATE=`date +%Y%m%d-%H:%M:%S.%s`
#CUR_DATE=`date +%Y%m%d` #-%H:%M:%S.%s`
CUR_DATE_FOLDER=$BAK_DIR/$CUR_DATE
if [ ! -d "${CUR_DATE_FOLDER}" ]; then
	mkdir ${CUR_DATE_FOLDER}
fi

# CREATE A LIST OF ALL DOTFILES IN THE GIT REPO
DOTFILES=`ls -1 -a |grep '\.*'|grep -v setupDots |grep -v git |awk '{if(NR>2)print}'`
#echo $DOTFILES

# BACKUP DOT FILES TO BACKUP DIR
for a in ${DOTFILES}; do
  if [ -f ${HOME}/$a ]; then
    cp ${HOME}/$a ${CUR_DATE_FOLDER}/$a
  fi
done

# RM CURRENT DOTFILES
for a in ${DOTFILES}; do
  if [ -f ${HOME}/$a ]; then
    rm ${HOME}/$a
  fi
done

# LINK GIT REPO FILES TO DOT FILES
for a in ${DOTFILES}; do
  ln -s ${PWD}/$a ${HOME}/$a
done





