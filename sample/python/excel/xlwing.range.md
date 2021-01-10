Help on Range in module xlwings.main object:

class Range(builtins.object)
 |  Range(cell1=None, cell2=None, **options)
 |  
 |  Returns a Range object that represents a cell or a range of cells.
 |  
 |  Arguments
 |  ---------
 |  cell1 : str or tuple or Range
 |      Name of the range in the upper-left corner in A1 notation or as index-tuple or as name or as xw.Range object. It
 |      can also specify a range using the range operator (a colon), .e.g. 'A1:B2'
 |  
 |  cell2 : str or tuple or Range, default None
 |      Name of the range in the lower-right corner in A1 notation or as index-tuple or as name or as xw.Range object.
 |  
 |  Examples
 |  --------
 |  
 |  Active Sheet:
 |  
 |  .. code-block:: python
 |  
 |      import xlwings as xw
 |      xw.Range('A1')
 |      xw.Range('A1:C3')
 |      xw.Range((1,1))
 |      xw.Range((1,1), (3,3))
 |      xw.Range('NamedRange')
 |      xw.Range(xw.Range('A1'), xw.Range('B2'))
 |  
 |  Specific Sheet:
 |  
 |  .. code-block:: python
 |  
 |      xw.books['MyBook.xlsx'].sheets[0].range('A1')
 |  
 |  Methods defined here:
 |  
 |  __call__(self, *args)
 |      Call self as a function.
 |  
 |  __eq__(self, other)
 |      Return self==value.
 |  
 |  __getitem__(self, key)
 |  
 |  __hash__(self)
 |      Return hash(self).
 |  
 |  __init__(self, cell1=None, cell2=None, **options)
 |      Initialize self.  See help(type(self)) for accurate signature.
 |  
 |  __iter__(self)
 |  
 |  __len__(self)
 |  
 |  __ne__(self, other)
 |      Return self!=value.
 |  
 |  __repr__(self)
 |      Return repr(self).
 |  
 |  add_hyperlink(self, address, text_to_display=None, screen_tip=None)
 |      Adds a hyperlink to the specified Range (single Cell)
 |      
 |      Arguments
 |      ---------
 |      address : str
 |          The address of the hyperlink.
 |      text_to_display : str, default None
 |          The text to be displayed for the hyperlink. Defaults to the hyperlink address.
 |      screen_tip: str, default None
 |          The screen tip to be displayed when the mouse pointer is paused over the hyperlink.
 |          Default is set to '<address> - Click once to follow. Click and hold to select this cell.'
 |      
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  autofit(self)
 |      Autofits the width and height of all cells in the range.
 |      
 |      * To autofit only the width of the columns use ``xw.Range('A1:B2').columns.autofit()``
 |      * To autofit only the height of the rows use ``xw.Range('A1:B2').rows.autofit()``
 |      
 |      .. versionchanged:: 0.9.0
 |  
 |  clear(self)
 |      Clears the content and the formatting of a Range.
 |  
 |  clear_contents(self)
 |      Clears the content of a Range but leaves the formatting.
 |  
 |  end(self, direction)
 |      Returns a Range object that represents the cell at the end of the region that contains the source range.
 |      Equivalent to pressing Ctrl+Up, Ctrl+down, Ctrl+left, or Ctrl+right.
 |      
 |      Parameters
 |      ----------
 |      direction : One of 'up', 'down', 'right', 'left'
 |      
 |      Examples
 |      --------
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> xw.Range('A1:B2').value = 1
 |      >>> xw.Range('A1').end('down')
 |      <Range [Book1]Sheet1!$A$2>
 |      >>> xw.Range('B2').end('right')
 |      <Range [Book1]Sheet1!$B$2>
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  expand(self, mode='table')
 |      Expands the range according to the mode provided. Ignores empty top-left cells (unlike ``Range.end()``).
 |      
 |      Parameters
 |      ----------
 |      mode : str, default 'table'
 |          One of ``'table'`` (=down and right), ``'down'``, ``'right'``.
 |      
 |      Returns
 |      -------
 |      Range
 |      
 |      Examples
 |      --------
 |      
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> xw.Range('A1').value = [[None, 1], [2, 3]]
 |      >>> xw.Range('A1').expand().address
 |      $A$1:$B$2
 |      >>> xw.Range('A1').expand('right').address
 |      $A$1:$B$1
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  get_address(self, row_absolute=True, column_absolute=True, include_sheetname=False, external=False)
 |      Returns the address of the range in the specified format. ``address`` can be used instead if none of the
 |      defaults need to be changed.
 |      
 |      Arguments
 |      ---------
 |      row_absolute : bool, default True
 |          Set to True to return the row part of the reference as an absolute reference.
 |      
 |      column_absolute : bool, default True
 |          Set to True to return the column part of the reference as an absolute reference.
 |      
 |      include_sheetname : bool, default False
 |          Set to True to include the Sheet name in the address. Ignored if external=True.
 |      
 |      external : bool, default False
 |          Set to True to return an external reference with workbook and worksheet name.
 |      
 |      Returns
 |      -------
 |      str
 |      
 |      Examples
 |      --------
 |      ::
 |      
 |          >>> import xlwings as xw
 |          >>> wb = xw.Book()
 |          >>> xw.Range((1,1)).get_address()
 |          '$A$1'
 |          >>> xw.Range((1,1)).get_address(False, False)
 |          'A1'
 |          >>> xw.Range((1,1), (3,3)).get_address(True, False, True)
 |          'Sheet1!A$1:C$3'
 |          >>> xw.Range((1,1), (3,3)).get_address(True, False, external=True)
 |          '[Book1]Sheet1!A$1:C$3'
 |      
 |      .. versionadded:: 0.2.3
 |  
 |  offset(self, row_offset=0, column_offset=0)
 |      Returns a Range object that represents a Range that's offset from the specified range.
 |      
 |      Returns
 |      -------
 |      Range object : Range
 |      
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  options(self, convert=None, **options)
 |      Allows you to set a converter and their options. Converters define how Excel Ranges and their values are
 |      being converted both during reading and writing operations. If no explicit converter is specified, the
 |      base converter is being applied, see :ref:`converters`.
 |      
 |      Arguments
 |      ---------
 |      ``convert`` : object, default None
 |          A converter, e.g. ``dict``, ``np.array``, ``pd.DataFrame``, ``pd.Series``, defaults to default converter
 |      
 |      Keyword Arguments
 |      -----------------
 |      ndim : int, default None
 |          number of dimensions
 |      
 |      numbers : type, default None
 |          type of numbers, e.g. ``int``
 |      
 |      dates : type, default None
 |          e.g. ``datetime.date`` defaults to ``datetime.datetime``
 |      
 |      empty : object, default None
 |          transformation of empty cells
 |      
 |      transpose : Boolean, default False
 |          transpose values
 |      
 |      expand : str, default None
 |          One of ``'table'``, ``'down'``, ``'right'``
 |      
 |       => For converter-specific options, see :ref:`converters`.
 |      
 |      Returns
 |      -------
 |      Range object
 |      
 |      
 |      .. versionadded:: 0.7.0
 |  
 |  resize(self, row_size=None, column_size=None)
 |      Resizes the specified Range
 |      
 |      Arguments
 |      ---------
 |      row_size: int > 0
 |          The number of rows in the new range (if None, the number of rows in the range is unchanged).
 |      column_size: int > 0
 |          The number of columns in the new range (if None, the number of columns in the range is unchanged).
 |      
 |      Returns
 |      -------
 |      Range object: Range
 |      
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  select(self)
 |      Selects the range. Select only works on the active book.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)
 |  
 |  address
 |      Returns a string value that represents the range reference. Use ``get_address()`` to be able to provide
 |      paramaters.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  api
 |      Returns the native object (``pywin32`` or ``appscript`` obj) of the engine being used.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  color
 |      Gets and sets the background color of the specified Range.
 |      
 |      To set the color, either use an RGB tuple ``(0, 0, 0)`` or a color constant.
 |      To remove the background, set the color to ``None``, see Examples.
 |      
 |      Returns
 |      -------
 |      RGB : tuple
 |      
 |      Examples
 |      --------
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> xw.Range('A1').color = (255,255,255)
 |      >>> xw.Range('A2').color
 |      (255, 255, 255)
 |      >>> xw.Range('A2').color = None
 |      >>> xw.Range('A2').color is None
 |      True
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  column
 |      Returns the number of the first column in the in the specified range. Read-only.
 |      
 |      Returns
 |      -------
 |      Integer
 |      
 |      
 |      .. versionadded:: 0.3.5
 |  
 |  column_width
 |      Gets or sets the width, in characters, of a Range.
 |      One unit of column width is equal to the width of one character in the Normal style.
 |      For proportional fonts, the width of the character 0 (zero) is used.
 |      
 |      If all columns in the Range have the same width, returns the width.
 |      If columns in the Range have different widths, returns None.
 |      
 |      column_width must be in the range:
 |      0 <= column_width <= 255
 |      
 |      Note: If the Range is outside the used range of the Worksheet, and columns in the Range have different widths,
 |      returns the width of the first column.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.4.0
 |  
 |  columns
 |      Returns a :class:`RangeColumns` object that represents the columns in the specified range.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  count
 |      Returns the number of cells.
 |  
 |  current_region
 |      This property returns a Range object representing a range bounded by (but not including) any
 |      combination of blank rows and blank columns or the edges of the worksheet. It corresponds to ``Ctrl-*`` on
 |      Windows and ``Shift-Ctrl-Space`` on Mac.
 |      
 |      Returns
 |      -------
 |      Range object
 |  
 |  formula
 |      Gets or sets the formula for the given Range.
 |  
 |  formula_array
 |      Gets or sets an  array formula for the given Range.
 |      
 |      .. versionadded:: 0.7.1
 |  
 |  height
 |      Returns the height, in points, of a Range. Read-only.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.4.0
 |  
 |  hyperlink
 |      Returns the hyperlink address of the specified Range (single Cell only)
 |      
 |      Examples
 |      --------
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> xw.Range('A1').value
 |      'www.xlwings.org'
 |      >>> xw.Range('A1').hyperlink
 |      'http://www.xlwings.org'
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  last_cell
 |      Returns the bottom right cell of the specified range. Read-only.
 |      
 |      Returns
 |      -------
 |      Range
 |      
 |      Example
 |      -------
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> rng = xw.Range('A1:E4')
 |      >>> rng.last_cell.row, rng.last_cell.column
 |      (4, 5)
 |      
 |      .. versionadded:: 0.3.5
 |  
 |  left
 |      Returns the distance, in points, from the left edge of column A to the left edge of the range. Read-only.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.6.0
 |  
 |  name
 |      Sets or gets the name of a Range.
 |      
 |      .. versionadded:: 0.4.0
 |  
 |  number_format
 |      Gets and sets the number_format of a Range.
 |      
 |      Examples
 |      --------
 |      >>> import xlwings as xw
 |      >>> wb = xw.Book()
 |      >>> xw.Range('A1').number_format
 |      'General'
 |      >>> xw.Range('A1:C3').number_format = '0.00%'
 |      >>> xw.Range('A1:C3').number_format
 |      '0.00%'
 |      
 |      .. versionadded:: 0.2.3
 |  
 |  raw_value
 |      Gets and sets the values directly as delivered from/accepted by the engine that is being used (``pywin32`` or ``appscript``)
 |      without going through any of xlwings' data cleaning/converting. This can be helpful if speed is an issue but naturally
 |      will be engine specific, i.e. might remove the cross-platform compatibility.
 |  
 |  row
 |      Returns the number of the first row in the specified range. Read-only.
 |      
 |      Returns
 |      -------
 |      Integer
 |      
 |      
 |      .. versionadded:: 0.3.5
 |  
 |  row_height
 |      Gets or sets the height, in points, of a Range.
 |      If all rows in the Range have the same height, returns the height.
 |      If rows in the Range have different heights, returns None.
 |      
 |      row_height must be in the range:
 |      0 <= row_height <= 409.5
 |      
 |      Note: If the Range is outside the used range of the Worksheet, and rows in the Range have different heights,
 |      returns the height of the first row.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.4.0
 |  
 |  rows
 |      Returns a :class:`RangeRows` object that represents the rows in the specified range.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  shape
 |      Tuple of Range dimensions.
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  sheet
 |      Returns the Sheet object to which the Range belongs.
 |      
 |      .. versionadded:: 0.9.0
 |  
 |  size
 |      Number of elements in the Range.
 |      
 |      .. versionadded:: 0.3.0
 |  
 |  top
 |      Returns the distance, in points, from the top edge of row 1 to the top edge of the range. Read-only.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.6.0
 |  
 |  value
 |      Gets and sets the values for the given Range.
 |      
 |      Returns
 |      -------
 |      object : returned object depends on the converter being used, see :meth:`xlwings.Range.options`
 |  
 |  width
 |      Returns the width, in points, of a Range. Read-only.
 |      
 |      Returns
 |      -------
 |      float
 |      
 |      
 |      .. versionadded:: 0.4.0
