From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Thu, 10 Apr 2014 23:45:53 -0700
Message-ID: <CAEEAEzVxnxz4_+zewiUDGHL0YOaENSpXog80YF+d9cnQkK0FVA__24076.0254943327$1397198808$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35996E2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2117664046=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <babbusandy2006@gmail.com>) id 1WYVDq-0007GY-Pd
 for lttng-dev@lists.lttng.org; Fri, 11 Apr 2014 02:46:00 -0400
Received: by mail-qg0-f51.google.com with SMTP id q108so4964228qgd.38
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 23:45:53 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD35996E2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2117664046==
Content-Type: multipart/alternative; boundary=001a11c3e2425e6f2404f6beaf8f

--001a11c3e2425e6f2404f6beaf8f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

All right. This is the updated diff for the test case changes. Please have
a look.

diff --git a/test_utils_parse_size_suffix.c.bkup
b/test_utils_parse_size_suffix.c
index 3b9c68c..909dfbc 100644
--- a/test_utils_parse_size_suffix.c.bkup
+++ b/test_utils_parse_size_suffix.c
@@ -37,17 +37,48 @@ static struct valid_test_input valid_tests_inputs[] =3D=
 {
  { "0", 0 },
  { "1234", 1234 },
  { "0x400", 1024 },
+ { "0X400", 1024 },
+ { "0x40a", 1034 },
+ { "0X40b", 1035 },
+ { "0x40e", 1038 },
+ { "0X40f", 1039 },
  { "0300", 192 },
  { "16k", 16384 },
  { "128K", 131072 },
  { "0x1234k", 4771840 },
  { "32M", 33554432 },
  { "1024G", 1099511627776 },
+ { "00", 0 },
+ { "0k", 0 },
+ { "0K", 0 },
+ { "0M", 0 },
+ { "0G", 0 },
+ { "00k", 0 },
+ { "00K", 0 },
+ { "00M", 0 },
+ { "00G", 0 },
+ { "0x0", 0 },
+ { "0X0", 0 },
+ { "0x0k", 0 },
+ { "0X0K", 0 },
+ { "0x0M", 0 },
+ { "0X0G", 0 },
+ { "0x40C", 1036 },
+ { "0X40D", 1037 },
+ { "0X40G", 68719476736 },
+ { "0300k", 196608 },
+ { "0300K", 196608 },
+ { "030M", 25165824 },
+ { "020G", 17179869184 },
+ { "0xa0k", 163840 },
+ { "0xa0K", 163840 },
+ { "0XA0M", 167772160 },
+ { "0xA0G", 171798691840 },
 };
 static const int num_valid_tests =3D sizeof(valid_tests_inputs) /
sizeof(valid_tests_inputs[0]);

 /* Invalid test cases */
-static char *invalid_tests_inputs[] =3D { "", "-1", "k",
"4611686018427387904G" };
+static char *invalid_tests_inputs[] =3D { "", "-1", "k", "08", "09",
"4611686018427387904G", "x0", "0xx0", "07kK", "0xk", "0XM", "0xG", "0x0MM",
"0X0GG", "0a", "0B"};
 static const int num_invalid_tests =3D sizeof(invalid_tests_inputs) /
sizeof(invalid_tests_inputs[0]);

 static void test_utils_parse_size_suffix(void)


Thanks,
Sandeep.


On Wed, Apr 9, 2014 at 6:42 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> ----------------------------------------------------------------------
> Date: Tue, 8 Apr 2014 22:09:36 -0700
> From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
> To: David Goulet <dgoulet@efficios.com>
> Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
>
> > Here is the diff for changes made to the unit test. Please have a look.
> ----------------------------------------------------------------------
>
>    I would suggest these additional valid and invalid test cases:
>
> Valid:
>
> { "00", 0 },
> { "0k", 0 },
> { "0K", 0 },
> { "0M", 0 },
> { "0G", 0 },
> { "00k", 0 },
> { "00K", 0 },
> { "00M", 0 },
> { "00G", 0 },
> { "0x0", 0 },
> { "0X0", 0 },
> { "0x0k", 0 },
> { "0X0K", 0 },
> { "0x0M", 0 },
> { "0X0G", 0 },
> { "0x40C", 1036 },
> { "0X40D", 1037 },
> { "0X40G", 68719476736 },
> { "0300k", 196608 },
> { "0300K", 196608 },
> { "030M", 25165824 },
> { "020G", 17179869184 },
> { "0xa0k", 163840 },
> { "0xa0K", 163840 },
> { "0XA0M", 167772160 },
> { "0xA0G", 171798691840 },
>
> Invalid:
>
> " ", "x0", "0xx0", "07kK", "0xk", "0XM", "0xG", "0x0MM", "0X0GG", "0a",
> "0B"
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>



