# add repositories as sources of packages
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-34&arch=x86_64
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f34&arch=x86_64
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-34&arch=x86_64
#rpm fusion repos
repo --name=rpmfusion-free-released --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-34&arch=x86_64
repo --name=rpmfusion-free-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-34&arch=x86_64
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-34&arch=$basearch
repo --name=rpmfusion-nonfree-updates --mirrorlist=https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-34&arch=$basearch
#festival repo
repo --install --name=Copr-repo-for-festival-reborn-owned-by-tyrylu --baseurl=https://copr-be.cloud.fedoraproject.org/results/tyrylu/festival-reborn/fedora-32-x86_64/
#fegora repo
repo --install --name=Copr-repo-for-fegora-apps-owned-by-tyrylu --baseurl=https://copr-be.cloud.fedoraproject.org/results/tyrylu/fegora-apps/fedora-33-x86_64/
