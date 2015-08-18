From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: how do I print a value from an array of structs in
 a userspace tracepoint?
Date: Tue, 18 Aug 2015 13:01:23 -0400
Message-ID: <CA+jJMxtF10b0g=dy2hJmW3ie=MbHSiAZw5SydGL-u02Uz=zWnw__8456.26262384958$1439917377$gmane$org@mail.gmail.com>
References: <20150818080030.192debe5@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830931108=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZRkGP-0007zw-6S
 for lttng-dev@lists.lttng.org; Tue, 18 Aug 2015 13:01:38 -0400
Received: by ykdt205 with SMTP id t205so165033178ykd.1
 for <lttng-dev@lists.lttng.org>; Tue, 18 Aug 2015 10:01:23 -0700 (PDT)
In-Reply-To: <20150818080030.192debe5@tlielax.poochiereds.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, thomas.haynes@primarydata.com
List-Id: lttng-dev@lists.lttng.org

--===============1830931108==
Content-Type: multipart/alternative; boundary=001a11456cbc335ae0051d98dea7

--001a11456cbc335ae0051d98dea7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 8:00 AM, Jeff Layton <jlayton@poochiereds.net>
wrote:

> I'd like to add a tracepoint to my code that can walk a
> dynamically-sized array of structs and print one of the fields from
> each struct. For instance, suppose I have an array of structs that
> looks like this:
>
> struct foo
> {
>         int bar;
>         int baz;
>         ...
> }
>
> At the time of the tracepoint, I know the number of elements in the
> array and can pass that in. Is there any way to have lttng walk the
> array of structs and print out only the "bar" field from each?
>
> I've tried using ctf_sequence, but it doesn't seem to do the right
> thing. You can't tell it that you want to print out an "int" while
> walking an array of differently-sized objects.
>
>
Indeed, sequences assume elements are of the same type/size. That would,
presumably, be possible using variants, but they remain unsupported by the
current tracer implementations.

For now, you could serialize your fields to a dynamically-sized array and
extract this array using a ctf_sequence.

J=C3=A9r=C3=A9mie

Any help is appreciated!
> --
> Jeff Layton <jlayton@poochiereds.net>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11456cbc335ae0051d98dea7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 18, 2015 at 8:00 AM, Jeff Layton <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jlayton@poochiereds.net" target=3D"_blank">jlayton@poochiereds.n=
et</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I&#39;d like to =
add a tracepoint to my code that can walk a<br>
dynamically-sized array of structs and print one of the fields from<br>
each struct. For instance, suppose I have an array of structs that<br>
looks like this:<br>
<br>
struct foo<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int bar;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int baz;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
}<br>
<br>
At the time of the tracepoint, I know the number of elements in the<br>
array and can pass that in. Is there any way to have lttng walk the<br>
array of structs and print out only the &quot;bar&quot; field from each?<br=
>
<br>
I&#39;ve tried using ctf_sequence, but it doesn&#39;t seem to do the right<=
br>
thing. You can&#39;t tell it that you want to print out an &quot;int&quot; =
while<br>
walking an array of differently-sized objects.<br>
<br></blockquote><div><br></div><div>Indeed, sequences assume elements are =
of the same type/size. That would, presumably, be possible using variants, =
but they remain unsupported by the current tracer implementations.</div><di=
v><br></div><div>For now, you could serialize your fields to a dynamically-=
sized array and extract this array using a ctf_sequence.</div><div><br></di=
v><div>J=C3=A9r=C3=A9mie</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
Any help is appreciated!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Jeff Layton &lt;<a href=3D"mailto:jlayton@poochiereds.net">jlayton@poochier=
eds.net</a>&gt;<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a></div>
</div></div>

--001a11456cbc335ae0051d98dea7--


--===============1830931108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1830931108==--
