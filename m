From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [Patch LTTng-ust] RFC: Syntax changes to add
	support of	other CTF metadata
Date: Mon, 9 Dec 2013 11:00:31 +0200
Message-ID: <OFF843DEBF.52AA8094-ONC2257C3C.003166EF-C2257C3C.00317EC1__48499.9265791432$1386579843$gmane$org@il.ibm.com>
References: <1386274940-24174-1-git-send-email-gbastien+lttng@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1337651474=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Vpwjo-0008E6-Va
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 04:03:07 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 9 Dec 2013 09:02:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E324219009B
	for <lttng-dev@lists.lttng.org>; Mon,  9 Dec 2013 09:02:07 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rB990dqV21823644
	for <lttng-dev@lists.lttng.org>; Mon, 9 Dec 2013 09:00:39 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rB990lQp022489
	for <lttng-dev@lists.lttng.org>; Mon, 9 Dec 2013 02:00:47 -0700
In-Reply-To: <1386274940-24174-1-git-send-email-gbastien+lttng@versatic.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1337651474==
Content-Type: multipart/alternative; boundary="=_alternative 00317E66C2257C3C_="

This is a multipart message in MIME format.
--=_alternative 00317E66C2257C3C_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

First, I'd like to say I am a proponent of this.

I'd also love to see some example code using this.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
To:     lttng-dev@lists.lttng.org
Date:   12/05/2013 10:23 PM
Subject:        [lttng-dev] [Patch LTTng-ust] RFC: Syntax changes to add=20
support of      other CTF metadata



The CTF spec defines metadata types enumerations, structures and variants
that are not yet available for use in tracepoints in LTTng-ust. This
proposes the syntax for how those types could be defined and used.

For now, it won't be possible to define them inline in a tracepoint. They
will have to be named and defined outside the TRACEPOINT=5FEVENT macro and
used in the tracepoint definition. It will make it easier for a first
implementation. Once that is done, it won't be too difficult to add inline
support.

Signed-off-by: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
---
 doc/man/lttng-ust.3 | 193=20
++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index 7624e88..c8229f2 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -158,6 +158,39 @@ TRACEPOINT=5FEVENT(
                                  */
                                 ctf=5Ffloat(float, floatfield, floatarg)
                                 ctf=5Ffloat(double, doublefield, doublearg)
+
+                                /*
+                                 * ctf=5Fenum: a field using a previously =

defined named enumeration
+                                 * args: (provider, enum name, field=20
name, argument expression)
+                                 * The enumeration itself and its values=20
must have been defined
+                                 * previously with the TRACEPOINT=5FENUM=20
macro, described below.
+                                 */
+                                ctf=5Fenum(sample=5Fcomponent,=20
enumeration=5Fname, enumfield, enumarg)
+
+                                /*
+                                 * ctf=5Fstruct: a field using a previousl=
y=20
defined struct
+                                 * args: (provider, struct name, field=20
name, [argument expression]*)
+                                 * The structure must have been=20
previously defined with the
+                                 * TRACEPOINT=5FSTRUCT macro, described=20
below.
+                                 *
+                                 * The [argument expression]* part must=20
correspond to the arguments
+                                 * defined in the TP=5FARGS of the struct.
+                                 */
+                                ctf=5Fstruct(sample=5Fcomponent,=20
structure=5Fname, structfield, args...)
+
+                                /*
+                                 * ctf=5Fvariant: a field using a=20
previously defined variant
+                                 * args: (provider, variant name, field=20
name, enum field name,
+                                              [argument expression]*)
+                                 *
+                                 * The [argument expression]* part must=20
correspond to the arguments
+                                 * defined in the TP=5FARGS of the variant.
+                                 *
+                                 * There must be a field in the same=20
tracepoint named 'enumfield'
+                                 * defined with ctf=5Fenum(...)
+                                 */
+                                ctf=5Fvariant(sample=5Fcomponent,=20
variant=5Fname, variantfield,
+ enumfield, args...)
                 )
 )
=20
@@ -165,6 +198,166 @@ There can be an arbitrary number of tracepoint=20
providers within an
 application, but they must each have their own provider name. Duplicate
 provider names are not allowed.
