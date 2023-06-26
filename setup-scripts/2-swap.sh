for i in ${DISK}; do
   cryptsetup open --type plain --key-file /dev/random "${i}"-part4 "${i##*/}"-part4
   mkswap /dev/mapper/"${i##*/}"-part4
   swapon /dev/mapper/"${i##*/}"-part4
done
