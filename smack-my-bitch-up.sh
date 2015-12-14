#!/bin/sh -e

# Exit early if no sessions with my username are found
if ! who | grep -wq $USER; then
  exit
fi

# Emails
HER_EMAIL='gao.myue@gmail.com'

REASONS=(
  'Working hard'
  'Gotta ship this feature'
  'Someone fucked the system again'
)
rand=$[ $RANDOM % ${#REASONS[@]} ]

RANDOM_REASON=${REASONS[$rand]}
SUBJECT="Late at work. "$RANDOM_REASON

TIMETABLE=( "17:30 17:50 18:30 18:50 19:30 20:30 21:30 22:30" )

STAYLATE=`kdialog --title "Mingyue's Choice" --yesno "Stay working a little longer?"`

if STAYLATE == 1; then
    exit
fi

TIMETOLEAVE=`kdialog --combobox "Leave company at:" ${TIMETABLE}`
MESSAGE="Could leave at "$TIMETOLEAVE"."

# Send a text message
RESPONSE=`mail -s "${SUBJECT}" ${HER_EMAIL} <<< "${MESSAGE}"`

# Log errors
if [ $? -gt 0 ]; then
  echo "Failed to send SMS: $RESPONSE"
  exit 1
fi
