From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Tue, 8 Apr 2014 22:09:36 -0700
Message-ID: <CAEEAEzWrB80KALfRuaBMbJV5K0B=BdPM15u6ESx8xeTUGgNszg__1467.01389826394$1397020230$gmane$org@mail.gmail.com>
References: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw@mail.gmail.com>
 <20140325142250.GA7702@thessa>
 <CAEEAEzVTQVNjbUVy007322WeAm1jrE50i6ePAPMaGnh5iM0KOw@mail.gmail.com>
 <20140403150622.GB9339@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1986316603=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <babbusandy2006@gmail.com>) id 1WXkla-00060u-OY
 for lttng-dev@lists.lttng.org; Wed, 09 Apr 2014 01:09:44 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so1990163qab.31
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 22:09:37 -0700 (PDT)
In-Reply-To: <20140403150622.GB9339@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1986316603==
Content-Type: multipart/alternative; boundary=001a1135b82c62fde104f6951ba6

--001a1135b82c62fde104f6951ba6
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

Sorry for the delay in my response. I was away from school.

Here is the diff for changes made to the unit test. Please have a look.

index 3b9c68c..61124ff 100644
--- a/test_utils_parse_size_suffix.c.bkup
+++ b/test_utils_parse_size_suffix.c
@@ -37,6 +37,11 @@ static struct valid_test_input valid_tests_inputs[] = {
                { "0", 0 },
                { "1234", 1234 },
                { "0x400", 1024 },
+               { "0X400", 1024 },
+               { "0x40a", 1034 },
+               { "0X40b", 1035 },
+               { "0x40e", 1038 },
+               { "0X40f", 1039 },
                { "0300", 192 },
                { "16k", 16384 },
                { "128K", 131072 },
@@ -47,7 +52,7 @@ static struct valid_test_input valid_tests_inputs[] = {
 static const int num_valid_tests = sizeof(valid_tests_inputs) /
sizeof(valid_tests_inputs[0]);

 /* Invalid test cases */
-static char *invalid_tests_inputs[] = { "", "-1", "k",
"4611686018427387904G" };
+static char *invalid_tests_inputs[] = { "", "-1", "k", "08", "09",
"4611686018427387904G" };
 static const int num_invalid_tests = sizeof(invalid_tests_inputs) /
sizeof(invalid_tests_inputs[0]);

 static void test_utils_parse_size_suffix(void)

Thanks and regards,
Sandeep.




On Thu, Apr 3, 2014 at 8:06 AM, David Goulet <dgoulet@efficios.com> wrote:

> On 30 Mar (21:57:30), Sandeep K Chaudhary wrote:
> > Hi David,
> >
> > Add the unit tests for the changes. Please have a look at the following
> > diff for the changes in unit test file.
> >
> > 40,44d39
> > <               { "0X400", 1024 },
> > <               { "0x40a", 1034 },
> > <               { "0X40b", 1035 },
> > <               { "0x40e", 1038 },
> > <               { "0X40f", 1039 },
> > 55c50
> > < static char *invalid_tests_inputs[] = { "", "-1", "k", "08", "09",
> > "4611686018427387904G" };
> > ---
> > > static char *invalid_tests_inputs[] = { "", "-1", "k",
> > "4611686018427387904G" };
>
> Can you attach a diff patch to the issue please?
>
> Use "git diff" since the default "diff" command output is a bit
> unreadable for my passionate git eye :).
>
> Thanks!
> David
>
> >
> >
> > Thanks and regards,
> > Sandeep.
> >
> >
> > On Tue, Mar 25, 2014 at 7:22 AM, David Goulet <dgoulet@efficios.com>
> wrote:
> >
> > > On 21 Mar (00:22:57), Sandeep K Chaudhary wrote:
> > > > Hi guys,
> > > >
> > > > I checked the fix suggested in the bug description and it is correct.
> > > >
> > > > Changing
> > > >
> > > > ret = regcomp(&regex,
> > > "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
> > > >
> > > > to
> > > >
> > > > ret = regcomp(&regex,
> > > > "^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$",
> > > REG_EXTENDED);
> > > >
> > > > will take care of the following three problems that exist in the
> first
> > > regex
> > > >
> > > >
> > > >    - It accepts a leading 0 (without a following x or X) to
> represent an
> > > >    octal value, but simultaneously accepts the digits 8 and 9 in said
> > > octal
> > > >    value (this yields -1).
> > > >    - It does not support the leading 0X hexadecimal indicator but
> does
> > > >    support a leading 0x (see following).
> > > >    - It accepts a leading 0x to represent an hexadecimal value but
> > > rejects
> > > >    the a..f and A..F digits in said value.
> > > >
> > > >
> > > > Please let me know your views, and then I can submit a patch for
> this.
> > >
> > > Unfortunately I don't speak regex well enough to tell you if this is
> > > absolutely correct but what you should do with your patch is add unit
> > > test(s) that fix the three problems you list here.
> > >
> > > Most probably in:
> > >
> > >         tests/unit/test_utils_parse_size_suffix.c
> > >
> > > Cheers!
> > > David
> > >
> > > >
> > > > Thanks and regards,
> > > > Sandeep.
> > >
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > >
> >
> >
> > --
> > Thanks and regards,
> > Sandeep K Chaudhary.
>



-- 
Thanks and regards,
Sandeep K Chaudhary.

--001a1135b82c62fde104f6951ba6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<div><br></div><div>Sorry for the delay in my res=
ponse. I was away from school.</div><div><br></div><div>Here is the diff fo=
r changes made to the unit test. Please have a look.</div><div><br></div><d=
iv>
<div>index 3b9c68c..61124ff 100644</div><div>--- a/test_utils_parse_size_su=
ffix.c.bkup</div><div>+++ b/test_utils_parse_size_suffix.c</div><div>@@ -37=
,6 +37,11 @@ static struct valid_test_input valid_tests_inputs[] =3D {</div=
>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0&quot;, 0 },</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;1234&quot;, 1234 },</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x400&quot;, 1024 },</div><div>+ =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 { &quot;0X400&quot;, 1024 },</div><div>+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 { &quot;0x40a&quot;, 1034 },</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40b&quot;, 1035 },</div><div>+=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x40e&quot;, 1038 },</div><div>+ =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40f&quot;, 1039 },</div><div>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 { &quot;0300&quot;, 192 },</div><div>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;16k&quot;, 16384 },</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;128K&quot;, 131072 },</div><div>@@ -47,=
7 +52,7 @@ static struct valid_test_input valid_tests_inputs[] =3D {</div><=
div>=A0static const int num_valid_tests =3D sizeof(valid_tests_inputs) / si=
zeof(valid_tests_inputs[0]);</div>
<div>=A0</div><div>=A0/* Invalid test cases */</div><div>-static char *inva=
lid_tests_inputs[] =3D { &quot;&quot;, &quot;-1&quot;, &quot;k&quot;, &quot=
;4611686018427387904G&quot; };</div><div>+static char *invalid_tests_inputs=
[] =3D { &quot;&quot;, &quot;-1&quot;, &quot;k&quot;, &quot;08&quot;, &quot=
;09&quot;, &quot;4611686018427387904G&quot; };</div>
<div>=A0static const int num_invalid_tests =3D sizeof(invalid_tests_inputs)=
 / sizeof(invalid_tests_inputs[0]);</div><div>=A0</div><div>=A0static void =
test_utils_parse_size_suffix(void)</div></div><div><br></div><div>Thanks an=
d regards,<br>
Sandeep.</div><div><br></div><div><br></div></div><div class=3D"gmail_extra=
"><br><br><div class=3D"gmail_quote">On Thu, Apr 3, 2014 at 8:06 AM, David =
Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgoulet@efficios.com" target=
=3D"_blank">dgoulet@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 30 Mar (21:57:30), Sandee=
p K Chaudhary wrote:<br>
&gt; Hi David,<br>
&gt;<br>
&gt; Add the unit tests for the changes. Please have a look at the followin=
g<br>
&gt; diff for the changes in unit test file.<br>
&gt;<br>
&gt; 40,44d39<br>
&gt; &lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X400&quot;, 1024 },<br>
&gt; &lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x40a&quot;, 1034 },<br>
&gt; &lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40b&quot;, 1035 },<br>
&gt; &lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x40e&quot;, 1038 },<br>
&gt; &lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40f&quot;, 1039 },<br>
&gt; 55c50<br>
&gt; &lt; static char *invalid_tests_inputs[] =3D { &quot;&quot;, &quot;-1&=
quot;, &quot;k&quot;, &quot;08&quot;, &quot;09&quot;,<br>
&gt; &quot;4611686018427387904G&quot; };<br>
&gt; ---<br>
&gt; &gt; static char *invalid_tests_inputs[] =3D { &quot;&quot;, &quot;-1&=
quot;, &quot;k&quot;,<br>
&gt; &quot;4611686018427387904G&quot; };<br>
<br>
</div>Can you attach a diff patch to the issue please?<br>
<br>
Use &quot;git diff&quot; since the default &quot;diff&quot; command output =
is a bit<br>
unreadable for my passionate git eye :).<br>
<br>
Thanks!<br>
<div class=3D"HOEnZb"><div class=3D"h5">David<br>
<br>
&gt;<br>
&gt;<br>
&gt; Thanks and regards,<br>
&gt; Sandeep.<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Mar 25, 2014 at 7:22 AM, David Goulet &lt;<a href=3D"mailto:dg=
oulet@efficios.com">dgoulet@efficios.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On 21 Mar (00:22:57), Sandeep K Chaudhary wrote:<br>
&gt; &gt; &gt; Hi guys,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I checked the fix suggested in the bug description and it is=
 correct.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Changing<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ret =3D regcomp(&amp;regex,<br>
&gt; &gt; &quot;^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$&quot;, =
0);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; to<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ret =3D regcomp(&amp;regex,<br>
&gt; &gt; &gt; &quot;^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]=
?$&quot;,<br>
&gt; &gt; REG_EXTENDED);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; will take care of the following three problems that exist in=
 the first<br>
