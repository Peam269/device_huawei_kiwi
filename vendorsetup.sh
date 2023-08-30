########### extendrom section ###########
export ENABLE_EXTENDROM=true
#export EXTENDROM_PACKAGES="noEOSappstore F-Droid F-DroidPrivilegedExtension additional_repos.xml AuroraStore"
export EXTENDROM_BOOT_DEBUG=true
export EXTENDROM_DEBUG_PATH=/persist

$PWD/vendor/extendrom/er.sh
