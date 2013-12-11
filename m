From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: [Patch LTTng-ust] RFC: Syntax changes to add
 support of other CTF metadata
Date: Wed, 11 Dec 2013 09:39:05 +0200
Message-ID: <OF38814A15.12DCF5BA-ONC2257C3E.0029E971-C2257C3E.002A0AC4__33517.2726925977$1386747639$gmane$org@il.ibm.com>
References: <1386274940-24174-1-git-send-email-gbastien+lttng@versatic.net>	<OFF843DEBF.52AA8094-ONC2257C3C.003166EF-C2257C3C.00317EC1@il.ibm.com>
	<52A7309E.3050202@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0646307941=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VqeOF-0005Qk-O2
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 02:39:34 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 11 Dec 2013 07:39:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 161561B0805F
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 07:38:25 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rBB7d7Kf61931620
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 07:39:07 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rBB7dInP012177
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 00:39:19 -0700
In-Reply-To: <52A7309E.3050202@versatic.net>
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
--===============0646307941==
Content-Type: multipart/alternative; boundary="=_alternative 002A0AA3C2257C3E_="

This is a multipart message in MIME format.
--=_alternative 002A0AA3C2257C3E_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Genevieve, I appreciate that. I feel the examples it make easier=20
to give feedback on the use cases, rather than the ideas.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
To:     lttng-dev@lists.lttng.org
Date:   12/10/2013 05:19 PM
Subject:        Re: [lttng-dev] [Patch LTTng-ust] RFC: Syntax changes to=20
add support of other CTF metadata



Thanks Amit,

I'll add support of those metadata one at a time, starting with the enum=20
and then going for the struct and the variant. As support is added, I'll=20
add to the documentation/examples and there will be a test application in=20
the code to showcase those fields. But for myself, I'll probably work on=20
the examples before implementing their support so I can share it on this=20
list for discussion beforehand.

Genevi=E8ve


On 12/09/2013 04:00 AM, Amit Margalit wrote:
First, I'd like to say I am a proponent of this.=20

I'd also love to see some example code using this.=20

Thanks,=20

Amit Margalit=20
IBM XIV - Storage Reinvented=20
XIV-NAS Development Team=20
Tel. 03-689-7774=20
Fax. 03-689-7230=20



From:        Genevi=E8ve Bastien <gbastien+lttng@versatic.net>=20
To:        lttng-dev@lists.lttng.org=20
Date:        12/05/2013 10:23 PM=20
Subject:        [lttng-dev] [Patch LTTng-ust] RFC: Syntax changes to add=20
support of        other CTF metadata=20



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
                                  ctf=5Ffloat(double, doublefield,=20
doublearg)
+
+                                  /*
+                                   * ctf=5Fenum: a field using a previousl=
y=20
defined named enumeration
+                                   * args: (provider, enum name, field=20
name, argument expression)
+                                   * The enumeration itself and its=20
values must have been defined
+                                   * previously with the TRACEPOINT=5FENUM=
=20
macro, described below.
+                                   */
+                                  ctf=5Fenum(sample=5Fcomponent,=20
enumeration=5Fname, enumfield, enumarg)
+
+                                  /*
+                                   * ctf=5Fstruct: a field using a=20
previously defined struct
+                                   * args: (provider, struct name, field=20
name, [argument expression]*)
+                                   * The structure must have been=20
previously defined with the
+                                   * TRACEPOINT=5FSTRUCT macro, described =

below.
+                                   *
+                                   * The [argument expression]* part must =

correspond to the arguments
+                                   * defined in the TP=5FARGS of the=20
struct.
+                                   */
+                                  ctf=5Fstruct(sample=5Fcomponent,=20
structure=5Fname, structfield, args...)
+
+                                  /*
+                                   * ctf=5Fvariant: a field using a=20
previously defined variant
+                                   * args: (provider, variant name, field =

name, enum field name,
+                                                [argument expression]*)
+                                   *
+                                   * The [argument expression]* part must =

correspond to the arguments
+                                   * defined in the TP=5FARGS of the=20
variant.
+                                   *
+                                   * There must be a field in the same=20
tracepoint named 'enumfield'
+                                   * defined with ctf=5Fenum(...)
+                                   */
+                                  ctf=5Fvariant(sample=5Fcomponent,=20
variant=5Fname, variantfield,
+ enumfield, args...)
                 )
)

