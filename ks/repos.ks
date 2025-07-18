# add repositories as sources of packages
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-42&arch=x86_64
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f42&arch=x86_64
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-42&arch=x86_64
#rpm fusion repos
repo --name=rpmfusion-free-released --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-42&arch=x86_64
repo --name=rpmfusion-free-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-42&arch=x86_64
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-42&arch=$basearch
repo --name=rpmfusion-nonfree-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-42&arch=$basearch
#vojtux repo
repo --name=Copr-repo-for-vojtux-apps-owned-by-tyrylu --baseurl=https://copr-be.cloud.fedoraproject.org/results/tyrylu/vojtux-apps/fedora-42-x86_64/
