# add repositories as sources of packages
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-38&arch=x86_64
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f38&arch=x86_64
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-38&arch=x86_64
#rpm fusion repos
repo --name=rpmfusion-free-released --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-38&arch=x86_64
repo --name=rpmfusion-free-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-38&arch=x86_64
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-38&arch=$basearch
repo --name=rpmfusion-nonfree-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-38&arch=$basearch
#vojtux repo
repo --install --name=Copr-repo-for-vojtux-apps-owned-by-tyrylu --baseurl=https://copr-be.cloud.fedoraproject.org/results/tyrylu/vojtux-apps/fedora-38-x86_64/
