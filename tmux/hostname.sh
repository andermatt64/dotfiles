#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

main()
{
  hostname=$(hostname)
  echo "$hostname"
}

#run main driver program
main
