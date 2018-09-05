# Maintainer: Manuel Domínguez López <mdomlop at gmail dot com>

_pkgver_year=2018
_pkgver_month=03
_pkgver_day=30

pkgname=retrosmart-qtcurve-theme
pkgver=1.0b
pkgrel=1
pkgdesc="Retrosmart theme for QtCurve."
url="https://github.com/mdomlop/$pkgname.git"
source=()
license=('GPL3')
optdepends=('retrosmart-icon-theme: The corresponding icon theme'
            'retrosmart-gtk-themes: The corresponding GTK themes'
            'retrosmart-openbox-themes: The corresponding Openbox themes'
            'retrosmart-wallpapers: The corresponding backgrounds project'
            'retrosmart-x11-cursors: The corresponding X11 cursor theme'
            'retrosmart-xfwm4-themes: The corresponding XFwm4 themes')
arch=('any')
group=('retrosmart')


build() {
    cd "$startdir"
    make
    }

package() {
    cd "$startdir"
    make install PREFIX=${pkgdir}/usr
}