@@ -165,6 +198,166 @@ There can be an arbitrary number of tracepoint=20
providers within an
application, but they must each have their own provider name. Duplicate
provider names are not allowed.

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
+                 /*
+                  * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                  */
+                 sample=5Fcomponent,
+
+                 /*
+                  * The name of this enumeration, that will be used when=20
using this
+                  * metadata type in tracepoint fields
+                  */
+                 enumeration=5Fname,
+
+                 /*
+                  * Integer type by which this enumeration will be=20
represented.
+                  * It can be: char, int, long or any variant on those
+                  */
+                 type,
+
+                 /*
+                  * TP=5FENUM=5FVALUES describe the values of this=20
enumeration and what they
+                  * map to.
+                  */
+                 TP=5FENUM=5FVALUES(
+                                  /*
+                                   * Maps an integer with this string=20
value. By default, enumerations
+                                   * start at 0 and increment 1 for each=20
entry.
+                                   */
+                                  ctf=5Fenum=5Fvalue(string=5Fvalue)
+
+                                  /*
+                                   * Maps the string value to integers in =

the range 'start' to 'end'
+                                   * inclusively. If 'start' =3D=3D 'end',=
=20
then the string is mapped to
+                                   * a specific value.
+                                   */
+                                  ctf=5Fenum=5Frange(start, end,=20
string=5Fvalue)
+                 )
+)
+
+A structure allows to groupe fields together. They can be reused by=20
different
+tracepoints:
+
+TRACEPOINT=5FSTRUCT(
+                 /*
+                  * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                  */
+                 sample=5Fcomponent,
+
+                 /*
+                  * The name of this structure, that will be used when=20
using this
+                  * metadata type in tracepoint fields
+                  */
+                 structure=5Fname,
+
+                 /*
+                  * TP=5FARGS macro contains the arguments passed for the =

structure
+                  * it is in the following format
+                  *                       TP=5FARGS(type1, name1, type2,=20
name2, ... type10,
+ name10)
+                  * where there can be from zero to ten elements.
+                  * typeN is the datatype, such as int, struct or double=20
**.
+                  * name is the variable name (in "int myInt" the name=20
would be
+                  * myint)
+                  *                       TP=5FARGS() is valid to mean no =

arguments
+                  *                       TP=5FARGS(void) is valid too
+                  */
+                 TP=5FARGS(int, anint, int, netint, long *, values,
+                                   char *, text, size=5Ft, textlen,
+                                   double, doublearg, float, floatarg),
+
+                 /*
+                  * TP=5FFIELDS describes how to write the fields of the=20
structure.
+                  * You can put expressions in the "argument expression"=20
area,
+                  * typically using the input arguments from TP=5FARGS.
+                  *
+                  * See TP=5FFIELDS macro in TRACEPOINT=5FEVENT for comple=
te=20
description
+                  * of possible fields. A structure may not contain=20
itself and there cannot
+                  * be a cycle.
+                  */
+                 TP=5FFIELDS(...)
+)
+
+A variant is a selection between different types, given a
+'tag'. It is linked with the value of an enumeration.
+
+TRACEPOINT=5FVARIANT(
+                 /*
+                  * The provider name, as described in the=20
TRACEPOINT=5FEVENT macro
+                  */
+                 sample=5Fcomponent,
+
+                 /*
+                  * The name of this variant, that will be used when=20
using this
+                  * metadata type in tracepoint fields
+                  */
+                 variant=5Fname,
+
+                 /*
+                  * The name of the provider where the linked enumeration =

is defined
+                  */
+                 enumeration=5Fcomponent,
+
+                 /*
+                  * The name of the enumeration, whose values will be=20
linked to a field
+                  * type
+                  */
+                 enumeration=5Fname,
+
+                 /*
+                  * TP=5FARGS macro contains the arguments passed for the =

structure
+                  * it is in the following format
+                  *                       TP=5FARGS(type1, name1, type2,=20
name2, ... type10,
+ name10)
+                  * where there can be from zero to ten elements.
+                  * typeN is the datatype, such as int, struct or double=20
**.
+                  * name is the variable name (in "int myInt" the name=20
would be
+                  * myint)
+                  *                       TP=5FARGS() is valid to mean no =

arguments
+                  *                       TP=5FARGS(void) is valid too
+                  */
+                 TP=5FARGS(int, anint, int, netint, long *, values,
+                                   char *, text, size=5Ft, textlen,
+                                   double, doublearg, float, floatarg),
+
+                 /*
+                  * TP=5FVARIANTS will describe what field will be linked =

to what value of
+                  * the enumeration
+                  */
+                 TP=5FVARIANTS(
+                                  /*
+                                   * TP=5FVARIANT describes one mapping=20
from an enum value to a field
+                                   */
+                                  TP=5FVARIANT(
+                                                   /*
+                                                    * The value of the=20
enumeration field. This must correspond to one
+                                                    * of the=20
string=5Fvalues defined in TP=5FENUM=5FVALUES of the linked
+                                                    * enumeration.
+                                                    */
+                                                   enum=5Fval,
+
+                                                   /*
+                                                    * This is the field=20
that will be added to the tracepoint if the
+                                                    * value of the enum=20
is enum=5Fval.
+                                                    *
+                                                    * See TP=5FFIELDS macr=
o=20
in TRACEPOINT=5FEVENT for complete description
+                                                    * of possible fields. =

A variant may not contain itself and there cannot
+                                                    * be a cycle.
+                                                    */
+                                                   <tp=5Ffield=5Fexpr>
+                                  )
+                 )
+)
+
.fi