=20
+The CTF specification also supports some named basic and compound types=20
that
+can be defined inside a tracepoint provider and used as fields in the
+tracepoint. This shows how to specify them and what they can be used for:
+
+The enumeration is a mapping between an integer and a string. It can be=20
used
+to have a more compact trace in cases where the possible values for a=20
field are
+limited:
+
+TRACEPOINT=5FENUM(
+                /*
+                 * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                 */
+                sample=5Fcomponent,
+
+                /*
+                 * The name of this enumeration, that will be used when=20
using this
+                 * metadata type in tracepoint fields
+                 */
+                enumeration=5Fname,
+
+                /*
+                 * Integer type by which this enumeration will be=20
represented.
+                 * It can be: char, int, long or any variant on those
+                 */
+                type,
+
+                /*
+                 * TP=5FENUM=5FVALUES describe the values of this enumerat=
ion=20
and what they
+                 * map to.
+                 */
+                TP=5FENUM=5FVALUES(
+                                /*
+                                 * Maps an integer with this string=20
value. By default, enumerations
+                                 * start at 0 and increment 1 for each=20
entry.
+                                 */
+                                ctf=5Fenum=5Fvalue(string=5Fvalue)
+
+                                /*
+                                 * Maps the string value to integers in=20
the range 'start' to 'end'
+                                 * inclusively. If 'start' =3D=3D 'end', t=
hen=20
the string is mapped to
+                                 * a specific value.
+                                 */
+                                ctf=5Fenum=5Frange(start, end, string=5Fva=
lue)
+                )
+)
+
+A structure allows to groupe fields together. They can be reused by=20
different
+tracepoints:
+
+TRACEPOINT=5FSTRUCT(
+                /*
+                 * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                 */
+                sample=5Fcomponent,
+
+                /*
+                 * The name of this structure, that will be used when=20
using this
+                 * metadata type in tracepoint fields
+                 */
+                structure=5Fname,
+
+                /*
+                 * TP=5FARGS macro contains the arguments passed for the=20
structure
+                 * it is in the following format
+                 *                    TP=5FARGS(type1, name1, type2, name2=
,=20
... type10,
+                                                                 name10)
+                 * where there can be from zero to ten elements.
+                 * typeN is the datatype, such as int, struct or double=20
**.
+                 * name is the variable name (in "int myInt" the name=20
would be
+                 * myint)
+                 *                    TP=5FARGS() is valid to mean no=20
arguments
+                 *                    TP=5FARGS(void) is valid too
+                 */
+                TP=5FARGS(int, anint, int, netint, long *, values,
+                                 char *, text, size=5Ft, textlen,
+                                 double, doublearg, float, floatarg),
+
+                /*
+                 * TP=5FFIELDS describes how to write the fields of the=20
structure.
+                 * You can put expressions in the "argument expression"=20
area,
+                 * typically using the input arguments from TP=5FARGS.
+                 *
+                 * See TP=5FFIELDS macro in TRACEPOINT=5FEVENT for complet=
e=20
description
+                 * of possible fields. A structure may not contain itself =

and there cannot
+                 * be a cycle.
+                 */
+                TP=5FFIELDS(...)
+)
+
+A variant is a selection between different types, given a
+'tag'. It is linked with the value of an enumeration.
+
+TRACEPOINT=5FVARIANT(
+                /*
+                 * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                 */
+                sample=5Fcomponent,
+
+                /*
+                 * The name of this variant, that will be used when using =

this
+                 * metadata type in tracepoint fields
+                 */
+                variant=5Fname,
+
+                /*
+                 * The name of the provider where the linked enumeration=20
is defined
+                 */
+                enumeration=5Fcomponent,
+
+                /*
+                 * The name of the enumeration, whose values will be=20
linked to a field
+                 * type
+                 */
+                enumeration=5Fname,
+
+                /*
+                 * TP=5FARGS macro contains the arguments passed for the=20
structure
+                 * it is in the following format
+                 *                    TP=5FARGS(type1, name1, type2, name2=
,=20
... type10,
+                                                                 name10)
+                 * where there can be from zero to ten elements.
+                 * typeN is the datatype, such as int, struct or double=20
**.
+                 * name is the variable name (in "int myInt" the name=20
would be
+                 * myint)
+                 *                    TP=5FARGS() is valid to mean no=20
arguments
+                 *                    TP=5FARGS(void) is valid too
+                 */
+                TP=5FARGS(int, anint, int, netint, long *, values,
+                                 char *, text, size=5Ft, textlen,
+                                 double, doublearg, float, floatarg),
+
+                /*
+                 * TP=5FVARIANTS will describe what field will be linked t=
o=20
what value of
+                 * the enumeration
+                 */
+                TP=5FVARIANTS(
+                                /*
+                                 * TP=5FVARIANT describes one mapping from=
=20
an enum value to a field
+                                 */
+                                TP=5FVARIANT(
+                                                /*
+                                                 * The value of the=20
enumeration field. This must correspond to one
+                                                 * of the string=5Fvalues =

defined in TP=5FENUM=5FVALUES of the linked
+                                                 * enumeration.
+                                                 */
+                                                enum=5Fval,
+
+                                                /*
+                                                 * This is the field that =

will be added to the tracepoint if the
+                                                 * value of the enum is=20
enum=5Fval.
+                                                 *
+                                                 * See TP=5FFIELDS macro i=
n=20
TRACEPOINT=5FEVENT for complete description
+                                                 * of possible fields. A=20
variant may not contain itself and there cannot
+                                                 * be a cycle.
+                                                 */
+                                                <tp=5Ffield=5Fexpr>
+                                )
+                )
+)
+
 .fi
