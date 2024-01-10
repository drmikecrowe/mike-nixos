[
  {
    key = "ctrl+d";
    command = "compareSelected";
  }
  {
    key = "shift+alt+f";
    command = "editor.action.formatDocument";
    when = "editorTextFocus && !editorReadonly";
  }
  {
    key = "ctrl+shift+i";
    command = "-editor.action.formatDocument";
    when = "editorTextFocus && !editorReadonly";
  }
  {
    key = "ctrl+d";
    command = "-extension.vim_ctrl+d";
    when = "editorTextFocus && vim.active && !inDebugRepl";
  }
  {
    key = "ctrl+d";
    command = "-list.focusPageDown";
    when = "listFocus && !inputFocus";
  }
  {
    key = "ctrl+d";
    command = "-editor.action.addSelectionToNextFindMatch";
    when = "editorFocus";
  }
  {
    key = "ctrl+u ctrl+l";
    command = "editor.action.transformToLowercase";
  }
  {
    key = "ctrl+u ctrl+u";
    command = "editor.action.transformToUppercase";
  }
  {
    key = "alt+1";
    command = "vikyd.FoldLevel.level1";
  }
  {
    key = "alt+2";
    command = "vikyd.FoldLevel.level2";
  }
  {
    key = "alt+3";
    command = "vikyd.FoldLevel.level3";
  }
  {
    key = "alt+4";
    command = "vikyd.FoldLevel.level4";
  }
  {
    key = "alt+5";
    command = "vikyd.FoldLevel.level5";
  }
  {
    key = "alt+6";
    command = "vikyd.FoldLevel.level6";
  }
  {
    key = "alt+-";
    command = "editor.foldAll";
  }
  {
    key = "alt+=";
    command = "editor.unfoldAll";
  }
  {
    key = "ctrl+u ctrl+t";
    command = "editor.action.transformToTitlecase";
  }
  {
    key = "f2";
    command = "-abracadabra.renameSymbol";
    when = "editorTextFocus";
  }
  {
    key = "ctrl+r";
    command = "editor.action.rename";
    when = "editorHasRenameProvider && editorTextFocus && !editorReadonly";
  }
  {
    key = "f2";
    command = "-editor.action.rename";
    when = "editorHasRenameProvider && editorTextFocus && !editorReadonly";
  }
  {
    key = "alt+s";
    command = "workbench.action.files.saveWithoutFormatting";
  }
  {
    key = "ctrl+c";
    command = "workbench.action.terminal.copySelection";
    when = "terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected";
  }
  {
    key = "ctrl+v";
    command = "workbench.action.terminal.paste";
    when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
  }
  {
    key = "ctrl+k";
    command = "workbench.action.terminal.clear";
  }
  {
    key = "meta+c";
    args = {
      text = "\u0003";
    };
    command = "workbench.action.terminal.sendSequence";
  }
  {
    key = "ctrl+k";
    command = "-extension.vim_ctrl+k";
    when = "editorTextFocus && vim.active && vim.use<C-k> && !inDebugRepl";
  }
  {
    key = "ctrl+alt+r";
    command = "editor.action.startFindReplaceAction";
    when = "editorFocus || editorIsOpen";
  }
  {
    key = "ctrl+h";
    command = "-editor.action.startFindReplaceAction";
    when = "editorFocus || editorIsOpen";
  }
  {
    key = "ctrl+\\ down";
    command = "workbench.action.splitEditorOrthogonal";
  }
  {
    key = "ctrl+k ctrl+\\";
    command = "-workbench.action.splitEditorOrthogonal";
  }
  {
    key = "ctrl+\\ right";
    command = "workbench.action.splitEditor";
  }
  {
    key = "ctrl+\\";
    command = "-workbench.action.splitEditor";
  }
  {
    key = "ctrl+r";
    command = "renameFile";
    when = "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus";
  }
  {
    key = "f2";
    command = "-renameFile";
    when = "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus";
  }
  {
    key = "ctrl+r";
    command = "workbench.action.terminal.renameInstance";
    when = "terminalHasBeenCreated && terminalTabsFocus && terminalTabsSingularSelection || terminalProcessSupported && terminalTabsFocus && terminalTabsSingularSelection";
  }
  {
    key = "f2";
    command = "-workbench.action.terminal.renameInstance";
    when = "terminalHasBeenCreated && terminalTabsFocus && terminalTabsSingularSelection || terminalProcessSupported && terminalTabsFocus && terminalTabsSingularSelection";
  }
  {
    key = "ctrl+k s";
    command = "-workbench.action.files.saveWithoutFormatting";
  }
  {
    key = "ctrl+shift+x";
    command = "eslint.executeAutofix";
  }
]
