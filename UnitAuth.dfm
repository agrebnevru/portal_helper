object FormAuth: TFormAuth
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 346
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelLogo: TLabel
    Left = 10
    Top = 8
    Width = 164
    Height = 36
    Caption = 'PortalHelper'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditLogin: TEdit
    Left = 32
    Top = 50
    Width = 121
    Height = 21
    TabOrder = 0
    OnKeyDown = EditLoginKeyDown
  end
  object EditPassword: TEdit
    Left = 32
    Top = 77
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = EditPasswordKeyDown
  end
  object ButtonAuth: TButton
    Left = 32
    Top = 104
    Width = 121
    Height = 25
    Caption = #1040#1074#1090#1086#1088#1080#1079#1086#1074#1072#1090#1100#1089#1103
    TabOrder = 2
    OnClick = ButtonAuthClick
  end
end