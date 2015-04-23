From: Chidhu R <chid1989@gmail.com>
Subject: Re: Trace to console
Date: Thu, 23 Apr 2015 12:01:43 -0700
Message-ID: <CAL1ZhOOavOfBXOqJ1hxD-WSV+FTMRX_AZ-vT0vsC0QfYYbgShA__18179.4828888544$1429815863$gmane$org@mail.gmail.com>
References: <CAL1ZhONFm1+bXP_j4X=kUKnsQFaqTqdVTY-Cc_uY4Ni-Ok-LiQ@mail.gmail.com>
 <CA+jJMxvroXRJuEtHgdJiCP7Y4HWK32RqNSyk6+ubqeQ3xH7i9A@mail.gmail.com>
 <CAL1ZhOO=w0rCAcEf5StxWe1tk95Vy-L9WVwxjbSxQXKO7L0BEw@mail.gmail.com>
 <CAL1ZhOPtw4iPv0tiEtd4uMjt1sRFFdYSztNDGywD-kLDO-v-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1747841269=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f43.google.com ([209.85.215.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1YlMOM-0000SP-0d
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 15:02:38 -0400
Received: by lagv1 with SMTP id v1so19640263lag.3
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2015 12:02:24 -0700 (PDT)
In-Reply-To: <CAL1ZhOPtw4iPv0tiEtd4uMjt1sRFFdYSztNDGywD-kLDO-v-hg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1747841269==
Content-Type: multipart/alternative; boundary=001a11c235dc88ca72051468eb9f

--001a11c235dc88ca72051468eb9f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok. I will try the live mode. Looks like it will solve the purpose.

On Thu, Apr 23, 2015 at 11:58 AM, Chidhu R <chid1989@gmail.com> wrote:

> Also, is there a way to redirect all tracepoints to console instead of
> selective?
>
> On Thu, Apr 23, 2015 at 11:14 AM, Chidhu R <chid1989@gmail.com> wrote:
>
>> Thanks Jeremie.
>>
>> On Tue, Apr 21, 2015 at 5:27 PM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> Hi Chidhu,
>>>
>>> LTTng does not support selective output of tracepoints to the console.
>>> The closest thing I can recommend is using the "live" mode locally.
>>>
>>> J=C3=A9r=C3=A9mie
>>>
>>> On Mon, Apr 20, 2015 at 3:58 PM, Chidhu R <chid1989@gmail.com> wrote:
>>> > Hello,
>>> >
>>> > I was looking for a way to trace to console rather than save to disk =
/
>>> > stream. I read about lttng tracef feature. But it does not include th=
e
>>> wide
>>> > range of benefits brought by tracepoints. So what I want is to use th=
e
>>> > tracepoints and trace to console instead. For example, if there are 5
>>> > tracepoint events, I want to trace 3 of them to console and let the
>>> other go
>>> > the disk or whatever. How to achieve this.
>>> >
>>> > Thanks
>>> > Chid
>>> >
>>> > _______________________________________________
>>> > lttng-dev mailing list
>>> > lttng-dev@lists.lttng.org
>>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>> >
>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>

--001a11c235dc88ca72051468eb9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok. I will try the live mode. Looks like it will solve the=
 purpose.=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Apr 23, 2015 at 11:58 AM, Chidhu R <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:chid1989@gmail.com" target=3D"_blank">chid1989@gmail.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Also, is=
 there a way to redirect all tracepoints to console instead of selective?</=
div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Thu, Apr 23, 2015 at 11:14 AM, Chidhu R <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:chid1989@gmail.com" target=3D"_blank">ch=
id1989@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"ltr">Thanks Jeremie.</div><div><div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Tue, Apr 21, 2015 at 5:27 PM, J=C3=A9r=C3=
=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@=
efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi Chidhu,<br>
<br>
LTTng does not support selective output of tracepoints to the console.<br>
The closest thing I can recommend is using the &quot;live&quot; mode locall=
y.<br>
<br>
J=C3=A9r=C3=A9mie<br>
<div><div><br>
On Mon, Apr 20, 2015 at 3:58 PM, Chidhu R &lt;<a href=3D"mailto:chid1989@gm=
ail.com" target=3D"_blank">chid1989@gmail.com</a>&gt; wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I was looking for a way to trace to console rather than save to disk /=
<br>
&gt; stream. I read about lttng tracef feature. But it does not include the=
 wide<br>
&gt; range of benefits brought by tracepoints. So what I want is to use the=
<br>
&gt; tracepoints and trace to console instead. For example, if there are 5<=
br>
&gt; tracepoint events, I want to trace 3 of them to console and let the ot=
her go<br>
&gt; the disk or whatever. How to achieve this.<br>
&gt;<br>
&gt; Thanks<br>
&gt; Chid<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a11c235dc88ca72051468eb9f--


--===============1747841269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1747841269==--