=20
 .SH "ASSIGNING LOGLEVEL TO EVENTS"
--=20
1.8.4.2


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 00317E66C2257C3C_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">First, I'd like to say I am a proponent
of this.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I'd also love to see some example co=
de
using this.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks,</font>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Genevi=E8ve Bastien &lt;gba=
stien+lttng@versatic.net&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev@lists.lttng.org</=
font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">12/05/2013 10:23 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">[lttng-dev]
[Patch LTTng-ust] RFC: Syntax changes to add support of &nbsp; &nbsp; &nbsp;
&nbsp;other CTF metadata</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>The CTF spec defines metadata types enumerations,
structures and variants<br>
that are not yet available for use in tracepoints in LTTng-ust. This<br>
proposes the syntax for how those types could be defined and used.<br>
<br>
For now, it won't be possible to define them inline in a tracepoint. They<b=
r>
will have to be named and defined outside the TRACEPOINT=5FEVENT macro and<=
br>
used in the tracepoint definition. It will make it easier for a first<br>
implementation. Once that is done, it won't be too difficult to add inline<=
br>
support.<br>
<br>
Signed-off-by: Genevi=E8ve Bastien &lt;gbastien+lttng@versatic.net&gt;<br>
---<br>
 doc/man/lttng-ust.3 | 193 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++<br>
 1 file changed, 193 insertions(+)<br>
<br>
diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3<br>
index 7624e88..c8229f2 100644<br>
--- a/doc/man/lttng-ust.3<br>
+++ b/doc/man/lttng-ust.3<br>
@@ -158,6 +158,39 @@ TRACEPOINT=5FEVENT(<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ctf=5Ffloat(float, floatfield, floatarg)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
ctf=5Ffloat(double, doublefield, doublearg)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* ctf=5Fenum: a field using a previously defined named enumeration<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* args: (provider, enum name, field name, argument expression)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* The enumeration itself and its values must have been defined<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* previously with the TRACEPOINT=5FENUM macro, described below.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum(sa=
mple=5Fcomponent,
enumeration=5Fname, enumfield, enumarg)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* ctf=5Fstruct: a field using a previously defined struct<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* args: (provider, struct name, field name, [argument expression]*)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* The structure must have been previously defined with the<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* TRACEPOINT=5FSTRUCT macro, described below.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* The [argument expression]* part must correspond to the arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* defined in the TP=5FARGS of the struct.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fstruct(=
sample=5Fcomponent,
structure=5Fname, structfield, args...)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* ctf=5Fvariant: a field using a previously defined variant<br>
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
* The [argument expression]* part must correspond to the arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* defined in the TP=5FARGS of the variant.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* There must be a field in the same tracepoint named 'enumfield'<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* defined with ctf=5Fenum(...)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fvariant=
(sample=5Fcomponent,
variant=5Fname, variantfield,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enumfield,
args...)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br>
 )<br>
 <br>
@@ -165,6 +198,166 @@ There can be an arbitrary number of tracepoint provid=
ers
within an<br>
 application, but they must each have their own provider name. Duplicate<br>
 provider names are not allowed.<br>
 <br>
