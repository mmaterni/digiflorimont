<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE stylesheet [<!ENTITY nbsp  "&#160;" > ]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" indent="no" encoding="UTF-8"/>
<xsl:strip-space elements="*"/>

<!--
<xsl:template match="/">
  <div id="pannel_int_id" class="text_pannel ">
      <div id="notes_int_id" class="notes" />
       <xsl:apply-templates/>
  </div>
</xsl:template>
-->

<xsl:template match="/">
        <xsl:apply-templates select="//div"/>
  </xsl:template>


 <!--
<xsl:template match="*/text()">
    <xsl:variable name="xx" select="normalize-space()"/>
    <xsl:variable name="xx" select="lower-case($xx)" />
    <xsl:value-of select="$xx"/>
</xsl:template>

<xsl:template match="*/text()">
    <xsl:value-of select="normalize-space()"/>
</xsl:template>
  -->

<xsl:template match="*/text()">
    <xsl:variable name="xx" select="normalize-space()"/>
    <xsl:variable name="xx" select="lower-case($xx)" />
    <xsl:value-of select="$xx"/>
</xsl:template>

<xsl:template match="div">
    <xsl:variable name="type" select="@type"/>
    <xsl:variable name="ref" select="@ref"/>
    <div class="div_text" type="{$type}" ref="{$ref}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

    <xsl:template match="pb">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="n" select="@n"/>
    <xsl:variable name="n" select="concat('c.  ',$n)"/>
    <div class="pb" id="{$id}">
        <!--xsl:value-of select="$n" /-->
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cb">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="n" select="@n"/>
    <div class="cb" id="{$id}">
        <!-- <xsl:text>&nbsp;</xsl:text> -->
          <xsl:value-of select="$n" />
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="lg">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="n" select="substring-after($id,'lg')"/>
    <xsl:variable name="n" select="concat('[',$n,']')"/>
    <div class="lg" id="{$id}">
      <span class='lgnum'>
        <xsl:value-of select="$n" />
      </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="l">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="n" select="@n"/>
    <div class="l" id="{$id}" n="{$n}">
      <span class='lnum'>
        <xsl:value-of select="concat($n,'.') " />
      </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="pc">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="resp" select="@resp" />
    <xsl:variable name="resp" select="replace($resp,'#','')"/>
    <xsl:variable name="cls_pc">
       <xsl:choose>
        <xsl:when test="$resp='ed' ">pc_ed</xsl:when>
        <xsl:when test="$resp='1hd' ">pc_1hd</xsl:when>
        <xsl:when test="$resp='1hd-r' ">pc_1hd_r</xsl:when>
        <xsl:when test="$resp='2hd' ">pc_2hd</xsl:when>
        <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <xsl:variable name="txt" select="./text()"/>
    <!-- punti che comportano capitalize -->
    <xsl:variable name="upc">
       <xsl:choose>
          <xsl:when test="$txt='.' ">_upc</xsl:when>
          <xsl:when test="$txt='?' ">_upc</xsl:when>
          <xsl:when test="$txt='!' ">_upc</xsl:when>
          <xsl:otherwise></xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <xsl:variable name="cls_pc" select="concat($cls_pc,$upc,'_int')"/>
    <span class="{$cls_pc}" id="{$id}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="ptr[@type='int']">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="id" select="concat('x',$id)"/>
    <xsl:variable name="target" select="@target"/>
    <xsl:variable name="n" select="@n"/>
    <a href="#" class="ptr note" id="{$id}" target_note="{$target}" type="int" >
      <xsl:value-of select="$n" />
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="damage">
    <xsl:variable name="degree" select="@degree" />
    <xsl:variable name="cls" select="concat('damage_',$degree)"/>
    <div class="{$cls}" >
      <xsl:apply-templates/>
    </div>
  </xsl:template>

    <!--
        aggl degl / aggl encl elis
       ana; elis_int, encl_int,degl_int
    -->
  <xsl:template match="w">
      <xsl:variable name="id" select="@xml:id" />
      <xsl:variable name="id" select="concat('x',$id)"/>
      <xsl:variable name="ana" select="@ana" />
      <xsl:variable name="ana" select="replace($ana,'#','')"/>
      <xsl:variable name="anasb" select="substring-before($ana,' ')"/>
      <xsl:variable name="anasa" select="substring-after($ana,' ')"/>
     <xsl:variable name="ana">
        <xsl:choose>
           <xsl:when test="$anasb!=''">
                <xsl:value-of select="concat($anasb,'_int  ',$anasa,'_int')"/>
           </xsl:when>
           <xsl:when test="$ana!=''">
                <xsl:value-of select="concat($ana,'_int')"/>
           </xsl:when>
       </xsl:choose>
    </xsl:variable>

    <xsl:variable name="function" select="@function" />
    <xsl:variable name="cls_w" select="concat('w ',$ana,' ',$function)" />

     <xsl:variable name="type" select="@type" />
     <xsl:variable name="cls_w">
       <xsl:choose>
        <xsl:when test="$type='number-digit'">
            <xsl:value-of select="concat($cls_w,' ',$type,'_int')"/>
        </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$cls_w"/>
        </xsl:otherwise>
       </xsl:choose>
    </xsl:variable>

    <xsl:variable name="cls_w" select="normalize-space($cls_w)" />
    <div class="{$cls_w}" id="{$id}"  >
      <xsl:apply-templates/>
    </div>

  </xsl:template>


  <xsl:template match="gap">
    <span class="gap">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="unclear">
    <span class="unclear">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

