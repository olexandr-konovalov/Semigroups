files_to_delete := ["testbugfix/2021-04-13-TryMaximals.tst"];
for f in files_to_delete do
  f := Filename(DirectoriesLibrary("tst"), f);
  if f <> fail then
    Exec(Concatenation("rm -f ", f));
  fi;
od;
Read(Filename(DirectoriesLibrary("tst"), "testbugfix.g"));
