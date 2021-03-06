#!/bin/bash

for x in $(ls /var/lib/lxc)
do
	case "${x}" in
		arch*)
			echo "${x}: pacman -Syu"
			lxc-attach -n "${x}" -- pacman -Syu
			;;

		alpine*)
			echo "${x}: apk update"
			lxc-attach -n "${x}" -- apk update
			lxc-attach -n "${x}" -- apk upgrade
			;;

		centos*|fedora*)
			echo "${x}: yum -y update"
			lxc-attach -n "${x}" -- yum update
			lxc-attach -n "${x}" -- yum update
			;;

		debian*|ubuntu*)
			echo "${x}: apt-get update && apt-get -yq dist-upgrade"
			lxc-attach -n "${x}" -- apt-get update
			lxc-attach -n "${x}" -- apt-get dist-upgrade
			;;

		gentoo*)
			echo "${x}: emerge -uDNv world"
			lxc-attach -n "${x}" -- emerge --sync
			lxc-attach -n "${x}" -- emerge -uDNv world
			;;

		*)
			echo "${x}: unknown"
			;;
	esac
done