<xsl:template match="supplied">
    <xsl:variable name="reason" select="@reason" />
    <xsl:variable name="cls1">
       <xsl:choose>
          <xsl:when test="$reason='evident-omission'">supplied_eo</xsl:when>
          <xsl:when test="$reason='damage'">supplied_d</xsl:when>
          <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <xsl:variable name="cert" select="@cert" />
    <xsl:variable name="cls2">
       <xsl:choose>
          <xsl:when test="$cert='yes' ">y</xsl:when>
          <xsl:when test="$cert='no' ">n</xsl:when>
          <xsl:otherwise></xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
     <xsl:variable name="cls" select="concat($cls1,$cls2,'_int')"/>
    <span class="{$cls}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="app">
    <span class="app_int">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="rdg">
    <xsl:variable name="varseq" select="@varSeq" />
      <xsl:choose>
        <xsl:when test="$varseq='3' ">
          <a href="#" class="rdg_{$varseq}">
            <xsl:apply-templates/>
          </a>
          </xsl:when>
        <xsl:otherwise>
          <span class="rdg_{$varseq}">
            <xsl:apply-templates/>
          </span>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="note">
    <span class="annotaz_int"  >
         <xsl:apply-templates/>
  </span>
  </xsl:template>

<xsl:template match="seg">
    <div class="seg_int">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!-- allegory surname nationality -->
  <xsl:template match="rs">
    <xsl:variable name="type" select="@type" />
    <xsl:variable name="cls" select="concat('rs_int_',$type)" />
    <span class="{$cls}">
        <xsl:apply-templates  />
    </span>
  </xsl:template>

  <xsl:template match="persName">
    <xsl:variable name="type" select="@type" />
    <div class="persname_int {$type}">
       <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="forename">
    <div class="forename">
       <xsl:apply-templates />
    </div>
  </xsl:template>
<!--
  <xsl:template match="surname">
    <div class="surname ">
       <xsl:apply-templates />
    </div>
  </xsl:template>
-->
  <xsl:template match="addName">
    <xsl:variable name="type" select="@type" />
    <div class="addname {$type}">
       <xsl:apply-templates />
    </div>
  </xsl:template>

<xsl:template match="geogName">
    <div class="geogname ">
       <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="placeName">
    <div class="placename ">
       <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="geogFeat">
    <div class="geogfeat ">
       <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="name">
    <div class="name">
       <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="hi">
    <xsl:variable name="rend" select="@rend" />
    <xsl:variable name="rend" select="replace($rend,'init-','')"/>
    <xsl:variable name="cls_hi">
       <xsl:choose>
          <xsl:when test="$rend='ill'">hi_ill_int</xsl:when>
          <xsl:when test="$rend='flour'">hi_flour_int</xsl:when>
          <xsl:when test="$rend='high'">hi_high_int</xsl:when>
          <xsl:otherwise>hi_int</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <span class="{$cls_hi}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="expan">
    <span class="abrev_int">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="ex">
    <span class="ex">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="del">
    <xsl:variable name="rend" select="@rend" />
    <xsl:variable name="hand" select="@hand" />
    <xsl:variable name="hand" select="replace($hand,'#','')"/>
    <xsl:variable name="cls_del" select="concat('del_int',$rend,$hand)" />
    <span class="{$cls_del}">
        <xsl:apply-templates/>
    </span>
   </xsl:template>

  <xsl:template match="add">
    <xsl:variable name="place" select="@place" />
    <xsl:variable name="cls_add" select="concat('add_int',$place)" />
    <span class="{$cls_add}">
        <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="subst">
