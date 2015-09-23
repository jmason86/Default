



Pro Plot::Reanimate
  Compile_Opt IDL2
  oAll = Obj_Valid(/Cast)
  AllScenes = Where(Obj_IsA(oAll, 'IDLitGrScene'))
  RestoredScene = oAll[AllScenes[-1]]
  W = Window(/No_Toolbar)
  oAll = Obj_Valid(/Cast)
  GrW = Where(Obj_IsA(oAll, 'IDLgrWindow'))
  oAll[GrW[-1]]->IDLgrWindow::SetProperty, Graphics_Tree = RestoredScene
  W.Refresh
End

Pro ServerCallback, ID, H
  Compile_Opt IDL2
  If (File_Poll_Input(H['lun'], Timeout = .01)) then Begin
    NBytes = 0L
    ReadU, H['lun'], NBytes
    Buffer = BytArr(NBytes)
    ReadU, H['lun'], Buffer, Transfer_Count = TC
    T = TC
    While (T ne NBytes) Do Begin
      B = BytArr(NBytes - T)
      ReadU, H['lun'], B, Transfer_Count = TC
      If (TC ne 0) then Begin
        Buffer[T] = B[0:TC - 1]
        T += TC
      EndIf
    EndWhile
    P = jp_Serializer.Deserialize(String(Buffer), $
      TypeCode = 11)
    P.Reanimate
  EndIf
  !null = Timer.Set(.01, 'ServerCallback', H)
End

Pro PlotClient, Server = Server
  Compile_Opt IDL2
  Port = (UInt(Byte('IDLRocks'), 0, 2))[1]
  Socket, ServerLUN, Server eq !null ? 'localhost' : Server, Port, /Get_LUN, $
    Connect_Timeout = 10., $
    Read_Timeout = 10., Write_Timeout = 10., /RawIO, $
    /Swap_If_Big_Endian
  !null = Timer.Set (.001, 'ServerCallback', $
    Hash('lun', ServerLUN))
End