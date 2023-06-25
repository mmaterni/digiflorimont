<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE stylesheet [<!ENTITY nbsp  "&#160;" > ]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="no" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
      <div id="_TEXT__dip_id" class="text_pannel tei_dip" >
        <xsl:apply-templates select="//div"/>
     </div>
  </xsl:template>

<xsl:template match="*/text()">
    <xsl:value-of select="normalize-space()"/>
</xsl:template>
<!--
<xsl:template match="*/text()[not(normalize-space())]" />
-->
<xsl:template match="div">
    <xsl:variable name="type" select="@type"/>
    <xsl:variable name="ref" select="@ref"/>
    <div class="div_text" type="{$type}" ref="{$ref}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <xsl:template match="pb">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="n" select="@n"/>
    <div class="pb" id="{$id}" n="{$n}">
<!--
        <xsl:value-of select="$n" />
-->
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cb">
     <xsl:variable name="pag" select="preceding::*[1]/@n" />
    <xsl:variable name="cls_cb">
       <xsl:choose>
        <xsl:when test="$pag!='' ">cb cbpb</xsl:when>
        <xsl:otherwise>cb</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
      <xsl:variable name="id" select="@xml:id"/>
      <xsl:variable name="n" select="@n"/>
      <xsl:variable name="n" select="concat($pag,$n)"/>
      <div class="{$cls_cb}" id="{$id}">
         <div class="cb_tt">
             <xsl:value-of select="$n" />
          </div>
        <xsl:apply-templates/>
      </div>
  </xsl:template>

  <xsl:template match="lg">
    <xsl:variable name="id" select="@xml:id"/>
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
    <span class="{$cls_pc}" id="{$id}">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

<!--
  <xsl:template match="ptr[@type='dipl']">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="target" select="@target"/>
    <xsl:variable name="n" select="@n"/>
    <a href="#" class="ptr note" id="{$id}" target_note="{$target}" type="dipl" >
      <xsl:value-of select="$n" />
      <xsl:apply-templates/>
    </a>
  </xsl:template>
-->
  <xsl:template match="damage">
    <xsl:variable name="degree" select="@degree" />
    <xsl:variable name="cls" select="concat('damage_',$degree)"/>
    <div class="{$cls}"   >
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="w">
    <xsl:variable name="id" select="@xml:id" />
    <!-- ana; elis, encl, degl -->
    <xsl:variable name="ana" select="@ana" />
    <xsl:variable name="ana" select="replace($ana,'#','')"/>
<!--
    <xsl:variable name="degree" select="ancestor::damage/@degree" />
    <xsl:variable name="damage">
        <xsl:if test="$degree!='' ">
            <xsl:value-of select="concat('damage_',$degree)"/>
        </xsl:if>
    </xsl:variable>
    <xsl:variable name="cls_w" select="concat('w',' ',$ana,' ',$damage)" />
-->
    <xsl:variable name="cls_w" select="concat('w',' ',$ana)" />
    <xsl:variable name="cls_w" select="normalize-space($cls_w)" />
    <div class="{$cls_w}" id="{$id}" >
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
     <xsl:variable name="cls" select="concat($cls1,$cls2)"/>
    <span class="{$cls}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="app">
    <span class="app">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="rdg">
    <xsl:variable name="varseq" select="@varSeq" />
      <xsl:choose>
        <xsl:when test="$varseq='2' ">
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
    <span class="annotaz"  >
      <a href="#" >
         <xsl:apply-templates/>
    </a>
  </span>
  </xsl:template>


  <xsl:template match="seg">
    <div class="seg">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!--
  <xsl:template match="rs">
    <xsl:variable name="type" select="@type" />
    <span class="rs {$type}">
        <xsl:apply-templates  />
    </span>
  </xsl:template>
-->

  <xsl:template match="hi">
    <xsl:variable name="rend" select="@rend" />
    <xsl:variable name="rend" select="replace($rend,'init-','')"/>
    <xsl:variable name="cls_hi">
       <xsl:choose>
          <xsl:when test="$rend='ill'">hi_ill</xsl:when>
          <xsl:when test="$rend='flour'">hi_flour</xsl:when>
          <xsl:when test="$rend='high'">hi_high</xsl:when>
          <xsl:otherwise>hi</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
      <span class="{$cls_hi}">
         <xsl:value-of select="."/>
      </span>
  </xsl:template>

  <xsl:template match="expan">
      <xsl:variable name="corresp" select="@corresp" />
      <xsl:variable name="corresp" select="replace($corresp,'#','')"/>
      <span class="abrev {$corresp}">
           <xsl:apply-templates/>
     </span>
  </xsl:template>

