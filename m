From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [PATCH] lttng-tools: remove bogus argument from
	prove invocation
Date: Tue, 28 Oct 2014 00:15:31 -0400
Message-ID: <CAF4oYfF+AdUN79pQ8a_YVHcV4Ybw8bvxhf8moTfTYwxFevCGPg__11681.1437219896$1414469785$gmane$org@mail.gmail.com>
References: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
 <CAF4oYfEgNmiThfUW9Kj8+pYu-3QdE4KtUivr9mztf-Jb-=rocQ@mail.gmail.com>
 <544F1572.2040702@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1527370715=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1XiyC1-0002a1-My
 for lttng-dev@lists.lttng.org; Tue, 28 Oct 2014 00:15:40 -0400
Received: by mail-yk0-f173.google.com with SMTP id 131so959567ykp.18
 for <lttng-dev@lists.lttng.org>; Mon, 27 Oct 2014 21:15:32 -0700 (PDT)
In-Reply-To: <544F1572.2040702@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1527370715==
Content-Type: multipart/alternative; boundary=001a1139d682ea0afa050673e5b5

--001a1139d682ea0afa050673e5b5
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 28, 2014 at 12:02 AM, Nathan Lynch <Nathan_Lynch@mentor.com>
wrote:

> On 10/27/2014 09:38 PM, Jonathan Rajotte wrote:
> > Hey
> >
> > On Mon, Oct 27, 2014 at 10:00 PM, Nathan Lynch <nathan_lynch@mentor.com
> > <mailto:nathan_lynch@mentor.com>> wrote:
> >
> >     An argument of "$2" was added to the prove command line in
> >     tests/run.sh by 68270f0f604e "Mi test: Basic test structure".  This
> is
> >     harmless since run.sh is never called with more than one argument,
> but
> >
> >
> > The multiple arguments could be overcome by adding "" to the multiple
> > test files list but as you said it is confusing and error prone.
> >
> > This actually can be used to debug test with a "-v". Or add any basic
> > arguments to the prove command and was simply convenient at the time.If
> > this actually break patch from OE ( I assume OE stand for OpenEmbedded
> > and you are talking about this commit [1])  I'm okai with reverting the
> > change I introduced.
>
> I didn't intend to imply that upstream LTTng is responsible for keeping
> patches working in a downstream project like OE.  I mentioned OE because
> that's how my attention was drawn to this change.


Did not take it like that :)


>


> If the $2 argument has a legitimate use, I suggest that it be made a bit
> more clear since 1) the commit that introduced it didn't mention it at
> all, and 2) no code in-tree actually makes use of the extra argument.
>
> I figured it was likely a mistake.
>

Which kind of was. This wasn't supposed to be merge and was a mistake on my
part when formatting the patch. It was discussed with David before merging
and we decided to keep it since it was not harmful or *used* and proved
useful. But with the effect it has and unwanted repercussion(confusion,
missing mention in commit etc.) it seems not every aspect where evaluated.
Hence I don't mind this patch and almost welcome it.

Cheers!
-- 
Jonathan R.Julien

--001a1139d682ea0afa050673e5b5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 28, 2014 at 12:02 AM, Nathan Lynch <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:Nathan_Lynch@mentor.com" target=3D"_blank">Nathan_Lynch@men=
tor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On 10/27/2014 09:38 PM, Jonathan Rajotte wrote:<br>
&gt; Hey<br>
&gt;<br>
&gt; On Mon, Oct 27, 2014 at 10:00 PM, Nathan Lynch &lt;<a href=3D"mailto:n=
athan_lynch@mentor.com">nathan_lynch@mentor.com</a><br>
</span><span class=3D"">&gt; &lt;mailto:<a href=3D"mailto:nathan_lynch@ment=
or.com">nathan_lynch@mentor.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0An argument of &quot;$2&quot; was added to the prov=
e command line in<br>
&gt;=C2=A0 =C2=A0 =C2=A0tests/run.sh by 68270f0f604e &quot;Mi test: Basic t=
est structure&quot;.=C2=A0 This is<br>
&gt;=C2=A0 =C2=A0 =C2=A0harmless since run.sh is never called with more tha=
n one argument, but<br>
&gt;<br>
&gt;<br>
&gt; The multiple arguments could be overcome by adding &quot;&quot; to the=
 multiple<br>
&gt; test files list but as you said it is confusing and error prone.<br>
&gt;<br>
&gt; This actually can be used to debug test with a &quot;-v&quot;. Or add =
any basic<br>
&gt; arguments to the prove command and was simply convenient at the time.I=
f<br>
&gt; this actually break patch from OE ( I assume OE stand for OpenEmbedded=
<br>
&gt; and you are talking about this commit [1])=C2=A0 I&#39;m okai with rev=
erting the<br>
&gt; change I introduced.<br>
<br>
</span>I didn&#39;t intend to imply that upstream LTTng is responsible for =
keeping<br>
patches working in a downstream project like OE.=C2=A0 I mentioned OE becau=
se<br>
that&#39;s how my attention was drawn to this change.</blockquote><div><br>=
</div><div>Did not take it like that :)</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If the $2 argument has a legitimate use, I suggest that it be made a bit<br=
>
more clear since 1) the commit that introduced it didn&#39;t mention it at<=
br>
all, and 2) no code in-tree actually makes use of the extra argument.<br>
<br>
I figured it was likely a mistake.<br></blockquote><div><br></div><div>Whic=
h kind of was. This wasn&#39;t supposed to be merge and was a mistake on my=
 part when formatting the patch. It was discussed with David before merging=
 and we decided to keep it since it was not harmful or *used* and proved us=
eful. But with the effect it has and unwanted repercussion(confusion, missi=
ng mention in commit etc.) it seems not every aspect where evaluated. Hence=
 I don&#39;t mind this patch and almost welcome it.</div></div><br clear=3D=
"all"><div>Cheers!</div>-- <br><div dir=3D"ltr">Jonathan R.Julien</div>
</div></div>

--001a1139d682ea0afa050673e5b5--


--===============1527370715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1527370715==--