.SH "ASSIGNING LOGLEVEL TO EVENTS"
--=20
1.8.4.2


=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 002A0AA3C2257C3E_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Thanks, Genevieve, I appreciate that. I
feel the examples it make easier to give feedback on the use cases, rather
than the ideas.</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">12/10/2013 05:19 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
[Patch LTTng-ust] RFC: Syntax changes to add support of other CTF metadata<=
/font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D3>Thanks Amit,<br>
<br>
I'll add support of those metadata one at a time, starting with the enum
and then going for the struct and the variant. As support is added, I'll
add to the documentation/examples and there will be a test application
in the code to showcase those fields. But for myself, I'll probably work
on the examples before implementing their support so I can share it on
this list for discussion beforehand.<br>
<br>
Genevi=E8ve<br>
<br>
<br>
On 12/09/2013 04:00 AM, Amit Margalit wrote:</font>
<br><font size=3D2 face=3D"sans-serif">First, I'd like to say I am a propon=
ent
of this.</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
I'd also love to see some example code using this.</font><font size=3D3>
<br>
</font><font size=3D2 face=3D"sans-serif"><br>
Thanks,</font><font size=3D3> <br>
</font><font size=3D2 color=3D#000080 face=3D"sans-serif"><br>
Amit Margalit</font><font size=3D3> </font><font size=3D2 color=3D#808000 f=
ace=3D"sans-serif"><br>
IBM XIV </font><font size=3D2 face=3D"sans-serif">- <i>Storage Reinvented</=
i></font><font size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
XIV-NAS Development Team</font><font size=3D3> </font><font size=3D2 face=
=3D"sans-serif"><br>
Tel. 03</font><font size=3D2 face=3D"Arial">-689-7774</font><font size=3D3>=
 </font><font size=3D2 face=3D"Arial"><br>
