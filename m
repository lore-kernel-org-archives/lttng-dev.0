From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Re: [Patch LTTng-ust] RFC: Syntax changes to add
 support of other CTF metadata
Date: Tue, 10 Dec 2013 10:17:50 -0500
Message-ID: <52A7309E.3050202__27616.5662835867$1386688730$gmane$org@versatic.net>
References: <1386274940-24174-1-git-send-email-gbastien+lttng@versatic.net>
	<OFF843DEBF.52AA8094-ONC2257C3C.003166EF-C2257C3C.00317EC1@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0690384898=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1VqP4K-0006Be-Oh
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 10:17:57 -0500
Received: from [132.207.72.43] (dyn43.dorsal.polymtl.ca [132.207.72.43])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id rBAFHok4007452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 10:17:51 -0500
In-Reply-To: <OFF843DEBF.52AA8094-ONC2257C3C.003166EF-C2257C3C.00317EC1@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0690384898==
Content-Type: multipart/alternative;
 boundary="------------000207030302090504030103"

This is a multi-part message in MIME format.
--------------000207030302090504030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id rBAFHok4007452

Thanks Amit,

I'll add support of those metadata one at a time, starting with the enum=20
and then going for the struct and the variant. As support is added, I'll=20
add to the documentation/examples and there will be a test application=20
in the code to showcase those fields. But for myself, I'll probably work=20
on the examples before implementing their support so I can share it on=20
this list for discussion beforehand.

Genevi=E8ve


