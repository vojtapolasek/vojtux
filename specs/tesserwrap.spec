# Created by pyp2rpm-3.3.4
%global pypi_name tesserwrap

Name:           python-%{pypi_name}
Version:        0.1.6
Release:        1%{?dist}
Summary:        Basic python bindings to the Tesseract C++ API

License:        Apache License 2.0
URL:            https://github.com/gregjurman/tesserwrap
Source0:        %{pypi_source}

Requires:  tesseract
BuildRequires:  python3-devel
BuildRequires:  python3dist(nose)
BuildRequires:  python3dist(pillow)
BuildRequires:  python3dist(setuptools)
BuildRequires:  tesseract-devel
BuildRequires:  gcc-g++

%description
Tesserwrap - Basic Tesseract API Wrapper for PythonTesserwrap is a project that
allows simple bindings to Tesseract's API rather than executing the application
manually each time.Docs: IRC: tesserwrap on Freenode

%package -n     python3-%{pypi_name}
Summary:        %{summary}
%{?python_provide:%python_provide python3-%{pypi_name}}

%description -n python3-%{pypi_name}
Tesserwrap - Basic Tesseract API Wrapper for PythonTesserwrap is a project that
allows simple bindings to Tesseract's API rather than executing the application
manually each time.Docs: IRC: tesserwrap on Freenode


%prep
%autosetup -n %{pypi_name}-%{version}
# Remove bundled egg-info
rm -rf %{pypi_name}.egg-info

%build
%py3_build

%install
%py3_install

%check
%{__python3} setup.py test

%files -n python3-%{pypi_name}
%{python3_sitearch}/%{pypi_name}
%{python3_sitearch}/%{pypi_name}-%{version}-py%{python3_version}.egg-info
%{python3_sitearch}/libtesserwrap.cpython-%{python3_version_nodots}-%{python3_platform_triplet}.so 

%changelog
* Fri Sep 25 2020 Vojtech Polasek <vpolasek@redhat.com> - 0.1.6-1
- Initial package.