&gt; &gt; regex<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =A0 =A0- It accepts a leading 0 (without a following x or X)=
 to represent an<br>
&gt; &gt; &gt; =A0 =A0octal value, but simultaneously accepts the digits 8 =
and 9 in said<br>
&gt; &gt; octal<br>
&gt; &gt; &gt; =A0 =A0value (this yields -1).<br>
&gt; &gt; &gt; =A0 =A0- It does not support the leading 0X hexadecimal indi=
cator but does<br>
&gt; &gt; &gt; =A0 =A0support a leading 0x (see following).<br>
&gt; &gt; &gt; =A0 =A0- It accepts a leading 0x to represent an hexadecimal=
 value but<br>
&gt; &gt; rejects<br>
&gt; &gt; &gt; =A0 =A0the a..f and A..F digits in said value.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please let me know your views, and then I can submit a patch=
 for this.<br>
&gt; &gt;<br>
&gt; &gt; Unfortunately I don&#39;t speak regex well enough to tell you if =
this is<br>
&gt; &gt; absolutely correct but what you should do with your patch is add =
unit<br>
&gt; &gt; test(s) that fix the three problems you list here.<br>
&gt; &gt;<br>
&gt; &gt; Most probably in:<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 tests/unit/test_utils_parse_size_suffix.c<br>
&gt; &gt;<br>
&gt; &gt; Cheers!<br>
&gt; &gt; David<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks and regards,<br>
&gt; &gt; &gt; Sandeep.<br>
&gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; lttng-dev mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a><br>
&gt; &gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Thanks and regards,<br>
&gt; Sandeep K Chaudhary.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Thanks and regards,<br>Sandeep K Chaudhary.
</div>

--001a1135b82c62fde104f6951ba6--


--===============1986316603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1986316603==--
