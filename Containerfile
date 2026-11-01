FROM quay.io/fedora/fedora-bootc:45@sha256:1b95805de4fffac8f03a4deb0416411cdcff355d0e16012304227cbbe758934c

ARG RPM_OSTREE_VERSION=1db3a96
ARG RPM_OSTREE_RELEASE=1

LABEL org.opencontainers.image.source="https://github.com/MDev-Linux/custom-bootc" \
      org.opencontainers.image.description="Fedora 45 bootc chunker with COPR rpm-ostree build 11241131" \
      io.mdev.copr-build="11241131" \
      io.mdev.rpm-ostree-revision="1db3a9606bcc1074f748452ad837d3496156ec86"

ADD https://copr.fedorainfracloud.org/coprs/mdwagner/rpm-ostree/repo/fedora-45/mdwagner-rpm-ostree-fedora-45.repo /etc/yum.repos.d/mdwagner-rpm-ostree.repo

RUN dnf -y downgrade \
      "rpm-ostree-${RPM_OSTREE_VERSION}-${RPM_OSTREE_RELEASE}.fc45" \
      "rpm-ostree-libs-${RPM_OSTREE_VERSION}-${RPM_OSTREE_RELEASE}.fc45" && \
    rpm -q rpm-ostree rpm-ostree-libs && \
    test "$(rpm -q --qf '%{VERSION}-%{RELEASE}' rpm-ostree)" = "${RPM_OSTREE_VERSION}-${RPM_OSTREE_RELEASE}.fc45" && \
    test "$(rpm -q --qf '%{VERSION}-%{RELEASE}' rpm-ostree-libs)" = "${RPM_OSTREE_VERSION}-${RPM_OSTREE_RELEASE}.fc45" && \
    dnf clean all
