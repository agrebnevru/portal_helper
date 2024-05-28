object FormMpStats: TFormMpStats
  Left = 0
  Top = 0
  Caption = 'Marketplace '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
  ClientHeight = 579
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MpStatsMainPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 889
    Height = 579
    ActivePage = MpStatsTabSheetAll
    Align = alClient
    TabOrder = 0
    object MpStatsTabSheetAll: TTabSheet
      Caption = #1042#1089#1077#1075#1086' '#1087#1072#1088#1090#1085#1077#1088#1086#1074
      object PanelAllMain: TPanel
        Left = 0
        Top = 58
        Width = 881
        Height = 493
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 794
        ExplicitHeight = 330
        object DBGridAll: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 875
          Height = 487
          Align = alClient
          DrawingStyle = gdsGradient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = MpStatsPopMenuAll
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATE_INFO'
              Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COUNT_PARTHNERS'
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Width = 75
              Visible = True
            end>
        end
      end
      object PanelAllFilter: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 875
        Height = 52
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 6
        ExplicitTop = 11
        object PanelAllFilterLeft: TPanel
          Left = 0
          Top = 0
          Width = 315
          Height = 52
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object DateTimePickerAllFrom: TDateTimePicker
            Left = 115
            Top = 0
            Width = 190
            Height = 21
            Date = 42005.756749780090000000
            Time = 42005.756749780090000000
            TabOrder = 0
          end
          object StaticTextALLDateFrom: TStaticText
            Left = 1
            Top = 4
            Width = 105
            Height = 17
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1086#1090':'
            TabOrder = 1
          end
          object StaticTextAllDateTo: TStaticText
            Left = 1
            Top = 34
            Width = 106
            Height = 17
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1086':'
            TabOrder = 2
          end
          object DateTimePickerAllTo: TDateTimePicker
            Left = 115
            Top = 30
            Width = 190
            Height = 21
            Date = 42370.756749780090000000
            Time = 42370.756749780090000000
            TabOrder = 3
          end
        end
        object PanelAllFilterRight: TPanel
          Left = 315
          Top = 0
          Width = 560
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object ButtonAllFilter: TButton
            AlignWithMargins = True
            Left = 6
            Top = 10
            Width = 75
            Height = 33
            Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
            Enabled = False
            TabOrder = 0
          end
          object ButtonAllGetData: TButton
            Left = 97
            Top = 10
            Width = 75
            Height = 33
            Caption = #1054#1073#1085#1086#1074#1080#1090#1100
            TabOrder = 1
          end
        end
      end
    end
    object MpStatsTabSheetParthnersList: TTabSheet
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1072#1088#1090#1085#1077#1088#1086#1074
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 28
      object PanelPLFilter: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 875
        Height = 52
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 6
        ExplicitTop = 11
        object PanelPLFilterLeft: TPanel
          Left = 0
          Top = 0
          Width = 315
          Height = 52
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object StaticTextPLParCode: TStaticText
            Left = 1
            Top = 4
            Width = 79
            Height = 17
            Caption = #1050#1086#1076' '#1087#1072#1088#1090#1085#1077#1088#1072':'
            TabOrder = 0
          end
          object StaticTextPLPartName: TStaticText
            Left = 1
            Top = 34
            Width = 81
            Height = 17
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
            TabOrder = 1
          end
          object EditPLParCode: TEdit
            Left = 115
            Top = 0
            Width = 190
            Height = 21
            TabOrder = 2
          end
          object EditPLParName: TEdit
            Left = 115
            Top = 30
            Width = 190
            Height = 21
            TabOrder = 3
          end
        end
        object Panel1: TPanel
          Left = 315
          Top = 0
          Width = 560
          Height = 52
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitLeft = 321
          object ButtonPLFilter: TButton
            AlignWithMargins = True
            Left = 6
            Top = 10
            Width = 75
            Height = 33
            Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
            TabOrder = 0
          end
          object ButtonPLGetData: TButton
            Left = 97
            Top = 10
            Width = 75
            Height = 33
            Caption = #1054#1073#1085#1086#1074#1080#1090#1100
            TabOrder = 1
          end
        end
      end
      object PanelPLMain: TPanel
        Left = 0
        Top = 58
        Width = 881
        Height = 493
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 794
        ExplicitHeight = 330
        object DBGridPL: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 875
          Height = 487
          Align = alClient
          DrawingStyle = gdsGradient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = MpStatsPopMenuPL
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'P_BITRIX_ID'
              Title.Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'P_CODE'
              Title.Caption = #1050#1086#1076' '#1087#1072#1088#1090#1085#1077#1088#1072
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'P_NAME'
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 350
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'P_SITE'
              Title.Caption = #1057#1072#1081#1090
              Width = 175
              Visible = True
            end>
        end
      end
    end
    object MpStatsTabSheetStats: TTabSheet
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      ImageIndex = 2
      object PageControlStats: TPageControl
        Left = 0
        Top = 0
        Width = 881
        Height = 551
        ActivePage = TSTopMP
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 794
        ExplicitHeight = 388
        object TSFullStats: TTabSheet
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
          ImageIndex = 2
          object DBGridFS: TDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 25
            Width = 867
            Height = 495
            Align = alClient
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
          end
          object PanelFSFilter: TPanel
            Left = 0
            Top = 0
            Width = 873
            Height = 22
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
          end
        end
        object TSAutoGet: TTabSheet
          Caption = #1040#1074#1090#1086#1089#1073#1086#1088
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object PCAutoGet: TPageControl
            Left = 0
            Top = 0
            Width = 873
            Height = 523
            ActivePage = TabSheetAutoGetModulesInfo
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 786
            ExplicitHeight = 360
            object TabSheetAutoGetPartnersInfo: TTabSheet
              Caption = #1055#1072#1088#1090#1085#1077#1088#1099
              TabVisible = False
            end
            object TabSheetAutoGetModulesInfo: TTabSheet
              Caption = #1052#1086#1076#1091#1083#1080
              ImageIndex = 1
              object DBGridAG: TDBGrid
                AlignWithMargins = True
                Left = 3
                Top = 20
                Width = 859
                Height = 472
                Align = alClient
                DrawingStyle = gdsGradient
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
                PopupMenu = MpStatsPopMenuAG
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'M_CODE'
                    Title.Caption = #1050#1086#1076' '#1084#1086#1076#1091#1083#1103
                    Width = 150
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'M_NAME'
                    Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
                    Width = 515
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'P_ID'
                    Title.Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072
                    Width = 75
                    Visible = True
                  end>
              end
              object PanelAGFilter: TPanel
                Left = 0
                Top = 0
                Width = 865
                Height = 17
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
              end
            end
          end
        end
        object TSTopMP: TTabSheet
          Caption = #1058#1086#1087'30 '#1084#1072#1088#1082#1077#1090#1087#1083#1077#1081#1089
          ImageIndex = 1
          object DBGridTopMP: TDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 20
            Width = 867
            Height = 500
            Align = alClient
            DrawingStyle = gdsGradient
            PopupMenu = MpStatsPopupMenuTopMP
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'P_ID'
                Title.Caption = 'ID '#1087#1072#1088#1090#1085#1077#1088#1072
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_CODE'
                Title.Caption = #1050#1086#1076' '#1084#1086#1076#1091#1083#1103
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_DATA_INFO'
                Title.Caption = #1044#1072#1090#1072' '#1089#1073#1086#1088#1072
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_NAME'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_FREE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_OLD_PRICE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_PRICE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_DATE'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_VERSION'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_INSTALL_COUNT'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_DEMO_LINK'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'M_TOP_PLACE'
                Visible = True
              end>
          end
          object PanelTopMPFilter: TPanel
            Left = 0
            Top = 0
            Width = 873
            Height = 17
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 552
    Top = 136
    object N1: TMenuItem
      Caption = #1052#1077#1085#1102
      object MIMpStatsActions: TMenuItem
        Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        object MIMpStatsActionsGetAll: TMenuItem
          Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1095#1080#1089#1083#1086' '#1087#1072#1088#1090#1085#1077#1088#1086#1074
        end
      end
    end
  end
  object MpStatsADOConn: TADOConnection
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 192
    Top = 136
  end
  object MpStatsDataSourceAll: TDataSource
    DataSet = MpStatsADOQueryAll
    Left = 40
    Top = 184
  end
  object MpStatsDataSourcePL: TDataSource
    DataSet = MpStatsADOQueryPL
    Left = 156
    Top = 186
  end
  object MpStatsDataSourceAG: TDataSource
    DataSet = MpStatsADOQueryAG
    Left = 276
    Top = 186
  end
  object MpStatsDataSourceTopMP: TDataSource
    DataSet = MpStatsADOQueryTopMP
    Left = 404
    Top = 186
  end
  object MpStatsADOQueryAll: TADOQuery
    Connection = MpStatsADOConn
    Parameters = <>
    Left = 40
    Top = 232
  end
  object MpStatsADOQueryPL: TADOQuery
    Connection = MpStatsADOConn
    Parameters = <>
    Left = 156
    Top = 234
  end
  object MpStatsADOQueryAG: TADOQuery
    Connection = MpStatsADOConn
    Parameters = <>
    Left = 276
    Top = 234
  end
  object MpStatsADOQueryTopMP: TADOQuery
    Connection = MpStatsADOConn
    Parameters = <>
    Left = 404
    Top = 234
  end
  object MpStatsPopMenuAll: TPopupMenu
    Left = 40
    Top = 280
    object PMAll_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 1
    end
  end
  object MpStatsPopMenuPL: TPopupMenu
    Left = 156
    Top = 282
    object PMPL_ShowModuleList: TMenuItem
      Caption = #1057#1087#1080#1089#1086#1082' '#1084#1086#1076#1091#1083#1077#1081
      ImageIndex = 4
    end
    object PMPL_MLInfoGetData: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1084#1086#1076#1091#1083#1080
      ImageIndex = 8
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object PMPL_ShowInfo: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      ImageIndex = 7
    end
    object PMPL_PLInfoGetData: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1091
      ImageIndex = 6
    end
    object PMPL_GoToSite: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1089#1072#1081#1090' '#1087#1072#1088#1090#1085#1077#1088#1072
      ImageIndex = 13
    end
    object PMPL_GoToPartnerCard: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1074' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1085#1072' '#1089#1072#1081#1090#1077' '#1041#1080#1090#1088#1080#1082#1089
      ImageIndex = 12
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object PMPL_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      ImageIndex = 1
    end
  end
  object MpStatsPopMenuAG: TPopupMenu
    Left = 276
    Top = 282
    object PMAG_ModuleInfo: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1084#1086#1076#1091#1083#1103
      ImageIndex = 7
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object PMAG_Refresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 6
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PMAG_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 1
    end
  end
  object MpStatsPopupMenuTopMP: TPopupMenu
    Left = 404
    Top = 282
  end
end
