object FormAddTask: TFormAddTask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FormAddTask'
  ClientHeight = 208
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelAllAdd: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 208
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object PanelButtons: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 172
      Width = 505
      Height = 25
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      object BtnOk: TBitBtn
        AlignWithMargins = True
        Left = 345
        Top = 0
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        Caption = #1054#1082
        TabOrder = 0
        OnClick = BtnOkClick
      end
      object BtnCancel: TBitBtn
        AlignWithMargins = True
        Left = 260
        Top = 0
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 1
        OnClick = BtnCancelClick
      end
      object BtnOkPlus: TBitBtn
        AlignWithMargins = True
        Left = 430
        Top = 0
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = #1054#1082' +'
        TabOrder = 2
        OnClick = BtnOkPlusClick
      end
    end
    object PanelData: TPanel
      Left = 1
      Top = 1
      Width = 525
      Height = 140
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object MemoTaskDescription: TMemo
        AlignWithMargins = True
        Left = 10
        Top = 41
        Width = 505
        Height = 89
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alClient
        TabOrder = 0
        OnKeyDown = MemoTaskDescriptionKeyDown
      end
      object EditTaskTitle: TEdit
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 505
        Height = 21
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnKeyDown = EditTaskTitleKeyDown
      end
    end
    object PanelWithComboBox: TPanel
      Left = 1
      Top = 141
      Width = 525
      Height = 31
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 2
      object CBProject: TComboBox
        AlignWithMargins = True
        Left = 10
        Top = 0
        Width = 228
        Height = 21
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alClient
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = #1085#1077' '#1074#1099#1073#1088#1072#1085#1086
        Items.Strings = (
          #1085#1077' '#1074#1099#1073#1088#1072#1085#1086)
      end
      object CMResponsible: TComboBox
        AlignWithMargins = True
        Left = 248
        Top = 0
        Width = 267
        Height = 21
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alRight
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = #1085#1077' '#1074#1099#1073#1088#1072#1085#1086
        Items.Strings = (
          #1085#1077' '#1074#1099#1073#1088#1072#1085#1086)
      end
    end
  end
end