+The CTF specification also supports some named basic and compound types
that<br>
+can be defined inside a tracepoint provider and used as fields in the<br>
+tracepoint. This shows how to specify them and what they can be used for:<=
br>
+<br>
+The enumeration is a mapping between an integer and a string. It can be
used<br>
+to have a more compact trace in cases where the possible values for a
field are<br>
+limited:<br>
+<br>
+TRACEPOINT=5FENUM(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The provider name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
sample=5Fcomponent,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The name of this enumeration, that will be used when using this<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* metadata type in tracepoint fields<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
enumeration=5Fname,<br>
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
&nbsp;* TP=5FENUM=5FVALUES describe the values of this enumeration and what
they<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* map to.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
TP=5FENUM=5FVALUES(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* Maps an integer with this string value. By default, enumerations<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* start at 0 and increment 1 for each entry.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum=5F=
value(string=5Fvalue)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* Maps the string value to integers in the range 'start' to 'end'<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* inclusively. If 'start' =3D=3D 'end', then the string is mapped to<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* a specific value.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum=5F=
range(start,
end, string=5Fvalue)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
)<br>
+)<br>
+<br>
+A structure allows to groupe fields together. They can be reused by differ=
ent<br>
+tracepoints:<br>
+<br>
+TRACEPOINT=5FSTRUCT(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The provider name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
sample=5Fcomponent,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The name of this structure, that will be used when using this<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* metadata type in tracepoint fields<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
structure=5Fname,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* TP=5FARGS macro contains the arguments passed for the structure<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* it is in the following format<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS(type1, name1, type2, name2, ... type10,<br>
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
&nbsp;* name is the variable name (in &quot;int myInt&quot; the name would
be<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* myint)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS() is valid to mean no arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS(void) is valid too<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
TP=5FARGS(int, anint, int, netint, long *, values,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
char *, text, size=5Ft, textlen,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
double, doublearg, float, floatarg),<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* TP=5FFIELDS describes how to write the fields of the structure.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* You can put expressions in the &quot;argument expression&quot;
area,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* typically using the input arguments from TP=5FARGS.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* See TP=5FFIELDS macro in TRACEPOINT=5FEVENT for complete descriptio=
n<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* of possible fields. A structure may not contain itself and there
cannot<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* be a cycle.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
TP=5FFIELDS(...)<br>
+)<br>
+<br>
+A variant is a selection between different types, given a<br>
+'tag'. It is linked with the value of an enumeration.<br>
+<br>
+TRACEPOINT=5FVARIANT(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The provider name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
sample=5Fcomponent,<br>
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
variant=5Fname,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The name of the provider where the linked enumeration is defined<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
enumeration=5Fcomponent,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The name of the enumeration, whose values will be linked to a field=
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* type<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
enumeration=5Fname,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* TP=5FARGS macro contains the arguments passed for the structure<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* it is in the following format<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS(type1, name1, type2, name2, ... type10,<br>
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
&nbsp;* name is the variable name (in &quot;int myInt&quot; the name would
be<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* myint)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS() is valid to mean no arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; TP=5FARGS(void) is valid too<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
TP=5FARGS(int, anint, int, netint, long *, values,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
char *, text, size=5Ft, textlen,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
double, doublearg, float, floatarg),<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* TP=5FVARIANTS will describe what field will be linked to what value
of<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* the enumeration<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
TP=5FVARIANTS(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
* TP=5FVARIANT describes one mapping from an enum value to a field<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TP=5FVARIANT(=
<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* The value of the enumeration field. This must correspond to one<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* of the string=5Fvalues defined in TP=5FENUM=5FVALUES of the linked<=
br>
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
enum=5Fval,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* This is the field that will be added to the tracepoint if the<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* value of the enum is enum=5Fval.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* See TP=5FFIELDS macro in TRACEPOINT=5FEVENT for complete descriptio=
n<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* of possible fields. A variant may not contain itself and there
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
&lt;tp=5Ffield=5Fexpr&gt;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
)<br>
+)<br>
+<br>
 .fi<br>
 <br>
 .SH &quot;ASSIGNING LOGLEVEL TO EVENTS&quot;<br>
-- <br>
1.8.4.2<br>
<br>
<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br>
--=_alternative 00317E66C2257C3C_=--



--===============1337651474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1337651474==--
