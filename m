From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Sun, 30 Mar 2014 21:57:30 -0700
Message-ID: <CAEEAEzVTQVNjbUVy007322WeAm1jrE50i6ePAPMaGnh5iM0KOw__27774.2971935824$1396241894$gmane$org@mail.gmail.com>
References: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw@mail.gmail.com>
 <20140325142250.GA7702@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1899528380=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <babbusandy2006@gmail.com>) id 1WUUHw-0004wf-5h
 for lttng-dev@lists.lttng.org; Mon, 31 Mar 2014 00:57:37 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so8525294qcx.27
 for <lttng-dev@lists.lttng.org>; Sun, 30 Mar 2014 21:57:30 -0700 (PDT)
In-Reply-To: <20140325142250.GA7702@thessa>
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

--===============1899528380==
Content-Type: multipart/alternative; boundary=001a11c2d200845e2c04f5dfe353

--001a11c2d200845e2c04f5dfe353
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

Add the unit tests for the changes. Please have a look at the following
diff for the changes in unit test file.

40,44d39
<               { "0X400", 1024 },
<               { "0x40a", 1034 },
<               { "0X40b", 1035 },
<               { "0x40e", 1038 },
<               { "0X40f", 1039 },
55c50
< static char *invalid_tests_inputs[] = { "", "-1", "k", "08", "09",
"4611686018427387904G" };
---
> static char *invalid_tests_inputs[] = { "", "-1", "k",
"4611686018427387904G" };


Thanks and regards,
Sandeep.


On Tue, Mar 25, 2014 at 7:22 AM, David Goulet <dgoulet@efficios.com> wrote:

> On 21 Mar (00:22:57), Sandeep K Chaudhary wrote:
> > Hi guys,
> >
> > I checked the fix suggested in the bug description and it is correct.
> >
> > Changing
> >
> > ret = regcomp(&regex,
> "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);
> >
> > to
> >
> > ret = regcomp(&regex,
> > "^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$",
> REG_EXTENDED);
> >
> > will take care of the following three problems that exist in the first
> regex
> >
> >
> >    - It accepts a leading 0 (without a following x or X) to represent an
> >    octal value, but simultaneously accepts the digits 8 and 9 in said
> octal
> >    value (this yields -1).
> >    - It does not support the leading 0X hexadecimal indicator but does
> >    support a leading 0x (see following).
> >    - It accepts a leading 0x to represent an hexadecimal value but
> rejects
> >    the a..f and A..F digits in said value.
> >
> >
> > Please let me know your views, and then I can submit a patch for this.
>
> Unfortunately I don't speak regex well enough to tell you if this is
> absolutely correct but what you should do with your patch is add unit
> test(s) that fix the three problems you list here.
>
> Most probably in:
>
>         tests/unit/test_utils_parse_size_suffix.c
>
> Cheers!
> David
>
> >
> > Thanks and regards,
> > Sandeep.
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


-- 
Thanks and regards,
Sandeep K Chaudhary.

--001a11c2d200845e2c04f5dfe353
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<div><br></div><div>Add the unit tests for the ch=
anges. Please have a look at the following diff for the changes in unit tes=
t file.</div><div><br></div><div><div>40,44d39</div><div>&lt; =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 { &quot;0X400&quot;, 1024 },</div>
<div>&lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x40a&quot;, 1034 },</div><di=
v>&lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40b&quot;, 1035 },</div><div>&=
lt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0x40e&quot;, 1038 },</div><div>&lt;=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { &quot;0X40f&quot;, 1039 },</div>
<div>55c50</div><div>&lt; static char *invalid_tests_inputs[] =3D { &quot;&=
quot;, &quot;-1&quot;, &quot;k&quot;, &quot;08&quot;, &quot;09&quot;, &quot=
;4611686018427387904G&quot; };</div><div>---</div><div>&gt; static char *in=
valid_tests_inputs[] =3D { &quot;&quot;, &quot;-1&quot;, &quot;k&quot;, &qu=
ot;4611686018427387904G&quot; };</div>
</div><div><br></div><div><br></div><div>Thanks and regards,<br>Sandeep.</d=
iv></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On T=
ue, Mar 25, 2014 at 7:22 AM, David Goulet <span dir=3D"ltr">&lt;<a href=3D"=
mailto:dgoulet@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 21 Mar (00:22:57), Sandee=
p K Chaudhary wrote:<br>
&gt; Hi guys,<br>
&gt;<br>
&gt; I checked the fix suggested in the bug description and it is correct.<=
br>
&gt;<br>
&gt; Changing<br>
&gt;<br>
&gt; ret =3D regcomp(&amp;regex, &quot;^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKM=
G]\\{0,1\\}\\)$&quot;, 0);<br>
&gt;<br>
&gt; to<br>
&gt;<br>
&gt; ret =3D regcomp(&amp;regex,<br>
&gt; &quot;^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$&quot;, =
REG_EXTENDED);<br>
&gt;<br>
&gt; will take care of the following three problems that exist in the first=
 regex<br>
&gt;<br>
&gt;<br>
</div>&gt; =A0 =A0- It accepts a leading 0 (without a following x or X) to =
represent an<br>
<div class=3D"">&gt; =A0 =A0octal value, but simultaneously accepts the dig=
its 8 and 9 in said octal<br>
</div>&gt; =A0 =A0value (this yields -1).<br>
&gt; =A0 =A0- It does not support the leading 0X hexadecimal indicator but =
does<br>
<div class=3D"">&gt; =A0 =A0support a leading 0x (see following).<br>
</div>&gt; =A0 =A0- It accepts a leading 0x to represent an hexadecimal val=
ue but rejects<br>
<div class=3D"">&gt; =A0 =A0the a..f and A..F digits in said value.<br>
&gt;<br>
&gt;<br>
&gt; Please let me know your views, and then I can submit a patch for this.=
<br>
<br>
</div>Unfortunately I don&#39;t speak regex well enough to tell you if this=
 is<br>
absolutely correct but what you should do with your patch is add unit<br>
test(s) that fix the three problems you list here.<br>
<br>
Most probably in:<br>
<br>
=A0 =A0 =A0 =A0 tests/unit/test_utils_parse_size_suffix.c<br>
<br>
Cheers!<br>
David<br>
<br>
&gt;<br>
&gt; Thanks and regards,<br>
&gt; Sandeep.<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Thanks and r=
egards,<br>Sandeep K Chaudhary.
</div>

--001a11c2d200845e2c04f5dfe353--


--===============1899528380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1899528380==--
