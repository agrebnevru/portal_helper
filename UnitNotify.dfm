object FormNotify: TFormNotify
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 1
  ClientHeight = 115
  ClientWidth = 391
  Color = clInactiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelDescription: TLabel
    Left = 8
    Top = 27
    Width = 372
    Height = 78
    AutoSize = False
    Caption = 
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla s' +
      'emper vitae elit eget mollis. Proin eleifend elit sed justo impe' +
      'rdiet placerat. Curabitur at pellentesque ante. Donec eu enim ri' +
      'sus. Mauris consectetur eros arcu, nec posuere ipsum fermentum s' +
      'it amet. Vivamus quis nunc ac odio interdum congue. Ut quam orci' +
      ', cursus id sem a, accumsan egestas felis. Aliquam eget urna vit' +
      'ae odio lacinia suscipit.'
    Transparent = True
    WordWrap = True
  end
  object LabelTitle: TLabel
    Left = 8
    Top = 8
    Width = 345
    Height = 13
    AutoSize = False
    Caption = 'Title'
    DragMode = dmAutomatic
  end
  object Image1: TImage
    Left = 367
    Top = 5
    Width = 16
    Height = 16
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001001010000001002000680400001600000028000000
      1000000020000000010020000000000040040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000070000000F000000190000001F0000002000000020
      000000200000002000000020000000200000001F0000001F0000002100000018
      00000004000000000000000D00000021000007500001268A00000C6900000042
      0000003F0000004000000040000000400000003D0000024C010240910000093C
      00000006000000000000000100000206000266A10204ADFF010277C20000012B
      0000000D0000000E0000000E0000000D0000000F0101316F0406A7DE00010B1C
      00000000000000000000000000000000131692941E22C5FF0204B2FF01024776
      0000000200000000000000000000000000000F31030599DD0C0E7B7E00000000
      000000000000000000000000000000000D0E29143B3EBDCB1316BDFF000092DC
      0001133200000000000000000000011F010271B8151ABDD60A0B2C1300000000
      00000000000000000000000000000000000000001F2160353B3FCBEB0B0EBBFF
      01015F9B00000010000000180000549A1114C3FF1518604B0000000000000000
      0000000000000000000000000000000000000000000000003134875D3539D1FF
      0103ACF600002570000041901115C3FF2B2EA28F000000000000000000000000
      00000000000000000000000000000000000000000000000000000000383A917F
      2A2DCBFF000197F50B0D91FF2E32AFC50C0D230F000000000000000000000000
      9F7F4D0700000000000000000000000000000000000000000000000005040F2B
      3236A0D52025C9FF0A0EA2FE0C0D305B00000000000000000000000000000000
      A890680B000000000000000000000000000000000000000801010E3800026DB2
      0C10B4FE4D52D4FF272CCEFF000073B50000062A000000010000000000000000
      A88854040000000000000000000000010000001101011B5703058ECE090EC3FF
      3A3ED8FF3A3C8D81444694822F34DCFF000172B2000000240000000200000000
      000000000000000000000003000007290304498A0409ABEE0B11C4FF4045DAFF
      45479F870000000000000000494C9862353AD8F5000378B00000072900000004
      00000000000000000000020E050983B9050AC3FF1017C4FF4C50DFFD4B4EA179
      06060C030000000000000000000000004E50A230363AC8C80C108CBC00000732
      0000000100000000000007043A3EBDA55459D9FF5F63DBEB484B955A00000000
      000000000000000000000000000000000000000018192C0C3F44BC911E229FB0
      080B5A1800000000000000004D4FA40C9092EB427D81E0290000000000000000
      00000000000000000000000000000000000000000000000032336A025459DA38
      2F35CD14FFFF0000800000008000000080010000E0E30000E0C30000F0070000
      F80F0000FC0E0000FC1E0000F0060000C003000080C1000080E0000083F00000
      C7F80000}
    OnClick = Image1Click
  end
  object TimerHideForm: TTimer
    Enabled = False
    Interval = 3500
    OnTimer = TimerHideFormTimer
    Left = 168
    Top = 48
  end
end