<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
    <!ENTITY tab     "&#9;" >
    <!ENTITY lf     "&#10;" >
    <!ENTITY cr     "&#13;" >
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd12d="http://www.12d.com/schema/xml12d-10.0">
  <xsl:output method="text"/>
  <xsl:include href="12d_common.xslt"/>
  
  <!-- field delimiter -->
  <!-- The default delimiter is a tab despite this being for a comma-separated values filename
       This is to ensure MS Excel can open the resulting file.
       MS Excel does not correctly read/interpret CSV files in Unicode.
       Changing to tab-delimited allows the file to be read in correctly by MS Excel -->
  <xsl:variable name="DELIM"><xsl:text>&tab;</xsl:text></xsl:variable>
  
  
  <!-- #### GENERIC REPORT SETTINGS #### -->
  <!-- Include project details in header
         1 = enabled, otherwise = disabled -->
  <xsl:variable name="PROJECT_DETAILS">1</xsl:variable>
  <!-- Include string summary details
         1 = enabled, otherwise = disabled -->
  <xsl:variable name="STRING_DETAILS">1</xsl:variable> 
  <!-- Include string name in table headings
         1 = enabled, non-1 = disabled -->
  <xsl:variable name="STRING_NAME_IN_HEADINGS">1</xsl:variable>
  
  
  <!-- #### TOGGLE SETOUT REPORTED #### -->
  <!-- HORIZONTAL IPS
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_HORIZONTAL_IPS">1</xsl:variable>
  <!-- HORIZONTAL SEGMENTS
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_HORIZONTAL_SEGS">1</xsl:variable> 
  <!-- HORIZONTAL POINTS 
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_HORIZONTAL_PTS">1</xsl:variable> 
  <!-- VERTICAL IPS 
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_VERTICAL_IPS">1</xsl:variable>    
  <!-- VERTICAL SEGMENTS 
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_VERTICAL_SEGS">1</xsl:variable>    
  <!-- VERTICAL POINTS 
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_VERTICAL_PTS">1</xsl:variable>    
  <!-- VERTICAL CRESTS & SAGS 
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_VERTICAL_HILO">1</xsl:variable>
  
  <!-- HORIZONTAL LABELS
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_HORIZONTAL_LABELS">1</xsl:variable>    
  <!-- VERTICAL LABELS
         1 = enabled , otherwise = disabled -->
  <xsl:variable name="OUTPUT_VERTICAL_LABELS">1</xsl:variable>
  
  
  <!-- #### STYLING OF REPORTS #### -->
  <!-- Uses UPPERCASE headings in the table output
         Otherwise, headings will be Proper case.
         0 = disabled, 1 = enabled -->
  <xsl:variable name="UPPER_CASE_HEADINGS">1</xsl:variable>
  <!-- Column headings above the tables will be produced
         0 = disabled, 1 = enabled -->
  <xsl:variable name="COLUMN_HEADINGS">1</xsl:variable>
  <!-- Include minor interval points
         0 = disabled, non-zero = enabled -->
  <xsl:variable name="MINOR_INTERVAL_PTS">1</xsl:variable>
  <!-- Include major interval points
         0 = disabled, non-zero = enabled -->
  <xsl:variable name="MAJOR_INTERVAL_PTS">1</xsl:variable>
  <!-- Include types for major and minor interval points
         If enabled, the type- MJ or MI- will be output.
         Otherwise, the type column will be blank.
         0 = disabled, non-zero = enabled -->
  <xsl:variable name="SHOW_TYPES">1</xsl:variable>
  <!-- Show IP index
         1 = enabled, non-1 = disabled -->
  <xsl:variable name="SHOW_IP_INDEX">1</xsl:variable>
  <!-- Show Description  -->
  <xsl:variable name="SHOW_DESCRIPTION">1</xsl:variable>
  <!-- Show Raw Chainage  -->
  <xsl:variable name="SHOW_RAW_CHAINAGE">1</xsl:variable>
  <!-- Show Chainage Equality  -->
  <xsl:variable name="SHOW_METRAGE">1</xsl:variable>
  
  
  <!-- Show Easting (HG)  -->
  <xsl:variable name="HG_SHOW_EASTING">1</xsl:variable>
  <!-- Show Northing (HG)  -->
  <xsl:variable name="HG_SHOW_NORTHING">1</xsl:variable>
  <!-- Show Height (HG)  -->
  <xsl:variable name="HG_SHOW_HEIGHT">1</xsl:variable>
  <!-- Show Bearing (HG)  -->
  <xsl:variable name="HG_SHOW_BEARING">1</xsl:variable>
  <!-- Show Radius and Spiral Length (HG)  -->
  <xsl:variable name="HG_SHOW_RADIUS_AND_SPIRAL_LENGTH">1</xsl:variable>
  <!-- Show Deflection Angle (HG)  -->
  <xsl:variable name="HG_SHOW_DEFLECTION_ANGLE">1</xsl:variable>
  <!-- Show Tangents for curves with transitions (4 columns) (HG)  -->
  <xsl:variable name="HG_SHOW_TRANSITION_CURVE_TANGENT">1</xsl:variable>
  <!-- Show Arc Length (HG)  -->
  <xsl:variable name="HG_SHOW_ARC_LENGTH">1</xsl:variable>
  
  
  <!-- Show Heights (VG)  -->
  <xsl:variable name="VG_SHOW_HEIGHT">1</xsl:variable>
  <!-- Show Radius (VG)  -->
  <xsl:variable name="VG_SHOW_RADIUS">1</xsl:variable>
  <!-- Show Grade (VG)  -->
  <xsl:variable name="VG_SHOW_GRADE">1</xsl:variable>
  <!-- Show Curve Length (VG)  -->
  <xsl:variable name="VG_SHOW_CURVE_LENGTH">1</xsl:variable>
  <!-- Show VC Type (VG)  -->
  <xsl:variable name="VG_SHOW_VC_TYPE">1</xsl:variable>
  <!-- Show K Value (VG) -->
  <xsl:variable name="VG_SHOW_K_VALUE">1</xsl:variable>
  
  <!-- Show Easting (VG)  -->
  <xsl:variable name="VG_SHOW_EASTING">1</xsl:variable>
  <!-- Show Northing (VG)  -->
  <xsl:variable name="VG_SHOW_NORTHING">1</xsl:variable>
  
  
  <!-- #### FORMATTING VARIABLES #### -->
  <!-- Formatting pattern for the format-number() function:
      0 = Digit
      # = Digit, zeros are not shown
      . = The position of the decimal point Example: ###.##
      , = The group separator for thousands. Example: ###,###.##
      % = Displays the number as a percentage. Example: ##%
      ; = Pattern separator. The first pattern will be used for positive numbers and the second for negative numbers
  -->
  
  <!-- Generic formatting for full precision 
         This is based on the default precision for each report template
         inside 12d being 8 -->
  <xsl:variable name="format_full">0.00000000</xsl:variable>
  <!-- Formatting pattern for chainages -->
  <xsl:variable name="format_chg">0.000</xsl:variable>
  <!-- Formatting pattern for coordinates -->
  <xsl:variable name="format_coord">0.000</xsl:variable>
  <!-- Formatting pattern for lengths -->
  <xsl:variable name="format_length">0.000</xsl:variable>
  <!-- Formatting pattern for radii -->
  <xsl:variable name="format_radius">0.000</xsl:variable>
  <!-- Formatting pattern for k-values -->
  <xsl:variable name="format_k">0.000</xsl:variable>
  <!-- Formatting pattern for grades/crossfalls in percent -->
  <xsl:variable name="format_grade_percent">0.00</xsl:variable>
  <!-- Formatting pattern for grades/crossfalls in 1 in X -->
  <xsl:variable name="format_grade_1inX">0.0</xsl:variable>
  <!-- Formatting pattern for grades/crossfalls as raw ratio (y/x) -->
  <xsl:variable name="format_grade_raw">0.000</xsl:variable>
  <!-- Decimal Format Definitions -->
  <!-- This currently simply shows non-numbers (NaN) as a blank.
         Othewise, the output would show NaN -->
  <xsl:decimal-format NaN=""/>      
  
  
  
  <xsl:template name="print_upper_or_lower">
  
    <xsl:param name="text"/>
    
    <xsl:choose>
        <xsl:when test="$UPPER_CASE_HEADINGS = 1">
      
        <xsl:variable name="upper" select="translate($text,'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:value-of select ="$upper"/>
        
      </xsl:when>
        <xsl:otherwise>
      
        <xsl:value-of select="$text"/>
        
      </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  
  
  <xsl:template name="print_value_w_perms">
  
    <xsl:param name="perms"/>
    <xsl:param name="value"/>
    
    <xsl:if test="$perms = 1">
      <xsl:call-template name="print_upper_or_lower">
        <xsl:with-param name="text" select="$value"/>
      </xsl:call-template>
      <xsl:value-of select="$DELIM"/>
    </xsl:if>
    
  </xsl:template>
  
  
  
  <xsl:template name="print_metrage">
  
    <xsl:param name="raw_chainage"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:if test="$SHOW_METRAGE = 1">
    
      <xsl:for-each select="$horizontal_labels/xsd12d:label"> 
      
        <xsl:variable name="curr_chainage" select="xsd12d:chainage"/>
        <xsl:variable name="offset"        select="xsd12d:offset"/>
        <xsl:variable name="k_post"        select="xsd12d:kpost"/>
        <xsl:variable name="next_chainage" select="following-sibling::chainage"/>
        
        <xsl:if test="($raw_chainage >= $curr_chainage and $next_chainage > $raw_chainage) or position()=last()">
          
          <xsl:variable name="k_post_offset" select="$raw_chainage - ($curr_chainage - $offset)"/>
          
          <xsl:choose>
            <xsl:when test="$k_post_offset >= 0">
              
              <xsl:value-of select="$k_post"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="$k_post_offset"/>
              <xsl:value-of select="$DELIM"/>
              
          </xsl:when>
          <xsl:otherwise>
        
            <xsl:value-of select="$raw_chainage"/>
            <xsl:value-of select="$DELIM"/>
        
          </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  
  
  
  <xsl:template name="print_table_heading">
  
    <xsl:param name="super_name"/>  
    <xsl:param name="table_name"/>
    
    <xsl:if test="$STRING_NAME_IN_HEADINGS = 1">
        <xsl:value-of select="$super_name"/>
        <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:call-template name="print_upper_or_lower">
      <xsl:with-param name="text" select="$table_name"/>
    </xsl:call-template>
    <xsl:text>&lf;</xsl:text>
    
  </xsl:template>
  
  
  
  <xsl:template name="print_a_detail">
  
    <xsl:param name="detail_name"/>  
    <xsl:param name="detail_info"/>
    
    <xsl:call-template name="print_upper_or_lower">
      <xsl:with-param name="text" select="$detail_name"/>
    </xsl:call-template>        
      <xsl:value-of select="$DELIM"/>
      <xsl:value-of select="$detail_info"/>
      <xsl:text>&lf;</xsl:text>
    
  </xsl:template>
  
  
  
  <xsl:template name="print_horizontal_segment_name">
    <xsl:param name="segment"/>
    <xsl:for-each select="$segment">
      <xsl:choose>
        <xsl:when test="local-name()= 'line' ">
          <xsl:text>Line</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'arc' ">
          <xsl:text>Arc</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'transition'">
          <xsl:choose>
            <xsl:when test="xsd12d:leading = 'true' "> 
              <xsl:text>Transition</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Transition</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>



  <xsl:template name="print_vertical_segment_name">
    <xsl:param name="segment"/>
    <xsl:for-each select="$segment">
      <xsl:choose>
        <xsl:when test="local-name() = 'grade'">
          <xsl:text>Line</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'parabola'">
          <xsl:text>Arc</xsl:text>
        </xsl:when>
        <xsl:when test="local-name() = 'circular'">
          <xsl:text>Transition</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
  
  
  <!-- Check if point is tangential - 6 decimals -->
  <xsl:template name="print_tangential">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:choose>
      <xsl:when test="round($prev/xsd12d:end/xsd12d:direction/xsd12d:radian*100000) = round($next/xsd12d:start/xsd12d:direction/xsd12d:radian*100000)">
        <xsl:text>Yes</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>No</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Check if point is continuous -->
  <xsl:template name="print_continuous">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:choose>
      <xsl:when test="$prev/xsd12d:end/xsd12d:grade = $next/xsd12d:start/xsd12d:grade">
        <xsl:text>Yes</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>No</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Start Horizontal Segment -->
  <xsl:template name="print_hstart">
  
    <xsl:param name="segment"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:call-template name="print_horizontal_segment_name">
      <xsl:with-param name="segment" select="$segment"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:chainage"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Metrage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$segment/xsd12d:start/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- XYZ Coords -->
    <xsl:if test="$HG_SHOW_EASTING = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:xcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_NORTHING = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:ycoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:zcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Bearing -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Bearing -->
    <xsl:if test="$HG_SHOW_BEARING = 1">
      <xsl:call-template name="angle_to_bearing">
          <xsl:with-param name="angle" select="$segment/xsd12d:start/xsd12d:direction"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    <xsl:if test="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:radius"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
  </xsl:template>
  
  <!-- Intermediate Horizontal Segment -->
  <xsl:template name="print_hcp">
  
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->    
    <xsl:call-template name="print_horizontal_segment_name">
      <xsl:with-param name="segment" select="$prev"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:call-template name="print_horizontal_segment_name">
      <xsl:with-param name="segment" select="$next"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:call-template name="print_tangential">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:chainage"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Metrage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$prev/xsd12d:end/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- XYZ Coords -->    
    <xsl:if test="$HG_SHOW_EASTING = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:xcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_NORTHING = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:ycoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:zcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Bearing -->
    <xsl:if test="$HG_SHOW_BEARING = 1">
      <xsl:call-template name="angle_to_bearing">
          <xsl:with-param name="angle" select="$prev/xsd12d:end/xsd12d:direction"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Bearing -->
    <xsl:if test="$HG_SHOW_BEARING = 1">
      <xsl:call-template name="angle_to_bearing">
          <xsl:with-param name="angle" select="$next/xsd12d:start/xsd12d:direction"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:if test="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:radius"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    <xsl:if test="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH = 1">
      <xsl:value-of select="$next/xsd12d:start/xsd12d:radius"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
  </xsl:template>

  <!-- End Horizontal Segment -->
  <xsl:template name="print_hend">
  
    <xsl:param name="segment"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->
    <xsl:call-template name="print_horizontal_segment_name">
      <xsl:with-param name="segment" select="$segment"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:chainage"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Metrage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$segment/xsd12d:end/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- XYZ Coords -->
    <xsl:if test="$HG_SHOW_EASTING = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:xcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_NORTHING = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:ycoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <xsl:if test="$HG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:zcoord"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Bearing -->
    <xsl:if test="$HG_SHOW_BEARING = 1">
      <xsl:call-template name="angle_to_bearing">
          <xsl:with-param name="angle" select="$segment/xsd12d:end/xsd12d:direction"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Bearing -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:if test="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:radius"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    <xsl:value-of select="$DELIM"/>
    
  </xsl:template>

  <!-- Start Vertical Segment -->
  <xsl:template name="print_vstart">
  
    <xsl:param name="segment"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:call-template name="print_vertical_segment_name">
      <xsl:with-param name="segment" select="$segment"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:chainage"/>
      <xsl:value-of select="$DELIM"/>
    </xsl:if>
    
    <!-- Meterage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$segment/xsd12d:start/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- Height -->
    <xsl:if test="$VG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$segment/xsd12d:start/xsd12d:height"/>
      <xsl:value-of select="$DELIM"/>
    </xsl:if>
    
    <!-- Approach Grade -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Grade -->
    <xsl:value-of select="$segment/xsd12d:start/xsd12d:grade * 100"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    
    <xsl:value-of select="$segment/xsd12d:radius"/>
    <xsl:value-of select="$DELIM"/>
    <!-- <xsl:text>&#xA;</xsl:text> -->
  </xsl:template>
  
  <!-- Intermediate Vertical Segment -->
  <xsl:template name="print_vcp">
  
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->
    <xsl:call-template name="print_vertical_segment_name">
      <xsl:with-param name="segment" select="$prev"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:call-template name="print_vertical_segment_name">
      <xsl:with-param name="segment" select="$next"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:call-template name="print_continuous">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:chainage"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Meterage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$prev/xsd12d:start/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- Height -->
    <xsl:if test="$VG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$prev/xsd12d:end/xsd12d:height"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Grade -->
    <xsl:value-of select="$prev/xsd12d:end/xsd12d:grade * 100"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Grade -->
    <xsl:value-of select="$next/xsd12d:start/xsd12d:grade * 100"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:value-of select="$prev/xsd12d:radius"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    <xsl:value-of select="$next/xsd12d:radius"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- <xsl:text>&#xA;</xsl:text> -->
  </xsl:template>
  
  <!-- End Vertical Segment -->
  <xsl:template name="print_vend">
  
    <xsl:param name="segment"/>
    <xsl:param name="horizontal_labels"/>
    
    <xsl:text>&lf;</xsl:text>
    
    <!--in seg-->
    <xsl:call-template name="print_vertical_segment_name">
      <xsl:with-param name="segment" select="$segment"/>
    </xsl:call-template>
    <xsl:value-of select="$DELIM"/>
    
    <!--out seg-->
    <xsl:value-of select="$DELIM"/>
    
    <!--tan-->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Chainage -->
    <xsl:if test="$SHOW_RAW_CHAINAGE = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:chainage"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Meterage -->
    <xsl:call-template name="print_metrage">
      <xsl:with-param name="raw_chainage"      select="$segment/xsd12d:end/xsd12d:chainage"/>
      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
    </xsl:call-template>
    
    <!-- Height -->
    <xsl:if test="$VG_SHOW_HEIGHT = 1">
      <xsl:value-of select="$segment/xsd12d:end/xsd12d:height"/>
    </xsl:if>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Grade -->
    <xsl:value-of select="$segment/xsd12d:end/xsd12d:grade * 100"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Grade -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- Approach Radius -->
    <xsl:value-of select="$segment/xsd12d:radius"/>
    <xsl:value-of select="$DELIM"/>
    
    <!-- Departure Radius -->
    <xsl:value-of select="$DELIM"/>
    
    <!-- <xsl:text>&#xA;</xsl:text> -->
  </xsl:template>




  <xsl:template match="/">
    <xsl:for-each select="xsd12d:xml12d">
    
      <xsl:text>12d Model&lf;</xsl:text>
      
      <xsl:if test="$PROJECT_DETAILS = 1">
      
        <xsl:call-template name="print_a_detail">
          <xsl:with-param name="detail_name">Project:</xsl:with-param>
          <xsl:with-param name="detail_info" select="xsd12d:meta_data/xsd12d:application/xsd12d:project_name"/>
        </xsl:call-template>
        
        <xsl:call-template name="print_a_detail">
          <xsl:with-param name="detail_name">Directory:</xsl:with-param>
          <xsl:with-param name="detail_info" select="xsd12d:meta_data/xsd12d:application/xsd12d:project_folder"/>
        </xsl:call-template>
        
        <xsl:call-template name="print_a_detail">
          <xsl:with-param name="detail_name">User:</xsl:with-param>
          <xsl:with-param name="detail_info" select="xsd12d:meta_data/xsd12d:application/xsd12d:user"/>
        </xsl:call-template>
        
        <xsl:call-template name="print_a_detail">
          <xsl:with-param name="detail_name">Created:</xsl:with-param>
          <xsl:with-param name="detail_info" select="xsd12d:meta_data/xsd12d:application/xsd12d:export_date"/>
        </xsl:call-template>
        
          <xsl:text>&lf;</xsl:text>
      </xsl:if>
      
      
    
      
      <xsl:call-template name="print_upper_or_lower">
        <xsl:with-param name="text">Super Alignment Reports&lf;&lf;</xsl:with-param>
      </xsl:call-template>
            
    
      <xsl:for-each select="xsd12d:report">
        <xsl:for-each select="xsd12d:super_alignments">
          <xsl:for-each select="xsd12d:super_alignment">
          
            <xsl:variable name="horizontal_labels" select="xsd12d:horizontal_labels"/>          
          
              <xsl:if test="$STRING_DETAILS = 1">
            
              <xsl:call-template name="print_upper_or_lower">
                <xsl:with-param name="text">Super Alignment&lf;</xsl:with-param>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Name:</xsl:with-param>
                <xsl:with-param name="detail_info" select="xsd12d:name"/>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Model:</xsl:with-param>
                <xsl:with-param name="detail_info" select="xsd12d:model"/>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Chainage:</xsl:with-param>
                <xsl:with-param name="detail_info" select="format-number(xsd12d:chainage, $format_chg)"/>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Length:</xsl:with-param>
                <xsl:with-param name="detail_info" select="format-number(xsd12d:length, $format_length)"/>
              </xsl:call-template>
                
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">3d length:</xsl:with-param>
                <xsl:with-param name="detail_info" select="format-number(xsd12d:length_3d, $format_length)"/>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Transition type:</xsl:with-param>
                <xsl:with-param name="detail_info" select="xsd12d:transition_type"/>
              </xsl:call-template>
              
              <xsl:call-template name="print_a_detail">
                <xsl:with-param name="detail_name">Closed:</xsl:with-param>
                <xsl:with-param name="detail_info" select="xsd12d:closed"/>
              </xsl:call-template>
              </xsl:if>
  
            <xsl:text>&lf;&lf;</xsl:text>

            <!-- ### HORIZONTAL IPS TABLE ### -->
            <xsl:if test="count(xsd12d:horizontal_ips) and $OUTPUT_HORIZONTAL_IPS = 1">
              
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Horizontal IPs</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value">IP index</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value">Easting</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value">Northing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value">Radius</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value">Leading</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value">Trailing</xsl:with-param> 
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
              </xsl:if>
                
              <!-- Values -->
              <xsl:for-each select="xsd12d:horizontal_ips/xsd12d:hip">
                  
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value" select="format-number(position(), '0')"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value" select="xsd12d:chainage"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_metrage">
                  <xsl:with-param name="raw_chainage"      select="xsd12d:chainage"/>
                  <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value" select="xsd12d:xcoord"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value" select="xsd12d:ycoord"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value" select="xsd12d:radius"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value" select="xsd12d:leading"/> 
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value" select="xsd12d:trailing"/> 
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>                
              </xsl:for-each> 
              
              <xsl:text>&lf;&lf;</xsl:text>
            </xsl:if>
            
            
            
            <!-- ### HORIZONTAL SEGMENTS TABLE ### -->
            <xsl:if test="count(xsd12d:horizontal_segments) and $OUTPUT_HORIZONTAL_SEGS = 1">
                          
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Horizontal Segments</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Approach Segment</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Departure Segment</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Tangential</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value">Easting</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value">Northing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_TRANSITION_CURVE_TANGENT"/>
                  <xsl:with-param name="value">Approach Bearing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_TRANSITION_CURVE_TANGENT"/>
                  <xsl:with-param name="value">Departure Bearing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_TRANSITION_CURVE_TANGENT"/>
                  <xsl:with-param name="value">Approach Radius</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_TRANSITION_CURVE_TANGENT"/>
                  <xsl:with-param name="value">Departure Radius</xsl:with-param>
                </xsl:call-template>
                
              </xsl:if>        

              <!-- Values -->
              <xsl:for-each select="xsd12d:horizontal_segments">
                  
                <xsl:choose>
                
                  <xsl:when test="xsd12d:closed = 'true'">
                    <xsl:for-each select="*">
                      <xsl:if test="position()!=last()">
                          <xsl:call-template name="print_hcp">
                            <xsl:with-param name="prev" select="."/>
                            <xsl:with-param name="next" select="following-sibling::*[1]"/>
                          <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                          </xsl:call-template>
                      </xsl:if>
                      <!--last row-->
                      <xsl:if test="position()=last()">
                        <xsl:call-template name="print_hcp">
                            <xsl:with-param name="prev" select="."/>
                            <xsl:with-param name="next" select="child::*[position()=1]"/>
                          <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                          </xsl:call-template>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:when>
                  
                  <xsl:otherwise>
                    <xsl:for-each select="*">
                      <!--first row-->
                      <xsl:if test="position()=1">
                        <xsl:call-template name="print_hstart">
                          <xsl:with-param name="segment" select="."/>    
                            <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>                          
                          </xsl:call-template>
                      </xsl:if>
                      <!--body-->
                      <xsl:if test="position()!=last()">
                          <xsl:call-template name="print_hcp">
                            <xsl:with-param name="prev" select="."/>
                            <xsl:with-param name="next" select="following-sibling::*[1]"/>
                          <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                          </xsl:call-template>
                      </xsl:if>
                      <!--last row-->
                       <xsl:if test="position()=last()">
                          <xsl:call-template name="print_hend">
                            <xsl:with-param name="segment" select="."/>
                          <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                          </xsl:call-template>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:otherwise>
                  
                </xsl:choose>    
              </xsl:for-each> 
              <xsl:text>&lf;&lf;&lf;</xsl:text>
            </xsl:if>
            
            
            
            <!-- ### HORIZONTAL POINTS TABLE ### -->
            <xsl:if test="count(xsd12d:horizontal_tps) and $OUTPUT_HORIZONTAL_PTS = 1">
            
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Horizontal Points</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value">Easting</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value">Northing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value">Length</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                  <xsl:with-param name="value">Radius</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
              </xsl:if>
                
                
              <!-- Values -->
              <xsl:for-each select="xsd12d:horizontal_tps/xsd12d:htp">
                <xsl:choose>
                    <xsl:when test="xsd12d:type = 'MI' and $MINOR_INTERVAL_PTS = 0" ></xsl:when>
                    <xsl:when test="xsd12d:type = 'MJ' and $MAJOR_INTERVAL_PTS = 0" ></xsl:when>
                    <xsl:otherwise>
                        
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                      <xsl:with-param name="value" select="xsd12d:type"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                      <xsl:with-param name="value" select="xsd12d:chainage"/>
                    </xsl:call-template>
                      
                    <xsl:call-template name="print_metrage">
                      <xsl:with-param name="raw_chainage"      select="xsd12d:chainage"/>
                      <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                      <xsl:with-param name="value" select="xsd12d:xcoord"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                      <xsl:with-param name="value" select="xsd12d:ycoord"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$HG_SHOW_HEIGHT"/>
                      <xsl:with-param name="value" select="xsd12d:zcoord"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                      <xsl:with-param name="value" select="xsd12d:length"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="print_value_w_perms">
                      <xsl:with-param name="perms" select="$HG_SHOW_RADIUS_AND_SPIRAL_LENGTH"/>
                      <xsl:with-param name="value" select="xsd12d:radius"/>
                    </xsl:call-template>
                    
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>&lf;</xsl:text>
              </xsl:for-each>
              <xsl:text>&lf;&lf;</xsl:text>
            </xsl:if>
            
            
            <!-- ### VERTICAL IPS TABLE ### -->
            <xsl:if test="count(xsd12d:vertical_ips) and $OUTPUT_VERTICAL_IPS = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Vertical IPs</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value">IP index</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_CURVE_LENGTH"/>
                  <xsl:with-param name="value">Curve length</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_K_VALUE"/>
                  <xsl:with-param name="value">K Value</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
                
                
                <!-- Values -->
                <xsl:for-each select="xsd12d:vertical_ips/xsd12d:vip">
                  <xsl:choose>
                      <xsl:when test="xsd12d:type = 'MI' and $MINOR_INTERVAL_PTS = 0" ></xsl:when>
                      <xsl:when test="xsd12d:type = 'MJ' and $MAJOR_INTERVAL_PTS = 0" ></xsl:when>
                      <xsl:otherwise>
                          
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                        <xsl:with-param name="value" select="xsd12d:type"/>
                      </xsl:call-template>    
                      
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                        <xsl:with-param name="value" select="format-number(position(), '0')"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                        <xsl:with-param name="value" select="xsd12d:chainage"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="print_metrage">
                        <xsl:with-param name="raw_chainage"      select="xsd12d:chainage"/>
                        <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                        <xsl:with-param name="value" select="xsd12d:height"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$VG_SHOW_CURVE_LENGTH"/>
                        <xsl:with-param name="value" select="xsd12d:length"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="print_value_w_perms">
                        <xsl:with-param name="perms" select="$VG_SHOW_K_VALUE"/>
                        <xsl:with-param name="value" select="xsd12d:kvalue"/>
                      </xsl:call-template>
                      
                      <xsl:text>&lf;</xsl:text>                                
                          
                      </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
                <xsl:text>&lf;&lf;</xsl:text>
              </xsl:if>
            </xsl:if>
            
            
            
            <!-- ### VERTICAL SEGMENTS TABLE ### -->
            <xsl:if test="count(xsd12d:vertical_segments) and $OUTPUT_VERTICAL_SEGS = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Vertical Segments</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Approach Segment</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Departure Segment</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Tangential</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_GRADE"/>
                  <xsl:with-param name="value">Approach Grade (%)</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_GRADE"/>
                  <xsl:with-param name="value">Departure Grade (%)</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_RADIUS"/>
                  <xsl:with-param name="value">Approach Radius</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_RADIUS"/>
                  <xsl:with-param name="value">Departure Radius</xsl:with-param>
                </xsl:call-template>
                
              </xsl:if>        

              <!-- Values -->
              <xsl:for-each select="xsd12d:vertical_segments">
                  
                  <xsl:choose>
                    <xsl:when test="xsd12d:closed = 'true'">
                        <xsl:for-each select="*">
                          <xsl:if test="position()!=last()">
                              <xsl:call-template name="print_vcp">
                                <xsl:with-param name="prev" select="."/>
                                <xsl:with-param name="next" select="following-sibling::*[1]"/>
                              </xsl:call-template>
                          </xsl:if>
                          <!--last row-->
                          <xsl:if test="position()=last()">
                              <xsl:call-template name="print_vcp">
                                <xsl:with-param name="prev" select="."/>
                                <xsl:with-param name="next" select="child::*[position()=1]"/>
                              </xsl:call-template>
                          </xsl:if>
                        </xsl:for-each>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:for-each select="*">
                          <!--first row-->
                          <xsl:if test="position()=1">
                              <xsl:call-template name="print_vstart">
                                  <xsl:with-param name="segment" select="."/>                                
                              </xsl:call-template>
                          </xsl:if>
                          <!--body-->
                          <xsl:if test="position()!=last()">
                              <xsl:call-template name="print_vcp">
                                <xsl:with-param name="prev" select="."/>
                                <xsl:with-param name="next" select="following-sibling::*[1]"/>
                              </xsl:call-template>
                          </xsl:if>
                          <!--last row-->
                          <xsl:if test="position()=last()">
                              <xsl:call-template name="print_vend">
                                  <xsl:with-param name="segment" select="."/>
                              </xsl:call-template>
                          </xsl:if>
                        </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:value-of select="$DELIM"/>
                <xsl:text>&lf;&lf;&lf;</xsl:text>                
              </xsl:for-each> 
              
            </xsl:if>    
            
            
            
            <!-- ### VERTICAL POINTS TABLE ### -->
            <xsl:if test="count(xsd12d:vertical_tps) and $OUTPUT_VERTICAL_PTS = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Vertical Points</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value">IP index</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_CURVE_LENGTH"/>
                  <xsl:with-param name="value">Curve length</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_K_VALUE"/>
                  <xsl:with-param name="value">K Value</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
                
                
                <!-- Values -->
                <xsl:for-each select="xsd12d:vertical_tps/xsd12d:vtp">
                    <xsl:choose>
                        <xsl:when test="xsd12d:type = 'MI' and $MINOR_INTERVAL_PTS = 0" ></xsl:when>
                        <xsl:when test="xsd12d:type = 'MJ' and $MAJOR_INTERVAL_PTS = 0" ></xsl:when>
                        <xsl:otherwise>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                            <xsl:with-param name="value" select="xsd12d:type"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                            <xsl:with-param name="value" select="format-number(position(), '0')"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                            <xsl:with-param name="value" select="xsd12d:chainage"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_metrage">
                            <xsl:with-param name="raw_chainage"      select="xsd12d:chainage"/>
                            <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                            <xsl:with-param name="value" select="xsd12d:height"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$VG_SHOW_CURVE_LENGTH"/>
                            <xsl:with-param name="value" select="xsd12d:length"/>
                          </xsl:call-template>
                          
                          <xsl:call-template name="print_value_w_perms">
                            <xsl:with-param name="perms" select="$VG_SHOW_K_VALUE"/>
                            <xsl:with-param name="value" select="xsd12d:kvalue"/>
                          </xsl:call-template>
                          
                          <xsl:text>&lf;</xsl:text>                                
                            
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:text>&lf;&lf;</xsl:text>
              </xsl:if>
            </xsl:if>
        
        
        
            <!-- ### VERTICAL CRESTS & SAGS TABLE ### -->
            <xsl:if test="count(xsd12d:vertical_crests_and_sags) and $OUTPUT_VERTICAL_HILO = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Vertical Crests and Sags</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value">IP index</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value">Height</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
              </xsl:if>
                
              <!-- Values -->
              <xsl:for-each select="xsd12d:vertical_crests_and_sags/*">
                  
                <xsl:if test="$SHOW_DESCRIPTION = 1">
                  <xsl:choose>
                      <xsl:when test="local-name() = 'crest'">
                      <xsl:text>Crest</xsl:text>
                    </xsl:when>
                      <xsl:otherwise>
                      <xsl:text>Sag</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
                <xsl:value-of select="$DELIM"/>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_IP_INDEX"/>
                  <xsl:with-param name="value" select="format-number(position(), '0')"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value" select="xsd12d:chainage"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_metrage">
                  <xsl:with-param name="raw_chainage"      select="xsd12d:chainage"/>
                  <xsl:with-param name="horizontal_labels" select="$horizontal_labels"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_HEIGHT"/>
                  <xsl:with-param name="value" select="xsd12d:height"/>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>                
              </xsl:for-each> 
              
              <xsl:text>&lf;&lf;</xsl:text>
                
            </xsl:if>
        
            
            
            <!-- ### HORIZONTAL LABELS TABLE ### -->
            <xsl:if test="count(xsd12d:horizontal_labels) and $OUTPUT_HORIZONTAL_LABELS = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Horizontal labels</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value">Easting</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value">Northing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
              </xsl:if>
                
              <!-- Values -->
              <xsl:for-each select="xsd12d:horizontal_labels/xsd12d:label">
                  
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value" select="xsd12d:type"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value" select="xsd12d:chainage"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value" select="xsd12d:metrage"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_EASTING"/>
                  <xsl:with-param name="value" select="xsd12d:x"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$HG_SHOW_NORTHING"/>
                  <xsl:with-param name="value" select="xsd12d:y"/>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>                
              </xsl:for-each> 
              
              <xsl:text>&lf;&lf;</xsl:text>
            </xsl:if>
            
            
            
            <!-- ### VERTICAL LABELS TABLE ### -->
            <xsl:if test="count(xsd12d:vertical_labels) and $OUTPUT_VERTICAL_LABELS = 1">
                
              <xsl:call-template name="print_table_heading">
                <xsl:with-param name="super_name" select="xsd12d:name"/>  
                <xsl:with-param name="table_name">Vertical labels</xsl:with-param>
              </xsl:call-template>
              
              <xsl:if test="$COLUMN_HEADINGS = 1">
              
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value">Description</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value">Raw chainage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value">Metrage</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_EASTING"/>
                  <xsl:with-param name="value">Easting</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_NORTHING"/>
                  <xsl:with-param name="value">Northing</xsl:with-param>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>
                
              </xsl:if>
                
              <!-- Values -->
              <xsl:for-each select="xsd12d:vertical_labels/xsd12d:label">
                  
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_DESCRIPTION"/>
                  <xsl:with-param name="value" select="xsd12d:type"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_RAW_CHAINAGE"/>
                  <xsl:with-param name="value" select="xsd12d:chainage"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$SHOW_METRAGE"/>
                  <xsl:with-param name="value" select="xsd12d:metrage"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_EASTING"/>
                  <xsl:with-param name="value" select="xsd12d:x"/>
                </xsl:call-template>
                
                <xsl:call-template name="print_value_w_perms">
                  <xsl:with-param name="perms" select="$VG_SHOW_NORTHING"/>
                  <xsl:with-param name="value" select="xsd12d:y"/>
                </xsl:call-template>
                
                <xsl:text>&lf;</xsl:text>                
              </xsl:for-each> 
              
              <xsl:text>&lf;</xsl:text>
            </xsl:if> 
          </xsl:for-each>
        </xsl:for-each>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