<!--
_TEXT_ parametro da sostituire con ven,par,tou,tro
-->
  <xsl:template match="ex">
    <xsl:variable name="corresp" select="ancestor::expan/@corresp" />
    <xsl:variable name="corresp" select="replace($corresp,'#','')"/>
    <span class="ex">
       <a class="ex_ref" href="#">
         <span class="ex_tooltip" >
              <img src="css/abr/_TEXT_/{$corresp}.jpg"/>
         </span>
         <xsl:apply-templates/>
      </a>
    </span>
  </xsl:template>

  <xsl:template match="del">
    <xsl:variable name="rend" select="@rend" />
    <xsl:variable name="hand" select="@hand" />
    <xsl:variable name="hand" select="replace($hand,'#','')"/>
    <xsl:variable name="cls_del" select="concat('del',$rend,$hand)" />
    <span class="{$cls_del}">
        <xsl:apply-templates/>
    </span>
   </xsl:template>

  <xsl:template match="add">
    <xsl:variable name="place" select="@place" />
    <xsl:variable name="cls_add" select="concat('add',$place)" />
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
      <xsl:apply-templates select="sic"/>
    </span>
  -->
      <xsl:apply-templates select="sic"/>
  </xsl:template>

  <xsl:template match="sic">
      <span class="sic">
          <!--
          <xsl:value-of select="."/>
          <span class="sic2">
              <xsl:value-of select="'(sic!)'"/>
          </span>
      -->
      <xsl:apply-templates />
      </span>
  </xsl:template>

  <xsl:template match="c">
    <xsl:variable name="ana" select="@ana" />
    <xsl:variable name="ana" select="replace($ana,'#','')"/>
    <xsl:variable name="ch" select="./text()"/>
    <xsl:variable name="anach" select="concat($ana,$ch)"/>
    <xsl:variable name="char">
       <xsl:choose>
      <!--diacritici aggiunto un carattere in codab al nome varibile-->
      <!--sostituzione carattere -->
        <xsl:when test="$anach='e-tone'">e</xsl:when>
        <xsl:when test="$anach='hiati'">i</xsl:when>
        <xsl:when test="$anach='hiatu'">u</xsl:when>
        <xsl:when test="$anach='hiate'">e</xsl:when>
        <xsl:when test="$anach='tsc' ">c</xsl:when>
        <xsl:when test="$anach='ced-diplç' ">ç</xsl:when>
        <xsl:when test="$anach='diacr-desamba' ">a</xsl:when>
        <xsl:when test="$anach='diacr-desambo' ">o</xsl:when>
        <xsl:when test="$anach='diacr-desambu' ">u</xsl:when>
        <xsl:when test="$anach='diacr-desambe' ">e</xsl:when>
        <xsl:when test="$anach='diacr-desambi' ">i</xsl:when>
        <xsl:when test="$anach='diacr-desambA' ">A</xsl:when>
        <xsl:when test="$anach='diacr-desambE' ">E</xsl:when>
        <xsl:when test="$anach='diacr-desambI' ">I</xsl:when>
        <xsl:when test="$anach='diacr-desambO' ">O</xsl:when>
        <xsl:when test="$anach='diacr-desambU' ">U</xsl:when>

        <xsl:when test="$anach='lram-vV' ">V</xsl:when>
        <xsl:when test="$anach='lram-vv' ">v</xsl:when>
        <xsl:when test="$anach='lram-vJ' ">J</xsl:when>
        <xsl:when test="$anach='lram-vj' ">j</xsl:when>
        <xsl:when test="$anach='lram-cV' ">V</xsl:when>
        <xsl:when test="$anach='lram-cJ' ">J</xsl:when>
        <xsl:when test="$anach='lram-cu'">u</xsl:when>
        <xsl:when test="$anach='lram-ci' ">i</xsl:when>
        <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <xsl:variable name="clazz">
       <xsl:choose>
      <!--diacritici-->
        <xsl:when test="$ana='diacr-desamb' ">diacr</xsl:when>
        <xsl:when test="$ana='e-ton' ">diacr</xsl:when>
        <xsl:when test="$ana='hiat'">diacr</xsl:when>
        <xsl:when test="$ana='ts' ">diacr</xsl:when>
        <xsl:when test="$ana='ced-dipl' ">diacr</xsl:when>
        <!--ramiste-->
        <xsl:when test="$ana='lram-v' ">ramis</xsl:when>
        <xsl:when test="$ana='lram-c' ">ramis</xsl:when>
        <xsl:otherwise>err</xsl:otherwise>
       </xsl:choose>
     </xsl:variable>
    <span class="{$clazz}">
      <xsl:value-of select="$char"/>
    </span>
  </xsl:template>

  <xsl:template match="space">
    <xsl:variable name="type" select="@type"/>
   <xsl:variable name="type" select="replace($type,'#','')"/>
    <xsl:variable name="sp">
         <xsl:choose>
            <xsl:when test="$type='degl'">&nbsp;</xsl:when>
            <xsl:when test="$type='reserved-initial'">&nbsp;&nbsp;</xsl:when>
            <xsl:when test="$type='reserved-line'">[ligne blanche réservée]</xsl:when>
            <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
     <xsl:variable name="cls">
         <xsl:choose>
            <xsl:when test="$type='reserved-line'">reserved_line</xsl:when>
            <xsl:otherwise>degl</xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
     <span class="{$cls}">
        <xsl:value-of select="$sp"/>
    </span>
  </xsl:template>

  <xsl:template match="span">
    <xsl:variable name="from" select="@from" />
    <xsl:choose>
          <xsl:when  test="$from != '' " >
              <xsl:variable name="to" select="@to"/>
              <xsl:variable name="type" select="@type"/>
             <span class="from_to" from="{$from}" to="{$to}" type="{$type}"/>
            <xsl:apply-templates/>
          </xsl:when>
        <xsl:otherwise>
          <span class="span_err">
              <xsl:apply-templates/>
          </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template match="teimed_note">
    <xsl:variable name="id" select="@xml:id"/>
    <div class="teimed_note" id="{$id}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

<!--
<xsl:template match= "text()[not(string-length(normalize-space()))]"/>
<xsl:template match= "text()[string-length(normalize-space()) > 0]">
  <xsl:value-of select="translate(.,'&#xA;&#xD;', '  ')"/>
</xsl:template>
-->
</xsl:stylesheet>