On 12/09/2013 04:00 AM, Amit Margalit wrote:
> First, I'd like to say I am a proponent of this.
>
> I'd also love to see some example code using this.
>
> Thanks,
>
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
> To: lttng-dev@lists.lttng.org
> Date: 12/05/2013 10:23 PM
> Subject: [lttng-dev] [Patch LTTng-ust] RFC: Syntax changes to add=20
> support of  other CTF metadata
> -----------------------------------------------------------------------=
-
>
>
>
> The CTF spec defines metadata types enumerations, structures and varian=
ts
> that are not yet available for use in tracepoints in LTTng-ust. This
> proposes the syntax for how those types could be defined and used.
>
> For now, it won't be possible to define them inline in a tracepoint. Th=
ey
> will have to be named and defined outside the TRACEPOINT_EVENT macro an=
d
> used in the tracepoint definition. It will make it easier for a first
> implementation. Once that is done, it won't be too difficult to add inl=
ine
> support.
>
> Signed-off-by: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
> ---
> doc/man/lttng-ust.3 | 193=20
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 193 insertions(+)
>
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 7624e88..c8229f2 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -158,6 +158,39 @@ TRACEPOINT_EVENT(
>  */
> ctf_float(float, floatfield, floatarg)
> ctf_float(double, doublefield, doublearg)
> +
> +                  /*
> + * ctf_enum: a field using a previously defined named enumeration
> + * args: (provider, enum name, field name, argument expression)
> + * The enumeration itself and its values must have been defined
> + * previously with the TRACEPOINT_ENUM macro, described below.
> + */
> +                  ctf_enum(sample_component, enumeration_name,=20
> enumfield, enumarg)
> +
> +                  /*
> + * ctf_struct: a field using a previously defined struct
> + * args: (provider, struct name, field name, [argument expression]*)
> + * The structure must have been previously defined with the
> + * TRACEPOINT_STRUCT macro, described below.
> + *
> + * The [argument expression]* part must correspond to the arguments
> + * defined in the TP_ARGS of the struct.
> + */
> +                  ctf_struct(sample_component, structure_name,=20
> structfield, args...)
> +
> +                  /*
> + * ctf_variant: a field using a previously defined variant
> + * args: (provider, variant name, field name, enum field name,
> +              [argument expression]*)
> + *
> + * The [argument expression]* part must correspond to the arguments
> + * defined in the TP_ARGS of the variant.
> + *
> + * There must be a field in the same tracepoint named 'enumfield'
> + * defined with ctf_enum(...)
> + */
> +                  ctf_variant(sample_component, variant_name,=20
> variantfield,
> +                  enumfield, args...)
>                  )
> )
>
> @@ -165,6 +198,166 @@ There can be an arbitrary number of tracepoint=20
> providers within an
> application, but they must each have their own provider name. Duplicate
> provider names are not allowed.
>
> +The CTF specification also supports some named basic and compound=20
> types that
> +can be defined inside a tracepoint provider and used as fields in the
> +tracepoint. This shows how to specify them and what they can be used f=
or:
> +
> +The enumeration is a mapping between an integer and a string. It can=20
> be used
> +to have a more compact trace in cases where the possible values for a=20
> field are
> +limited:
> +
> +TRACEPOINT_ENUM(
> + /*
> +  * The provider name, as described in the TRACEPOINT_EVENT macro
> +  */
> + sample_component,
> +
> + /*
> +  * The name of this enumeration, that will be used when using this
> +  * metadata type in tracepoint fields
> +  */
> + enumeration_name,
> +
> + /*
> +  * Integer type by which this enumeration will be represented.
> +  * It can be: char, int, long or any variant on those
> +  */
> + type,
> +
> + /*
> +  * TP_ENUM_VALUES describe the values of this enumeration and what th=
ey
> +  * map to.
> +  */
> + TP_ENUM_VALUES(
> +                  /*
> + * Maps an integer with this string value. By default, enumerations
> + * start at 0 and increment 1 for each entry.
> + */
> +                  ctf_enum_value(string_value)
> +
> +                  /*
> + * Maps the string value to integers in the range 'start' to 'end'
> + * inclusively. If 'start' =3D=3D 'end', then the string is mapped to
> + * a specific value.
> + */
> +                  ctf_enum_range(start, end, string_value)
> + )
> +)
> +
> +A structure allows to groupe fields together. They can be reused by=20
> different
> +tracepoints:
> +
> +TRACEPOINT_STRUCT(
> + /*
> +  * The provider name, as described in the TRACEPOINT_EVENT macro
> +  */
> + sample_component,
> +
> + /*
> +  * The name of this structure, that will be used when using this
> +  * metadata type in tracepoint fields
> +  */
> + structure_name,
> +
> + /*
> +  * TP_ARGS macro contains the arguments passed for the structure
> +  * it is in the following format
> +  *       TP_ARGS(type1, name1, type2, name2, ... type10,
> + name10)
> +  * where there can be from zero to ten elements.
> +  * typeN is the datatype, such as int, struct or double **.
> +  * name is the variable name (in "int myInt" the name would be
> +  * myint)
> +  *       TP_ARGS() is valid to mean no arguments
> +  *       TP_ARGS(void) is valid too
> +  */
> + TP_ARGS(int, anint, int, netint, long *, values,
> + char *, text, size_t, textlen,
> + double, doublearg, float, floatarg),
> +
> + /*
> +  * TP_FIELDS describes how to write the fields of the structure.
> +  * You can put expressions in the "argument expression" area,
> +  * typically using the input arguments from TP_ARGS.
> +  *
> +  * See TP_FIELDS macro in TRACEPOINT_EVENT for complete description
> +  * of possible fields. A structure may not contain itself and there=20
> cannot
> +  * be a cycle.
> +  */
> + TP_FIELDS(...)
> +)
> +
> +A variant is a selection between different types, given a
> +'tag'. It is linked with the value of an enumeration.
> +
> +TRACEPOINT_VARIANT(
> + /*
> +  * The provider name, as described in the TRACEPOINT_EVENT macro
> +  */
> + sample_component,
> +
> + /*
> +  * The name of this variant, that will be used when using this
> +  * metadata type in tracepoint fields
> +  */
> + variant_name,
> +
> + /*
> +  * The name of the provider where the linked enumeration is defined
> +  */
> + enumeration_component,
> +
> + /*
> +  * The name of the enumeration, whose values will be linked to a fiel=
d
> +  * type
> +  */
> + enumeration_name,
> +
> + /*
> +  * TP_ARGS macro contains the arguments passed for the structure
> +  * it is in the following format
> +  *       TP_ARGS(type1, name1, type2, name2, ... type10,
> + name10)
> +  * where there can be from zero to ten elements.
> +  * typeN is the datatype, such as int, struct or double **.
> +  * name is the variable name (in "int myInt" the name would be
> +  * myint)
> +  *       TP_ARGS() is valid to mean no arguments
> +  *       TP_ARGS(void) is valid too
> +  */
> + TP_ARGS(int, anint, int, netint, long *, values,
> + char *, text, size_t, textlen,
> + double, doublearg, float, floatarg),
> +
> + /*
> +  * TP_VARIANTS will describe what field will be linked to what value =
of
> +  * the enumeration
> +  */
> + TP_VARIANTS(
> +                  /*
> + * TP_VARIANT describes one mapping from an enum value to a field
> + */
> +                  TP_VARIANT(
> + /*
> +  * The value of the enumeration field. This must correspond to one
> +  * of the string_values defined in TP_ENUM_VALUES of the linked
> +  * enumeration.
> +  */
> + enum_val,
> +
> + /*
> +  * This is the field that will be added to the tracepoint if the
> +  * value of the enum is enum_val.
> +  *
> +  * See TP_FIELDS macro in TRACEPOINT_EVENT for complete description
> +  * of possible fields. A variant may not contain itself and there can=
not
> +  * be a cycle.
> +  */
> + <tp_field_expr>
> +                  )
> + )
> +)
> +
> .fi
>
> .SH "ASSIGNING LOGLEVEL TO EVENTS"
> --=20
> 1.8.4.2
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