--=20
Thanks and regards,
Sandeep K Chaudhary.

--001a11c3e2425e6f2404f6beaf8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All right. This is the updated diff for the test case chan=
ges. Please have a look.<div><br></div><div><div>diff --git a/test_utils_pa=
rse_size_suffix.c.bkup b/test_utils_parse_size_suffix.c</div><div>index 3b9=
c68c..909dfbc 100644</div>
<div>--- a/test_utils_parse_size_suffix.c.bkup</div><div>+++ b/test_utils_p=
arse_size_suffix.c</div><div>@@ -37,17 +37,48 @@ static struct valid_test_i=
nput valid_tests_inputs[] =3D {</div><div>=A0<span class=3D"" style=3D"whit=
e-space:pre">		</span>{ &quot;0&quot;, 0 },</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;1234&qu=
ot;, 1234 },</div><div>=A0<span class=3D"" style=3D"white-space:pre">		</sp=
an>{ &quot;0x400&quot;, 1024 },</div><div>+<span class=3D"" style=3D"white-=
space:pre">		</span>{ &quot;0X400&quot;, 1024 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0x40a&quo=
t;, 1034 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>=
{ &quot;0X40b&quot;, 1035 },</div><div>+<span class=3D"" style=3D"white-spa=
ce:pre">		</span>{ &quot;0x40e&quot;, 1038 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0X40f&quo=
t;, 1039 },</div><div>=A0<span class=3D"" style=3D"white-space:pre">		</spa=
n>{ &quot;0300&quot;, 192 },</div><div>=A0<span class=3D"" style=3D"white-s=
pace:pre">		</span>{ &quot;16k&quot;, 16384 },</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;128K&qu=
ot;, 131072 },</div><div>=A0<span class=3D"" style=3D"white-space:pre">		</=
span>{ &quot;0x1234k&quot;, 4771840 },</div><div>=A0<span class=3D"" style=
=3D"white-space:pre">		</span>{ &quot;32M&quot;, 33554432 },</div>
<div>=A0<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;1024G&q=
uot;, 1099511627776 },</div><div>+<span class=3D"" style=3D"white-space:pre=
">		</span>{ &quot;00&quot;, 0 },</div><div>+<span class=3D"" style=3D"whit=
e-space:pre">		</span>{ &quot;0k&quot;, 0 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0K&quot;,=
 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quo=
