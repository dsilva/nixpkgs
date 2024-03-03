{ stdenv, lib, fetchurl, cmake }:

stdenv.mkDerivation rec {
  pname = "astyle";
  version = "3.4.12";

  src = fetchurl {
    url = "mirror://sourceforge/${pname}/${pname}-${version}.tar.bz2";
    hash = "sha256-B3RZsp9zhvJWnBQsaKW2YHaAsMvaAhAgn/6m/w9atg4=";
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Source code indenter, formatter, and beautifier for C, C++, C# and Java";
    homepage = "https://astyle.sourceforge.net/";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ carlossless ];
    platforms = platforms.unix;
  };
}
