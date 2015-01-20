From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Sequence of strings
Date: Tue, 20 Jan 2015 09:52:15 -0500
Message-ID: <CAC6yHM69o8LsEJJUMy3yVSzMQAAPQztTXv6zaKNP225G1kYE5w__44153.250862337$1421765585$gmane$org@mail.gmail.com>
References: <CAC6yHM74MO8UN7d8B2WLj0EM8mZuhJLiaudGoSMDmNDOSwDa3A@mail.gmail.com>
 <CAB4xu_3RVyy3R_rypKh7NdTD=hUaweBj=kQ5x+ZaOcu+M9oVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0892400528=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YDaAG-0002kS-Q8
 for lttng-dev@lists.lttng.org; Tue, 20 Jan 2015 09:52:25 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so8275083qgd.11
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jan 2015 06:52:15 -0800 (PST)
In-Reply-To: <CAB4xu_3RVyy3R_rypKh7NdTD=hUaweBj=kQ5x+ZaOcu+M9oVLQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0892400528==
Content-Type: multipart/alternative; boundary=001a11c29762afa320050d169590

--001a11c29762afa320050d169590
Content-Type: text/plain; charset=UTF-8

Thanks Philippe, I confirm that it works as you suggested.

metadata:

event {
name = "foo";
id = 0;
stream_id = 0;
fields := struct {
uint32_t _len; /* byte len */
uint8_t _num; /* number of strings */
string _mgs[_num]; /* concatenated strings (byte array) */
};
};

code:
        char *msg = "a\0bb\0ccc\0";
        int len = 9;
        int num = 3;
        barectf_trace_foo(pctx, len, num, msg);

And the output of babeltrace:

[18:32:19.663305604] (+?.?????????) foo: { }, { len = 9, num = 3, mgs = [
[0] = "a", [1] = "bb", [2] = "ccc" ] }

I also tried the same trick with a struct, and it seems to work:

metadata:

struct blob {
string _one;
string _two;
};

event {
name = "bar";
id = 1;
stream_id = 0;
fields := struct {
uint32_t _len; /* byte len */
uint8_t _num; /* number of structs */
struct blob _data[_num]; /* byte array */
};
};

code:
msg = "aa\0bb\0cc\0dd\0";
len = 12;
num = 2;
barectf_trace_bar(pctx, len, num, msg);

babeltrace output:

[18:40:37.695057872] (+0.000002364) bar: { }, { len = 12, num = 2, data = [
[0] = { one = "aa", two = "bb" }, [1] = { one = "cc", two = "dd" } ] }


Cheers!

Francis

2015-01-19 19:16 GMT-05:00 Philippe Proulx <eeppeliteloop@gmail.com>:

> On Mon, Jan 19, 2015 at 5:50 PM, Francis Giraldeau
> <francis.giraldeau@gmail.com> wrote:
> >
> > Hi,
> >
> > I would like to record a sequence of strings. Here is an example:
> >
> > struct foo {
> >   string _my_string;
> > };
> >
> > event {
> >   ...
> >   fields := struct {
> >     uint8_t _num;
> >     struct foo _items[_num];
> >   };
> > };
> >
> > The program barectf does not allow it, and I wanted to know whether it's
> an implementation limitation or if CTF supports it at all.
>
> Hi Francis,
>
> CTF and Babeltrace certainly allow this.
>
> It's a current barectf limitation: inner structures, as well as
> array/sequence
> elements must have a fixed size. This is because they are currently copied
> to the packet buffer as is using memcpy() with this precomputed fixed size.
>
> Your best approach today is to precompute the total length of all the
> concatenated strings (including terminating null characters) in your
> application
> code, and use a sequence of bytes instead, also keeping the original number
> of strings:
>
>     event {
>       ...
>       fields := struct {
>         uint32_t _len; /* length of all strings */
>         uint8_t _num; /* number of concatenated strings */
>         uint8_t _strings[_len];
>       };
>     };
>
> Then, after running barectf, change this for:
>
>     event {
>       ...
>       fields := struct {
>         uint32_t _len;
>         uint8_t _num;
>         string _strings[_num];
>       };
>     };
>
> and you should be able to see a sequence of strings in Babeltrace once
> your streams are produced by barectf C code.
>
> Ugly, but should work!
>
> Supporting variable-length inner structures and array/sequence elements
> is definitely on the TODO list for a future barectf release.
>
> Thanks for the input,
> Phil
>
> >
> > Thanks,
> >
> > Francis
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--001a11c29762afa320050d169590
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Philippe, I confirm that it works as you sugge=
sted.</div><div><br></div><div>metadata:</div><div><br></div><div><div>even=
t {</div><div><span class=3D"" style=3D"white-space:pre">	</span>name =3D &=
quot;foo&quot;;</div><div><span class=3D"" style=3D"white-space:pre">	</spa=
n>id =3D 0;</div><div><span class=3D"" style=3D"white-space:pre">	</span>st=
ream_id =3D 0;</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>fields :=3D struct {</div><div><span class=3D"" style=3D"white-space:pre">=
		</span>uint32_t _len;<span class=3D"" style=3D"white-space:pre">		</span>=
/* byte len */</div><div><span class=3D"" style=3D"white-space:pre">		</spa=
n>uint8_t _num;<span class=3D"" style=3D"white-space:pre">		</span>/* numbe=
r of strings */</div><div><span class=3D"" style=3D"white-space:pre">		</sp=
an>string _mgs[_num];<span class=3D"" style=3D"white-space:pre">	</span>/* =
concatenated strings (byte array) */</div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>};</div><div>};</div></div><div><br></div><div>code:=
<br></div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *msg =3D &quot;a\0bb\0=
ccc\0&quot;;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 9;</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int num =3D 3;</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 barectf_trace_foo(pctx, len, num, msg);</div></div><div><br></div><d=
iv>And the output of babeltrace:</div><div><br></div><div>[18:32:19.6633056=
04] (+?.?????????) foo: { }, { len =3D 9, num =3D 3, mgs =3D [ [0] =3D &quo=
t;a&quot;, [1] =3D &quot;bb&quot;, [2] =3D &quot;ccc&quot; ] }</div><div><b=
r></div><div>I also tried the same trick with a struct, and it seems to wor=
k:</div><div><br></div><div>metadata:</div><div><br></div><div><div>struct =
blob {</div><div><span class=3D"" style=3D"white-space:pre">	</span>string =
_one;</div><div><span class=3D"" style=3D"white-space:pre">	</span>string _=
two;</div><div>};</div><div><br></div><div>event {</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>name =3D &quot;bar&quot;;</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>id =3D 1;</div><div><span =
class=3D"" style=3D"white-space:pre">	</span>stream_id =3D 0;</div><div><sp=
an class=3D"" style=3D"white-space:pre">	</span>fields :=3D struct {</div><=
div><span class=3D"" style=3D"white-space:pre">		</span>uint32_t _len;<span=
 class=3D"" style=3D"white-space:pre">		</span>/* byte len */</div><div><sp=
an class=3D"" style=3D"white-space:pre">		</span>uint8_t _num;<span class=
=3D"" style=3D"white-space:pre">		</span>/* number of structs */</div><div>=
<span class=3D"" style=3D"white-space:pre">		</span>struct blob _data[_num]=
;<span class=3D"" style=3D"white-space:pre">	</span>/* byte array */</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>};</div><div>};</div=
></div><div><br></div><div>code:</div><div><div><span class=3D"" style=3D"w=
hite-space:pre">	</span>msg =3D &quot;aa\0bb\0cc\0dd\0&quot;;</div><div><sp=
an class=3D"" style=3D"white-space:pre">	</span>len =3D 12;</div><div><span=
 class=3D"" style=3D"white-space:pre">	</span>num =3D 2;</div><div><span cl=