t;0M&quot;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</=
span>{ &quot;0G&quot;, 0 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;00k&quot;=
, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &qu=
ot;00K&quot;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		=
</span>{ &quot;00M&quot;, 0 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;00G&quot;=
, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &qu=
ot;0x0&quot;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		=
</span>{ &quot;0X0&quot;, 0 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0x0k&quot=
;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &q=
uot;0X0K&quot;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">=
		</span>{ &quot;0x0M&quot;, 0 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0X0G&quot=
;, 0 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &q=
uot;0x40C&quot;, 1036 },</div><div>+<span class=3D"" style=3D"white-space:p=
re">		</span>{ &quot;0X40D&quot;, 1037 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0X40G&quo=
t;, 68719476736 },</div><div>+<span class=3D"" style=3D"white-space:pre">		=
</span>{ &quot;0300k&quot;, 196608 },</div><div>+<span class=3D"" style=3D"=
white-space:pre">		</span>{ &quot;0300K&quot;, 196608 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;030M&quot=
;, 25165824 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</sp=
an>{ &quot;020G&quot;, 17179869184 },</div><div>+<span class=3D"" style=3D"=
white-space:pre">		</span>{ &quot;0xa0k&quot;, 163840 },</div>
<div>+<span class=3D"" style=3D"white-space:pre">		</span>{ &quot;0xa0K&quo=
t;, 163840 },</div><div>+<span class=3D"" style=3D"white-space:pre">		</spa=
n>{ &quot;0XA0M&quot;, 167772160 },</div><div>+<span class=3D"" style=3D"wh=
ite-space:pre">		</span>{ &quot;0xA0G&quot;, 171798691840 },</div>
<div>=A0};</div><div>=A0static const int num_valid_tests =3D sizeof(valid_t=
ests_inputs) / sizeof(valid_tests_inputs[0]);</div><div>=A0</div><div>=A0/*=
 Invalid test cases */</div><div>-static char *invalid_tests_inputs[] =3D {=
 &quot;&quot;, &quot;-1&quot;, &quot;k&quot;, &quot;4611686018427387904G&qu=
ot; };</div>
<div>+static char *invalid_tests_inputs[] =3D { &quot;&quot;, &quot;-1&quot=
;, &quot;k&quot;, &quot;08&quot;, &quot;09&quot;, &quot;4611686018427387904=
G&quot;, &quot;x0&quot;, &quot;0xx0&quot;, &quot;07kK&quot;, &quot;0xk&quot=
;, &quot;0XM&quot;, &quot;0xG&quot;, &quot;0x0MM&quot;, &quot;0X0GG&quot;, =
&quot;0a&quot;, &quot;0B&quot;};</div>
<div>=A0static const int num_invalid_tests =3D sizeof(invalid_tests_inputs)=
 / sizeof(invalid_tests_inputs[0]);</div><div>=A0</div><div>=A0static void =
test_utils_parse_size_suffix(void)</div></div><div><br></div><div><br></div=
><div>
Thanks,</div><div>Sandeep.</div></div><div class=3D"gmail_extra"><br><br><d=
iv class=3D"gmail_quote">On Wed, Apr 9, 2014 at 6:42 AM, Thibault, Daniel <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" tar=
get=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">--------------------------------------------=
--------------------------<br>
Date: Tue, 8 Apr 2014 22:09:36 -0700<br>
From: Sandeep K Chaudhary &lt;<a href=3D"mailto:babbusandy2006@gmail.com">b=
abbusandy2006@gmail.com</a>&gt;<br>
To: David Goulet &lt;<a href=3D"mailto:dgoulet@efficios.com">dgoulet@effici=
os.com</a>&gt;<br>
Cc: &quot;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttn=
g.org</a>&quot; &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@=
lists.lttng.org</a>&gt;<br>
<div class=3D""><br>
&gt; Here is the diff for changes made to the unit test. Please have a look=
.<br>
</div>---------------------------------------------------------------------=
-<br>
<br>
=A0 =A0I would suggest these additional valid and invalid test cases:<br>
<br>
Valid:<br>
<br>
{ &quot;00&quot;, 0 },<br>
{ &quot;0k&quot;, 0 },<br>
{ &quot;0K&quot;, 0 },<br>
{ &quot;0M&quot;, 0 },<br>
{ &quot;0G&quot;, 0 },<br>
{ &quot;00k&quot;, 0 },<br>
{ &quot;00K&quot;, 0 },<br>
{ &quot;00M&quot;, 0 },<br>
{ &quot;00G&quot;, 0 },<br>
{ &quot;0x0&quot;, 0 },<br>
{ &quot;0X0&quot;, 0 },<br>
{ &quot;0x0k&quot;, 0 },<br>
{ &quot;0X0K&quot;, 0 },<br>
{ &quot;0x0M&quot;, 0 },<br>
{ &quot;0X0G&quot;, 0 },<br>
{ &quot;0x40C&quot;, 1036 },<br>
{ &quot;0X40D&quot;, 1037 },<br>
{ &quot;0X40G&quot;, 68719476736 },<br>
{ &quot;0300k&quot;, 196608 },<br>
{ &quot;0300K&quot;, 196608 },<br>
{ &quot;030M&quot;, 25165824 },<br>
{ &quot;020G&quot;, 17179869184 },<br>
{ &quot;0xa0k&quot;, 163840 },<br>
{ &quot;0xa0K&quot;, 163840 },<br>
{ &quot;0XA0M&quot;, 167772160 },<br>
{ &quot;0xA0G&quot;, 171798691840 },<br>
<br>
Invalid:<br>
<br>
&quot; &quot;, &quot;x0&quot;, &quot;0xx0&quot;, &quot;07kK&quot;, &quot;0x=
k&quot;, &quot;0XM&quot;, &quot;0xG&quot;, &quot;0x0MM&quot;, &quot;0X0GG&q=
uot;, &quot;0a&quot;, &quot;0B&quot;<br>
<br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Thanks and r=
egards,<br>Sandeep K Chaudhary.
</div>

--001a11c3e2425e6f2404f6beaf8f--


--===============2117664046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2117664046==--
