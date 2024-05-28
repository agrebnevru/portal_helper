object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 166
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 367
    Height = 166
    ActivePage = TabMain
    Align = alClient
    TabOrder = 0
    object TabMain: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object LabelDomain: TLabel
        Left = 3
        Top = 94
        Width = 67
        Height = 13
        Caption = #1040#1076#1088#1077#1089' '#1089#1072#1081#1090#1072':'
      end
      object EditDomain: TEdit
        Left = 134
        Top = 91
        Width = 219
        Height = 21
        TabOrder = 0
        OnChange = EditDomainChange
      end
      object RGProtocol: TRadioGroup
        Left = 3
        Top = 23
        Width = 350
        Height = 62
        Caption = #1055#1088#1086#1090#1086#1082#1086#1083
        TabOrder = 1
        OnClick = RGProtocolClick
      end
      object CheckBoxAppAutoRun: TCheckBox
        Left = 3
        Top = 0
        Width = 350
        Height = 17
        Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' '#1087#1088#1080' '#1079#1072#1075#1088#1091#1079#1082#1077' Windows'
        TabOrder = 2
        OnClick = CheckBoxAppAutoRunClick
      end
      object CheckBoxShowLogForm: TCheckBox
        Left = 216
        Top = 118
        Width = 137
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1083#1086#1075'-'#1092#1086#1088#1084#1091
        TabOrder = 3
        OnClick = CheckBoxShowLogFormClick
      end
      object CBShowFastLinks: TCheckBox
        Left = 3
        Top = 120
        Width = 150
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1092#1072#1089#1090'-'#1089#1089#1099#1083#1082#1080
        TabOrder = 4
        OnClick = CBShowFastLinksClick
      end
    end
    object TabUpdate: TTabSheet
      Caption = #1040#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      ImageIndex = 1
      TabVisible = False
      object LabelTimeUpdate: TLabel
        Left = 3
        Top = 3
        Width = 125
        Height = 13
        Caption = #1042#1088#1077#1084#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' ('#1089#1077#1082'):'
      end
      object CBTimeUpdate: TComboBox
        Left = 134
        Top = 0
        Width = 219
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = '60'
        OnChange = CBTimeUpdateChange
        Items.Strings = (
          '60'
          '120'
          '180'
          '300'
          '600')
      end
      object GBWhatUpdate: TGroupBox
        Left = 3
        Top = 22
        Width = 350
        Height = 113
        Caption = #1063#1090#1086' '#1086#1073#1085#1086#1074#1083#1103#1090#1100
        TabOrder = 1
        object CBLenta: TCheckBox
          Left = 11
          Top = 16
          Width = 97
          Height = 17
          Caption = #1051#1077#1085#1090#1072
          TabOrder = 0
          OnClick = CBLentaClick
        end
        object CBSupport: TCheckBox
          Left = 11
          Top = 39
          Width = 97
          Height = 17
          Caption = #1058#1077#1093#1087#1086#1076#1076#1077#1088#1078#1082#1072
          TabOrder = 1
          OnClick = CBSupportClick
        end
        object CBSupportSlaHigh: TCheckBox
          Left = 131
          Top = 39
          Width = 97
          Height = 17
          Caption = #1058#1086#1083#1100#1082#1086' '#1074#1072#1078#1085#1099#1077
          Enabled = False
          TabOrder = 2
          OnClick = CBSupportSlaHighClick
        end
      end
    end
  end
end
