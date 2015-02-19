# Update repositories?
pacman -Syy
# Install python
pacman -S python
# Install development packages, select only gcc, #10?
pacman -S base-devel
# Get the gpio stash
wget https://pypi.python.org/packages/source/R/RPi.GPIO/RPi.GPIO-0.5.11.tar.gz
tar xf RPi.GPIO-0.5.11.tar.gz 
cd RPi.GPIO-0.5.11
python setup.py install
# done...
