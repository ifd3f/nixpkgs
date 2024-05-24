{ lib
, rustPlatform
, fetchFromGitHub
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "caligula";
  version = "0.4.7";

  src = fetchFromGitHub {
    owner = "ifd3f";
    repo = "caligula";
    rev = "v${version}";
    hash = "";
  };

  cargoHash = "";

  buildInputs = lib.optionals stdenv.isDarwin (
    with darwin.apple_sdk.frameworks; [
      Cocoa
      IOKit
      Foundation
      DiskArbitration
    ]
  );

  RUSTFLAGS = "--cfg tracing_unstable";

  meta = with lib; {
    description = "A user-friendly, lightweight TUI for disk imaging";
    homepage = "https://github.com/ifd3f/caligula/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ifd3f sodiboo ];
    platforms = platforms.linux ++ platforms.darwin;
    mainProgram = "caligula";
  };
}
