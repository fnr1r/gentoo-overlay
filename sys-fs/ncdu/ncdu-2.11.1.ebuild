# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NCurses Disk Usage"
HOMEPAGE="https://github.com/BratishkaErik/ncdu"

declare -g -r -A ZBS_DEPENDENCIES=(
	[translate_c-0.0.0-Q_BUWgpXBwDWbTJQO9Ul01ZN4NJ4CEqQ4ZX1vLrcy38W.tar.gz]='https://codeberg.org/vancluever/translate-c/archive/119c5d0551c4b025d7a5d6963cf4dd32f9151a4b.tar.gz'
	[aro-0.0.0-JSD1QrExOgBF8ySFOvEaZfP1LBTjgwg58Y7UHoGJ3nOd.tar.gz]='https://github.com/vancluever/arocc/archive/c32de628ac29c765f8794e86374810ae5fb5c115.tar.gz'
)

ZIG_SLOT="0.16"
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