Fax. 03-689-7230</font><font size=3D3> <br>
<br>
<br>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
From: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">=
Genevi=E8ve
Bastien </font><a href=3D"mailto:gbastien+lttng@versatic.net"><font size=3D=
1 color=3Dblue face=3D"sans-serif"><u>&lt;gbastien+lttng@versatic.net&gt;</=
u></font></a><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
To: &nbsp; &nbsp; &nbsp; &nbsp;</font><a href=3D"mailto:lttng-dev@lists.ltt=
ng.org"><font size=3D1 color=3Dblue face=3D"sans-serif"><u>lttng-dev@lists.=
lttng.org</u></font></a><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
Date: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">=
12/05/2013
10:23 PM</font><font size=3D3> </font><font size=3D1 color=3D#5f5f5f face=
=3D"sans-serif"><br>
Subject: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-seri=
f">[lttng-dev]
[Patch LTTng-ust] RFC: Syntax changes to add support of &nbsp; &nbsp; &nbsp;
&nbsp;other CTF metadata</font><font size=3D3> <br>
</font>
<hr noshade><font size=3D3><br>
<br>
</font><tt><font size=3D2><br>
The CTF spec defines metadata types enumerations, structures and variants<b=
r>
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
Signed-off-by: Genevi=E8ve Bastien </font></tt><a href=3D"mailto:gbastien+l=
ttng@versatic.net"><tt><font size=3D2 color=3Dblue><u>&lt;gbastien+lttng@ve=
rsatic.net&gt;</u></font></tt></a><tt><font size=3D2><br>
---<br>
doc/man/lttng-ust.3 | 193 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++<br>
1 file changed, 193 insertions(+)<br>
<br>
diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3<br>
index 7624e88..c8229f2 100644<br>
--- a/doc/man/lttng-ust.3<br>
+++ b/doc/man/lttng-ust.3<br>
@@ -158,6 +158,39 @@ TRACEPOINT=5FEVENT(<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Ffloat(float, floatfie=
ld,
floatarg)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Ffloat(double, doublef=
ield,
doublearg)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * ctf=5Fenum: a field using
a previously defined named enumeration<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * args: (provider, enum
name, field name, argument expression)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * The enumeration itself
and its values must have been defined<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * previously with the
TRACEPOINT=5FENUM macro, described below.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum(sample=5Fcompone=
nt,
enumeration=5Fname, enumfield, enumarg)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * ctf=5Fstruct: a field
using a previously defined struct<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * args: (provider, struct
name, field name, [argument expression]*)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * The structure must have
been previously defined with the<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * TRACEPOINT=5FSTRUCT macr=
o,
described below.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * The [argument expression=
]*
part must correspond to the arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * defined in the TP=5FARGS
of the struct.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fstruct(sample=5Fcompo=
nent,
structure=5Fname, structfield, args...)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * ctf=5Fvariant: a field
using a previously defined variant<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * args: (provider, variant
name, field name, enum field name,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;[argument expression]*)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * The [argument expression=
]*
part must correspond to the arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * defined in the TP=5FARGS
of the variant.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * There must be a field
in the same tracepoint named 'enumfield'<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * defined with ctf=5Fenum(=
...)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fvariant(sample=5Fcomp=
onent,
variant=5Fname, variantfield,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;enumfield, args...)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; )<br>
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
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The provi=
der
name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sample=5Fcomponen=
t,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The name
of this enumeration, that will be used when using this<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* metadata
type in tracepoint fields<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; enumeration=5Fnam=
e,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Integer
type by which this enumeration will be represented.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* It can
be: char, int, long or any variant on those<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; type,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* TP=5FENUM=
=5FVALUES
describe the values of this enumeration and what they<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* map to.<b=
r>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5FENUM=5FVALUE=
S(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * Maps an integer with
this string value. By default, enumerations<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * start at 0 and increment
1 for each entry.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum=5Fvalue(string=
=5Fvalue)<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * Maps the string value
to integers in the range 'start' to 'end'<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * inclusively. If 'start'
=3D=3D 'end', then the string is mapped to<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * a specific value.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ctf=5Fenum=5Frange(start, e=
nd,
string=5Fvalue)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; )<br>
+)<br>
+<br>
+A structure allows to groupe fields together. They can be reused by differ=
ent<br>
+tracepoints:<br>
+<br>
+TRACEPOINT=5FSTRUCT(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The provi=
der
name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sample=5Fcomponen=
t,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The name
of this structure, that will be used when using this<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* metadata
type in tracepoint fields<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; structure=5Fname,=
<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* TP=5FARGS
macro contains the arguments passed for the structure<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* it is
in the following format<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS(type1,
name1, type2, name2, ... type10,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; name10)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* where
there can be from zero to ten elements.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* typeN
is the datatype, such as int, struct or double **.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* name
is the variable name (in &quot;int myInt&quot; the name would be<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* myint)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS()
is valid to mean no arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS(void)
is valid too<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5FARGS(int,
anint, int, netint, long *, values,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char *, text, size=5Ft,
textlen,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; double, doublearg, float,
floatarg),<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* TP=5FFIEL=
DS
describes how to write the fields of the structure.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* You can
put expressions in the &quot;argument expression&quot; area,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* typically
using the input arguments from TP=5FARGS.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* See TP=5F=
FIELDS
macro in TRACEPOINT=5FEVENT for complete description<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* of possib=
le
fields. A structure may not contain itself and there cannot<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* be a
cycle.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5FFIELDS(...)<=
br>
+)<br>
+<br>
+A variant is a selection between different types, given a<br>
+'tag'. It is linked with the value of an enumeration.<br>
+<br>
+TRACEPOINT=5FVARIANT(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The provi=
der
name, as described in the TRACEPOINT=5FEVENT macro<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sample=5Fcomponen=
t,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The name
of this variant, that will be used when using this<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* metadata
type in tracepoint fields<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; variant=5Fname,<b=
r>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The name
of the provider where the linked enumeration is defined<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; enumeration=5Fcom=
ponent,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The name
of the enumeration, whose values will be linked to a field<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* type<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; enumeration=5Fnam=
e,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* TP=5FARGS
macro contains the arguments passed for the structure<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* it is
in the following format<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS(type1,
name1, type2, name2, ... type10,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; name10)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* where
there can be from zero to ten elements.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* typeN
is the datatype, such as int, struct or double **.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* name
is the variable name (in &quot;int myInt&quot; the name would be<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* myint)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS()
is valid to mean no arguments<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5F=
ARGS(void)
is valid too<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5FARGS(int,
anint, int, netint, long *, values,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char *, text, size=5Ft,
textlen,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; double, doublearg, float,
floatarg),<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* TP=5FVARI=
ANTS
will describe what field will be linked to what value of<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* the enume=
ration<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TP=5FVARIANTS(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * TP=5FVARIANT describes
one mapping from an enum value to a field<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TP=5FVARIANT(<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* The value of the enumeration field.
This must correspond to one<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* of the string=5Fvalues defined in TP=5F=
ENUM=5FVALUES
of the linked<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* enumeration.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; enum=5Fval,<br>
+<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* This is the field that will be added
to the tracepoint if the<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* value of the enum is enum=5Fval.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* See TP=5FFIELDS macro in TRACEPOINT=5FE=
VENT
for complete description<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* of possible fields. A variant may not
contain itself and there cannot<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* be a cycle.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &lt;tp=5Ffield=5Fexpr&gt;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; )<br>
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
lttng-dev mailing list</font></tt><tt><font size=3D2 color=3Dblue><u><br>
</u></font></tt><a href=3D"mailto:lttng-dev@lists.lttng.org"><tt><font size=
=3D2 color=3Dblue><u>lttng-dev@lists.lttng.org</u></font></tt></a><font siz=
e=3D3 color=3Dblue><u><br>
</u></font><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev"><tt><font size=3D2 color=3Dblue><u>http://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev</u></font></tt></a><font size=3D3><br>
</font>
<br><tt><font size=3D2>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br>
--=_alternative 002A0AA3C2257C3E_=--



--===============0646307941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0646307941==--