--------------000207030302090504030103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Thanks Amit,<br>
      <br>
      I'll add support of those metadata one at a time, starting with
      the enum and then going for the struct and the variant. As support
      is added, I'll add to the documentation/examples and there will be
      a test application in the code to showcase those fields. But for
      myself, I'll probably work on the examples before implementing
      their support so I can share it on this list for discussion
      beforehand.<br>
      <br>
      Genevi&egrave;ve<br>
      <br>
      <br>
      On 12/09/2013 04:00 AM, Amit Margalit wrote:<br>
    </div>
    <blockquote
cite="mid:OFF843DEBF.52AA8094-ONC2257C3C.003166EF-C2257C3C.00317EC1@il.ibm.com"
      type="cite"><font face="sans-serif" size="2">First, I'd like to
        say I am a proponent
        of this.</font>
      <br>
      <br>
      <font face="sans-serif" size="2">I'd also love to see some example
        code
        using this.</font>
      <br>
      <br>
      <font face="sans-serif" size="2">Thanks,</font>
      <br>
      <br>
      <font color="#000080" face="sans-serif" size="2">Amit Margalit</font>
      <br>
      <font color="#808000" face="sans-serif" size="2">IBM XIV </font><font
        face="sans-serif" size="2">-
        <i>Storage Reinvented</i></font>
      <br>
      <font face="sans-serif" size="2">XIV-NAS Development Team</font>
      <br>
      <font face="sans-serif" size="2">Tel. 03</font><font face="Arial"
        size="2">-689-7774</font>
      <br>
      <font face="Arial" size="2">Fax. 03-689-7230</font>
      <br>
      <br>
      <br>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">From: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1">Genevi&egrave;ve Bastien
        <a class="moz-txt-link-rfc2396E" href="mailto:gbastien+lttng@versatic.net">&lt;gbastien+lttng@versatic.net&gt;</a></font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">To: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1"><a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a></font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">Date: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1">12/05/2013 10:23 PM</font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">Subject: &nbsp; &nbsp;
        &nbsp; &nbsp;</font><font face="sans-serif" size="1">[lttng-dev]
        [Patch LTTng-ust] RFC: Syntax changes to add support of &nbsp; &nbsp; &nbsp;
        &nbsp;other CTF metadata</font>
      <br>
      <hr noshade="noshade">
      <br>
      <br>
      <br>
      <tt><font size="2">The CTF spec defines metadata types
          enumerations,
          structures and variants<br>
          that are not yet available for use in tracepoints in
          LTTng-ust. This<br>
          proposes the syntax for how those types could be defined and
          used.<br>
          <br>
          For now, it won't be possible to define them inline in a
          tracepoint. They<br>
          will have to be named and defined outside the TRACEPOINT_EVENT
          macro and<br>
          used in the tracepoint definition. It will make it easier for
          a first<br>
          implementation. Once that is done, it won't be too difficult
          to add inline<br>
          support.<br>
          <br>
          Signed-off-by: Genevi&egrave;ve Bastien
          <a class="moz-txt-link-rfc2396E" href="mailto:gbastien+lttng@versatic.net">&lt;gbastien+lttng@versatic.net&gt;</a><br>
          ---<br>
          doc/man/lttng-ust.3 | 193
          ++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
          1 file changed, 193 insertions(+)<br>
          <br>
          diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3<br>
          index 7624e88..c8229f2 100644<br>
          --- a/doc/man/lttng-ust.3<br>
          +++ b/doc/man/lttng-ust.3<br>
          @@ -158,6 +158,39 @@ TRACEPOINT_EVENT(<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          ctf_float(float, floatfield, floatarg)<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          ctf_float(double, doublefield, doublearg)<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * ctf_enum: a field using a previously defined named
          enumeration<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * args: (provider, enum name, field name, argument expression)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * The enumeration itself and its values must have been defined<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * previously with the TRACEPOINT_ENUM macro, described below.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_enum(sample_component,
          enumeration_name, enumfield, enumarg)<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * ctf_struct: a field using a previously defined struct<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * args: (provider, struct name, field name, [argument
          expression]*)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * The structure must have been previously defined with the<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * TRACEPOINT_STRUCT macro, described below.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          *<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * The [argument expression]* part must correspond to the
          arguments<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * defined in the TP_ARGS of the struct.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_struct(sample_component,
          structure_name, structfield, args...)<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * ctf_variant: a field using a previously defined variant<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * args: (provider, variant name, field name, enum field name,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[argument expression]*)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          *<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * The [argument expression]* part must correspond to the
          arguments<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * defined in the TP_ARGS of the variant.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          *<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * There must be a field in the same tracepoint named
          'enumfield'<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * defined with ctf_enum(...)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_variant(sample_component,
          variant_name, variantfield,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enumfield,
          args...)<br>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br>
          )<br>
          <br>
          @@ -165,6 +198,166 @@ There can be an arbitrary number of
          tracepoint providers
          within an<br>
          application, but they must each have their own provider name.
          Duplicate<br>
          provider names are not allowed.<br>
          <br>
          +The CTF specification also supports some named basic and
          compound types
          that<br>
          +can be defined inside a tracepoint provider and used as
          fields in the<br>
          +tracepoint. This shows how to specify them and what they can
          be used for:<br>
          +<br>
          +The enumeration is a mapping between an integer and a string.
          It can be
          used<br>
          +to have a more compact trace in cases where the possible
          values for a
          field are<br>
          +limited:<br>
          +<br>
          +TRACEPOINT_ENUM(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The provider name, as described in the TRACEPOINT_EVENT
          macro<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          sample_component,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The name of this enumeration, that will be used when using
          this<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* metadata type in tracepoint fields<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          enumeration_name,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* Integer type by which this enumeration will be represented.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* It can be: char, int, long or any variant on those<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          type,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* TP_ENUM_VALUES describe the values of this enumeration and
          what
          they<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* map to.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          TP_ENUM_VALUES(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * Maps an integer with this string value. By default,
          enumerations<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * start at 0 and increment 1 for each entry.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_enum_value(string_value)<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * Maps the string value to integers in the range 'start' to
          'end'<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * inclusively. If 'start' == 'end', then the string is mapped
          to<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * a specific value.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf_enum_range(start,
          end, string_value)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          )<br>
          +)<br>
          +<br>
          +A structure allows to groupe fields together. They can be
          reused by different<br>
          +tracepoints:<br>
          +<br>
          +TRACEPOINT_STRUCT(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The provider name, as described in the TRACEPOINT_EVENT
          macro<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          sample_component,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The name of this structure, that will be used when using
          this<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* metadata type in tracepoint fields<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          structure_name,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* TP_ARGS macro contains the arguments passed for the
          structure<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* it is in the following format<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS(type1, name1, type2, name2, ... type10,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          name10)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* where there can be from zero to ten elements.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* typeN is the datatype, such as int, struct or double **.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* name is the variable name (in "int myInt" the name would
          be<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* myint)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS() is valid to mean no arguments<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS(void) is valid too<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          TP_ARGS(int, anint, int, netint, long *, values,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          char *, text, size_t, textlen,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          double, doublearg, float, floatarg),<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* TP_FIELDS describes how to write the fields of the
          structure.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* You can put expressions in the "argument expression"
          area,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* typically using the input arguments from TP_ARGS.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* See TP_FIELDS macro in TRACEPOINT_EVENT for complete
          description<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* of possible fields. A structure may not contain itself and
          there
          cannot<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* be a cycle.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          TP_FIELDS(...)<br>
          +)<br>
          +<br>
          +A variant is a selection between different types, given a<br>
          +'tag'. It is linked with the value of an enumeration.<br>
          +<br>
          +TRACEPOINT_VARIANT(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The provider name, as described in the TRACEPOINT_EVENT
          macro<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          sample_component,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The name of this variant, that will be used when using this<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* metadata type in tracepoint fields<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          variant_name,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The name of the provider where the linked enumeration is
          defined<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          enumeration_component,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The name of the enumeration, whose values will be linked to
          a field<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* type<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          enumeration_name,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* TP_ARGS macro contains the arguments passed for the
          structure<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* it is in the following format<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS(type1, name1, type2, name2, ... type10,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          name10)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* where there can be from zero to ten elements.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* typeN is the datatype, such as int, struct or double **.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* name is the variable name (in "int myInt" the name would
          be<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* myint)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS() is valid to mean no arguments<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; TP_ARGS(void) is valid too<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          TP_ARGS(int, anint, int, netint, long *, values,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          char *, text, size_t, textlen,<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          double, doublearg, float, floatarg),<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* TP_VARIANTS will describe what field will be linked to what
          value
          of<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* the enumeration<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          TP_VARIANTS(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          * TP_VARIANT describes one mapping from an enum value to a
          field<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          */<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TP_VARIANT(<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* The value of the enumeration field. This must correspond to
          one<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* of the string_values defined in TP_ENUM_VALUES of the
          linked<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* enumeration.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          enum_val,<br>
          +<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          /*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* This is the field that will be added to the tracepoint if
          the<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* value of the enum is enum_val.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* See TP_FIELDS macro in TRACEPOINT_EVENT for complete
          description<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* of possible fields. A variant may not contain itself and
          there
          cannot<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;* be a cycle.<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;*/<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &lt;tp_field_expr&gt;<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br>
          + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          )<br>
          +)<br>
          +<br>
          .fi<br>
          <br>
          .SH "ASSIGNING LOGLEVEL TO EVENTS"<br>
          -- <br>
          1.8.4.2<br>
          <br>
          <br>
          _______________________________________________<br>
          lttng-dev mailing list<br>
          <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
        </font></tt><a moz-do-not-send="true"
        href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font
            size="2">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font
          size="2"><br>
        </font></tt>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------000207030302090504030103--


--===============0690384898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0690384898==--