ass=3D"" style=3D"white-space:pre">	</span>barectf_trace_bar(pctx, len, num=
, msg);</div></div><div><br></div><div>babeltrace output:</div><div><br></d=
iv><div><div>[18:40:37.695057872] (+0.000002364) bar: { }, { len =3D 12, nu=
m =3D 2, data =3D [ [0] =3D { one =3D &quot;aa&quot;, two =3D &quot;bb&quot=
; }, [1] =3D { one =3D &quot;cc&quot;, two =3D &quot;dd&quot; } ] }</div></=
div><div><br></div><div><br></div><div>Cheers!</div><div><br></div><div>Fra=
ncis</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2=
015-01-19 19:16 GMT-05:00 Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"=
mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@gmail.com</=
a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div=
 class=3D"h5">On Mon, Jan 19, 2015 at 5:50 PM, Francis Giraldeau<br>
&lt;<a href=3D"mailto:francis.giraldeau@gmail.com">francis.giraldeau@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I would like to record a sequence of strings. Here is an example:<br>
&gt;<br>
&gt; struct foo {<br>
&gt;=C2=A0 =C2=A0string _my_string;<br>
&gt; };<br>
&gt;<br>
&gt; event {<br>
&gt;=C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0fields :=3D struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t _num;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct foo _items[_num];<br>
&gt;=C2=A0 =C2=A0};<br>
&gt; };<br>
&gt;<br>
&gt; The program barectf does not allow it, and I wanted to know whether it=
&#39;s an implementation limitation or if CTF supports it at all.<br>
<br>
</div></div>Hi Francis,<br>
<br>
CTF and Babeltrace certainly allow this.<br>
<br>
It&#39;s a current barectf limitation: inner structures, as well as array/s=
equence<br>
elements must have a fixed size. This is because they are currently copied<=
br>
to the packet buffer as is using memcpy() with this precomputed fixed size.=
<br>
<br>
Your best approach today is to precompute the total length of all the<br>
concatenated strings (including terminating null characters) in your applic=
ation<br>
code, and use a sequence of bytes instead, also keeping the original number=
<br>
of strings:<br>
<span class=3D""><br>
=C2=A0 =C2=A0 event {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 fields :=3D struct {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t _len; /* length of all strings =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t _num; /* number of concatenated strings=
 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t _strings[_len];<br>
=C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 };<br>
<br>
Then, after running barectf, change this for:<br>
<span class=3D""><br>
=C2=A0 =C2=A0 event {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 fields :=3D struct {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t _len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t _num;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 string _strings[_num];<br>
=C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0 =C2=A0 };<br>
<br>
and you should be able to see a sequence of strings in Babeltrace once<br>
your streams are produced by barectf C code.<br>
<br>
Ugly, but should work!<br>
<br>
Supporting variable-length inner structures and array/sequence elements<br>
is definitely on the TODO list for a future barectf release.<br>
<br>
Thanks for the input,<br>
Phil<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Francis<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</blockquote></div><br></div>

--001a11c29762afa320050d169590--


--===============0892400528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0892400528==--