<!--
    <span class="subst">
      <xsl:apply-templates/>
    </span>
  -->
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="choice">
    <!--
    <span class="choice">
      <xsl:apply-templates select="sic|corr"/>
    </span>
  -->
      <xsl:apply-templates select="sic|corr"/>
  </xsl:template>

  <xsl:template match="sic">
      <span class="sic_int">
          <xsl:value-of select="."/>
      </span>
  </xsl:template>

  <xsl:template match="c">
    <xsl:variable name="ana" select="@ana" />
    <xsl:variable name="ana" select="replace($ana,'#','')"/>
    <xsl:variable name="ch" select="./text()"/>
    <xsl:variable name="anach" select="concat($ana,$ch)"/>
    <xsl:variable name="char">
       <xsl:choose>
      <!--diacritici aggiunto un carattre in coda-->
        <xsl:when test="$anach='e-tone'">é</xsl:when>
        <xsl:when test="$anach='hiati'">ï</xsl:when>
        <xsl:when test="$anach='hiatu'">ü</xsl:when>
        <xsl:when test="$anach='hiate'">ë</xsl:when>
        <xsl:when test="$anach='tsc' ">ç</xsl:when>
        <xsl:when test="$anach='ced-diplç' ">c</xsl:when>
        <xsl:when test="$anach='diacr-desamba' ">à</xsl:when>
        <xsl:when test="$anach='diacr-desambo' ">ò</xsl:when>
        <xsl:when test="$anach='diacr-desambu' ">ù</xsl:when>
        <xsl:when test="$anach='diacr-desambi' ">ì</xsl:when>
        <xsl:when test="$anach='diacr-desambe' ">è</xsl:when>
        <xsl:when test="$anach='diacr-desambA' ">à</xsl:when>
        <xsl:when test="$anach='diacr-desambO' ">ò</xsl:when>
        <xsl:when test="$anach='diacr-desambU' ">ù</xsl:when>
        <xsl:when test="$anach='diacr-desambI' ">ì</xsl:when>
        <xsl:when test="$anach='diacr-desambE' ">è</xsl:when>
        <!--ramiste-->
        <xsl:when test="$anach='lram-vV' ">u</xsl:when>
        <xsl:when test="$anach='lram-vv' ">u</xsl:when>
        <xsl:when test="$anach='lram-vJ' ">i</xsl:when>
        <xsl:when test="$anach='lram-vj' ">i</xsl:when>
        <xsl:when test="$anach='lram-cV' ">v</xsl:when>
        <xsl:when test="$anach='lram-cJ' ">j</xsl:when>
        <xsl:when test="$anach='lram-cu'">v</xsl:when>
        <xsl:when test="$anach='lram-ci' ">j</xsl:when>
        <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
     <xsl:variable name="clazz">
       <xsl:choose>
      <!--diacritici-->
        <xsl:when test="$ana='diacr-desamb' ">diacr_int</xsl:when>
        <xsl:when test="$ana='e-ton' ">diacr_int</xsl:when>
        <xsl:when test="$ana='hiat'">diacr_int</xsl:when>
        <xsl:when test="$ana='ts' ">diacr_int</xsl:when>
        <xsl:when test="$ana='ced-dipl' ">diacr_int</xsl:when>
        <!--ramiste-->
        <xsl:when test="$ana='lram-v' ">ramis_int</xsl:when>
        <xsl:when test="$ana='lram-c' ">ramis_int</xsl:when>
        <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <span class="{$clazz}">
      <xsl:value-of select="$char"/>
    </span>
  </xsl:template>

  <xsl:template match="space">
    <xsl:variable name="type" select="@type" />
   <xsl:variable name="type" select="replace($type,'#','')"/>
    <xsl:if test="$type='reserved-line' ">
       <span class="reserved_line"> [ligne blanche réservée] </span>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

<xsl:template match="corr">
  <xsl:variable name="sic" select="preceding-sibling::sic[1]"/>
   <span class="corr">
     <xsl:value-of select="."/>
     <a href="#" class="corr">
        <span class="tooltiptext">
            <xsl:value-of select="$sic"/>
          </span>
     </a>
   </span>
  </xsl:template>

  <xsl:template match="span">
    <xsl:variable name="from" select="@from" />
    <xsl:choose>
          <xsl:when  test="$from != '' " >
              <xsl:variable name="to" select="@to"/>
             <xsl:variable name="to" select="concat('x',$to)"/>
              <xsl:variable name="type" select="@type"/>
             <xsl:variable name="from" select="concat('x',$from)"/>
            <span class="from_to" from="{$from}" to="{$to}" type="{$type}"/>
            <xsl:apply-templates/>
          </xsl:when>
        <xsl:otherwise>
          <span class="span">
            <xsl:apply-templates/>
          </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template match="teimed_note">
</xsl:template>
<!--
<xsl:template match= "text()[not(string-length(normalize-space()))]"/>
<xsl:template match= "text()[string-length(normalize-space()) > 0]">
  <xsl:value-of select="translate(.,'&#xA;&#xD;', '  ')"/>
</xsl:template>
-->
</xsl:stylesheet>
