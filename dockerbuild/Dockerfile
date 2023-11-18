FROM fedora:38

ENV input_kickstart_file='ks/vojtux_en.ks' \
    output_kickstart_file='output.ks'

RUN sudo dnf install -yq lorax-lmc-novirt pykickstart \
&& mkdir -p /live/tmp

COPY ./ /target
WORKDIR /target

CMD ls -Rl /target
CMD /target/dockerbuild/start.sh
