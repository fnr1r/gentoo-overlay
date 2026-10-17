# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="https://github.com/BratishkaErik/ncdu"

declare -g -r -A ZBS_DEPENDENCIES=(
    [translate_c-2.0.0-Q_BUWltOBwA0229IE8wwSxxGzOxyRso3hvcb1nN8oJX_.tar.gz]='https://codeberg.org/ziglang/translate-c/archive/2.0.0.tar.gz'
	[aro-0.0.0-JSD1QtuBNwCASyBtNF3pqTl_W3oAJQGEVyFAtrBSE_Pa.tar.gz]='https://codeberg.org/ziglang/arocc/archive/d0c8c4d9c55daa7ef6e40cf0f630a5b5e900989b.tar.gz'
)

ZIG_SLOT="0.17"
ZIG_NEEDS_LLVM=1

inherit zig


SRC_URI="
	https://github.com/BratishkaErik/ncdu/releases/download/v${PV}/${P}-src.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"

BDEPEND=""
DEPEND="
	app-arch/zstd:=
	sys-libs/ncurses:=[unicode(+)]
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" "ChangeLog" )

src_configure() {
	local my_zbs_args=(
		-Dpie=true
		# Upstream recommends this default:
		--release=fast
	)

	zig_src_configure
}

src_install() {
	zig_src_install

	doman ncdu.1
}
