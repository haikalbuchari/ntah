program LigaTani;
uses crt;
type
  Tim = record
    nama: string;
    main: integer;
    menang: integer;
    seri: integer;
    kalah: integer;
    golMasuk: integer;
    golKebobolan: integer;
    poin: integer;
  end;

var
  daftarTim: array[1..10] of Tim;
  nTim: integer;
  pilihan: integer;
  i, j: integer;
  home, away: integer;
  golHome, golAway: integer;
  tempTim: Tim;

procedure InisialisasiTim();
begin
  for i := 1 to nTim do
  begin
    daftarTim[i].main := 0;
    daftarTim[i].menang := 0;
    daftarTim[i].seri := 0;
    daftarTim[i].kalah := 0;
    daftarTim[i].golMasuk := 0;
    daftarTim[i].golKebobolan := 0;
    daftarTim[i].poin := 0;
  end;
end;

procedure InputTim();
begin
  for i := 1 to nTim do
  begin
    write('Masukkan nama tim ke-', i, ': ');
    readln(daftarTim[i].nama);
  end;
end;

procedure TampilDaftarTim();
begin
  writeln('Daftar Tim:');
  for i := 1 to nTim do
  begin
    writeln(i, '. ', daftarTim[i].nama);
  end;
end;

procedure InputPertandingan();
begin
clrscr;
  TampilDaftarTim();

  write('Pilih nomor tim home: ');
  readln(home);

  write('Pilih nomor tim away: ');
  readln(away);

  if (home = away) or (home < 1) or (away < 1) or (home > nTim) or (away > nTim) then
  begin
    writeln('Input tidak valid!');
    exit;
  end;

  write('Gol ', daftarTim[home].nama, ': ');
  readln(golHome);

  write('Gol ', daftarTim[away].nama, ': ');
  readln(golAway);

  daftarTim[home].main := daftarTim[home].main + 1;
  daftarTim[away].main := daftarTim[away].main + 1;

  daftarTim[home].golMasuk := daftarTim[home].golMasuk + golHome;
  daftarTim[home].golKebobolan := daftarTim[home].golKebobolan + golAway;

  daftarTim[away].golMasuk := daftarTim[away].golMasuk + golAway;
  daftarTim[away].golKebobolan := daftarTim[away].golKebobolan + golHome;

  if golHome > golAway then
  begin
    daftarTim[home].menang := daftarTim[home].menang + 1;
    daftarTim[away].kalah := daftarTim[away].kalah + 1;
    daftarTim[home].poin := daftarTim[home].poin + 3;
  end
  else if golAway > golHome then
  begin
    daftarTim[away].menang := daftarTim[away].menang + 1;
    daftarTim[home].kalah := daftarTim[home].kalah + 1;
    daftarTim[away].poin := daftarTim[away].poin + 3;
  end
  else
  begin
    daftarTim[home].seri := daftarTim[home].seri + 1;
    daftarTim[away].seri := daftarTim[away].seri + 1;
    daftarTim[home].poin := daftarTim[home].poin + 1;
    daftarTim[away].poin := daftarTim[away].poin + 1;
  end;

  writeln('Pertandingan berhasil dicatat!');
end;

function SelisihGol(idx: integer): integer;
begin
  SelisihGol := daftarTim[idx].golMasuk - daftarTim[idx].golKebobolan;
end;

procedure SortingKlasemen();
begin
  for i := 1 to nTim - 1 do
  begin
    for j := i + 1 to nTim do
    begin
      if daftarTim[i].poin < daftarTim[j].poin then
      begin
        tempTim := daftarTim[i];
        daftarTim[i] := daftarTim[j];
        daftarTim[j] := tempTim;
      end
      else if daftarTim[i].poin = daftarTim[j].poin then
      begin
        if SelisihGol(i) < SelisihGol(j) then
        begin
          tempTim := daftarTim[i];
          daftarTim[i] := daftarTim[j];
          daftarTim[j] := tempTim;
        end
        else if SelisihGol(i) = SelisihGol(j) then
        begin
          if daftarTim[i].golMasuk < daftarTim[j].golMasuk then
          begin
            tempTim := daftarTim[i];
            daftarTim[i] := daftarTim[j];
            daftarTim[j] := tempTim;
          end;
        end;
      end;
    end;
  end;
end;

procedure Tampilkan;
begin
    clrscr;
    writeln('KLASEMEN');
    writeln('No  Nama         M  Mn  S  K  GM  GK  SG  P');

    for i := 1 to nTim do
    begin
        write(i:2, '  ',
              daftarTim[i].nama:2, '  ',
              daftarTim[i].main:10, '  ',
              daftarTim[i].menang:2, '  ',
              daftarTim[i].seri:2, '  ',
              daftarTim[i].kalah:2, '  ',
              daftarTim[i].golMasuk:3, '  ',
              daftarTim[i].golKebobolan:3, '  ',
              (daftarTim[i].golMasuk - daftarTim[i].golKebobolan):3, '  ',
              daftarTim[i].poin:3);
        writeln;
    end;
end;

procedure Menu();
begin
clrscr;
  repeat
    writeln('=================== MENU ===================');
    writeln('1. Input Pertandingan');
    writeln('2. Tampilkan Klasemen');
    writeln('3. Kembali Ke Menu');
    writeln('Pilih: ');
    readln(pilihan);

    case pilihan of
      1: InputPertandingan();
      2: Tampilkan();
      3: Menu();
    else
      writeln('Pilihan tidak valid!');
    end;
  until pilihan = 3;
end;

begin
clrscr;
  write('Masukkan jumlah tim (max 10): ');
  readln(nTim);

  InisialisasiTim();
  InputTim();
  Menu();
end.
