for p in ${HOME}/bin ${HOME}/git/scripts /opt/cinc-workstation/embedded/bin /usr/bin/vendor_perl /usr/bin/core_perl ${GOPATH}/bin ~/git/core-tools/bin
do
  if [ -d "${p}" ]; then
    PATH="${PATH}:${p}"
  fi
done
export PATH
