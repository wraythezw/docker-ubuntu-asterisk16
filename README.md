# docker-ubuntu-asterisk16
Ubuntu 18 + Asterisk 16/PJSIP Build

This is a really bare container, with the bare minimum config to get asterisk running with PJSIP and extensions.conf.

I am using this as the base for a callcenter project, building onto the image as required.

## Personal details
Web: www.keithro.se
Skype: kariba.keith
Email: me(at)keithro(dot)se

Please feel free to get in touch for any custom projects or help you might need.

# Build
docker build -t ubuntu16-asterisk .

# Run
docker run -t ubuntu16-asterisk
