# custom-bootc

Fedora 45 bootc image for running `rpm-ostree compose build-chunked-oci` with the
fixed `ostree-ext` dependency from [rpm-ostree PR #5646](https://github.com/coreos/rpm-ostree/pull/5646).

The image starts from `quay.io/fedora/fedora-bootc:45` at digest
`sha256:1b95805de4fffac8f03a4deb0416411cdcff355d0e16012304227cbbe758934c`
and installs the matching
`rpm-ostree` and `rpm-ostree-libs` RPMs from [COPR build 11241131](https://copr.fedorainfracloud.org/coprs/mdwagner/rpm-ostree/build/11241131/).
The package version is lower than Fedora's package version, so the Containerfile
uses an explicit downgrade and checks both installed versions.

Push to `main` or run the publish workflow manually. It publishes
`ghcr.io/mdev-linux/custom-bootc:<git-commit>` and saves the image digest as a
workflow artifact. Use `ghcr.io/mdev-linux/custom-bootc@sha256:<digest>` in the
Bazzite `ostree-rechunk` recipe. GHCR makes new packages private by default;
make this package public or grant the Bazzite repository Actions read access
and log in before the rechunk step.

This image is an interim CI chunker. A successful build verifies package
installation and the chunker command; run the Bazzite rechunk job to verify
the upstream fix on its source and previous images.
