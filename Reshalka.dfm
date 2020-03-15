object ReshalkaMainForm: TReshalkaMainForm
  Left = 370
  Top = 147
  Width = 698
  Height = 510
  Caption = 'MathNote ver. 0.7 beta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  DesignSize = (
    682
    454)
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 682
    Height = 454
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Serif'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    DesignSize = (
      682
      454)
    object EquationLabel: TLabel
      Left = 480
      Top = 427
      Width = 9
      Height = 20
      Anchors = [akRight, akBottom]
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 371
      Width = 94
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Alt+R : '#1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1074#1089#1105
    end
    object Label2: TLabel
      Left = 8
      Top = 383
      Width = 134
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Ctrl+L : '#1054#1073#1097#1077#1077' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077
    end
    object Label3: TLabel
      Left = 168
      Top = 379
      Width = 46
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Ctrl+F : '#39'>> '#39
    end
    object Label4: TLabel
      Left = 168
      Top = 393
      Width = 45
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Ctrl+E : '#39' := '#39
    end
    object ResultLabel: TLabel
      Left = 433
      Top = 8
      Width = 111
      Height = 19
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1085#1077#1095#1085#1099#1081' '#1090#1077#1082#1089#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 433
      Top = 147
      Width = 186
      Height = 19
      Anchors = [akRight, akBottom]
      Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1077' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 8
      Top = 396
      Width = 131
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Ctrl+W : '#1048#1089#1093#1086#1076#1085#1099#1081' <> '#1050#1086#1085#1077#1095#1085#1099#1081
    end
    object Label7: TLabel
      Left = 8
      Top = 408
      Width = 137
      Height = 11
      Anchors = [akLeft, akBottom]
      Caption = 'Ctrl+D : '#1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1085#1077#1095#1085#1099#1081' '#1090#1077#1082#1089#1090
    end
    object ProgressLabel: TLabel
      Left = 168
      Top = 427
      Width = 113
      Height = 15
      Caption = '- '#1057#1090#1088#1086#1082#1072' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' -'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object CalculateAllButton: TButton
      Left = 315
      Top = 382
      Width = 105
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1074#1089#1105'!'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = [fsItalic]
      ParentFont = False
      TabOrder = 1
      OnClick = CalculateAllButtonClick
    end
    object ListBoxVars: TListBox
      Left = 431
      Top = 174
      Width = 244
      Height = 245
      Anchors = [akRight, akBottom]
      ImeName = 'Russian'
      ItemHeight = 11
      Items.Strings = (
        'e=2.7'
        'pi=3.14159')
      TabOrder = 2
      OnClick = ListBoxVarsClick
    end
    object ButtonSetValue: TButton
      Left = 583
      Top = 423
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ButtonSetValueClick
    end
    object EditVarName: TEdit
      Left = 431
      Top = 427
      Width = 41
      Height = 19
      Anchors = [akRight, akBottom]
      ImeName = 'Russian'
      TabOrder = 3
    end
    object EditVarValue: TEdit
      Left = 495
      Top = 427
      Width = 73
      Height = 19
      Anchors = [akRight, akBottom]
      ImeName = 'Russian'
      TabOrder = 4
    end
    object MainMemo: TRichEdit
      Left = 0
      Top = 0
      Width = 424
      Height = 371
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      ImeName = 'Russian'
      Lines.Strings = (
        '//'#1044#1086#1073#1088#1086' '#1087#1086#1078#1072#1083#1086#1074#1072#1090#1100' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' MathNote ver. 0.7 beta !')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyPress = MainMemoKeyPress
    end
    object ProcProgress: TProgressBar
      Left = 8
      Top = 427
      Width = 150
      Height = 17
      Anchors = [akLeft, akBottom]
      TabOrder = 6
    end
    object SwapButton: TButton
      Left = 569
      Top = 8
      Width = 91
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1084#1077#1085#1103#1090#1100' '#1084#1077#1089#1090#1072#1084#1080
      TabOrder = 7
      OnClick = SwapButtonClick
    end
    object TempMemo: TRichEdit
      Left = 320
      Top = 424
      Width = 89
      Height = 17
      ImeName = 'Russian'
      Lines.Strings = (
        'TempMemo')
      TabOrder = 8
      Visible = False
    end
  end
  object ResultMemo: TRichEdit
    Left = 431
    Top = 32
    Width = 244
    Height = 100
    Anchors = [akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ImeName = 'Russian'
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object MainMenu1: TMainMenu
    Left = 184
    Top = 288
    object NFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object NCreate: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100
        ShortCut = 16462
        OnClick = NCreateClick
      end
      object NOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = NOpenClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object NSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = NSaveClick
      end
      object NSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = NSaveAsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object NExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 27
        OnClick = NExitClick
      end
    end
    object NEdit: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object NUndo: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        OnClick = NUndoClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object NCalcAll: TMenuItem
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1074#1089#1105
        ShortCut = 32850
        OnClick = CalculateAllButtonClick
      end
      object NCalc: TMenuItem
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
        ShortCut = 24658
        OnClick = NCalcClick
      end
      object NSyntax: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1089#1080#1085#1090#1072#1082#1089#1080#1089
        ShortCut = 16501
        OnClick = NSyntaxClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object NFont: TMenuItem
        Caption = #1064#1088#1080#1092#1090'...'
        ShortCut = 16464
        OnClick = NFontClick
      end
      object NSettings: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      end
    end
    object NInsert: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1082#1072
      object NIdent: TMenuItem
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1099
        object NFormula: TMenuItem
          Caption = #1060#1086#1088#1084#1091#1083#1072': '#39'>> '#39
          ShortCut = 16454
          OnClick = NFormulaClick
        end
        object NOneStr: TMenuItem
          Caption = #1057#1082#1088#1099#1090#1099#1081' '#1090#1077#1082#1089#1090': '#39'(..)'#39
          ShortCut = 16459
          OnClick = NOneStrClick
        end
        object NCase: TMenuItem
          Caption = #1053#1072#1095#1072#1083#1086' '#1086#1087'. '#1074#1099#1073#1086#1088#1072': '#39':> '#39
          ShortCut = 24764
          OnClick = NCaseClick
        end
        object NCaseEnd: TMenuItem
          Caption = #1050#1086#1085#1077#1094' '#1086#1087'.'#1074#1099#1073#1086#1088#1072': '#39' <:'#39
          ShortCut = 24766
          OnClick = NCaseEndClick
        end
        object NProc: TMenuItem
          Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072': '#39':: '#39
          ShortCut = 16570
          OnClick = NProcClick
        end
        object N7: TMenuItem
          Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074#1099#1073#1086#1088#1072
          ShortCut = 24762
          OnClick = N7Click
        end
      end
      object NOperators: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099
        object NEquals: TMenuItem
          Caption = #1055#1088#1080#1089#1074#1072#1080#1074#1072#1077#1090#1089#1103': '#39' := '#39
          ShortCut = 16453
          OnClick = NEqualsClick
        end
        object NZnachenie: TMenuItem
          Caption = #1047#1085#1072#1095#1077#1085#1080#1077': '#39'Znachenie( '#39
          ShortCut = 16466
          OnClick = NZnachenieClick
        end
        object NBegin: TMenuItem
          Caption = #1053#1072#1095#1072#1083#1086' '#1073#1083#1086#1082#1072': '#39'<( '#39
          ShortCut = 16572
          OnClick = NBeginClick
        end
        object NEnd: TMenuItem
          Caption = #1050#1086#1085#1077#1094' '#1073#1083#1086#1082#1072': '#39' )>'#39
          ShortCut = 16574
          OnClick = NEndClick
        end
      end
      object NFormulaIns: TMenuItem
        Caption = #1060#1086#1088#1084#1091#1083#1072
        Enabled = False
      end
    end
    object NHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N4: TMenuItem
        Caption = #1047#1076#1077#1089#1100' '#1073#1091#1076#1077#1090' '#1093#1077#1083#1087
      end
      object NAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
  object SaveMainDialog: TSaveDialog
    DefaultExt = '.rtf'
    Filter = #1058#1077#1082#1089#1090'|*.rtf|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 104
    Top = 288
  end
  object OpenMainDialog: TOpenDialog
    DefaultExt = '.rtf'
    Filter = #1058#1077#1082#1089#1090'|*.rtf|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 144
    Top = 288
  end
  object ChangeFontDialog: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    Left = 64
    Top = 288
  end
  object PopupMenu1: TPopupMenu
    Left = 25
    Top = 288
    object NCopyText: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
    end
    object NCutText: TMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
    end
    object NPasteText: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object NFontEd: TMenuItem
      Caption = #1064#1088#1080#1092#1090'...'
      OnClick = NFontEdClick
    end
  end
end
