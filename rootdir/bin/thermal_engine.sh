#!/vendor/bin/sh

# Set LD_PRELOAD environment variable to include the shim lib
export LD_PRELOAD=/system/lib64/libshim_cutils.so

# Start thermal-engine
/system/vendor/bin/thermal-engine
