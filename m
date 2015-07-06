From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Lttng Soft Hang issue
Date: Mon, 6 Jul 2015 11:23:38 -0400
Message-ID: <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w__9195.41734406284$1436196305$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809540864=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZC8FE-00082z-Dp
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 11:23:52 -0400
Received: by pdbdz6 with SMTP id dz6so12535944pdb.0
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jul 2015 08:23:38 -0700 (PDT)
In-Reply-To: <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aravind HT <aravind.ht@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1809540864==
Content-Type: multipart/alternative; boundary=047d7bdca8767359f9051a367d85

--047d7bdca8767359f9051a367d85
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

What do you observe when this happens? Does the session daemon become
unresponsive?

J=C3=A9r=C3=A9mie

On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> Request someone to kindly help with this. Blocked at this point, unable t=
o
> continue as any application crash leads to lttng not working.
>
> Thanks,
> Aravind.
>
> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>
>> Hi,
>>
>>
>>
>> I have recently started trying lttng 2.6 for a few applications on my
>> Ubuntu 12.04 and I noticed that the health check on sessiond and consume=
rd
>> failed soon after starting the session.
>>
>>
>> On investigating, I found that thread_manage_consumer() had exited
>> causing an overall health check failure.
>>
>>
>> Here are the sequence of steps that I found contributed to
>> *thread_manage_consumer()* exiting.
>>
>>
>> 1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)* i=
s
>> being called. This happens when there is an error detected by *revents =
=3D
>> LTTNG_POLL_GETEV(&events, i)*
>>
>> My initial guess here is that as one of my apps has crashed, producing a=
 *LPOLLERR
>> | LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()* causing
>> *ust_app_unregister()* to be called for that app.
>>
>>
>>
>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is set*.=
*
>>
>>
>>
>> (2.a) Note:* close_metadata() *also calls* consumer_close_metadata() *wh=
ich
>> sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>> consumerd to stop it from further dealing with the concerned app. Someho=
w
>> this doesn=E2=80=99t seem to help*.*
>>
>>
>>
>> 3.       Next, I see that the *thread_manage_consumer():1353* for some
>> reason has ignored the above 2.a and gets to do request/reply for that a=
pp
>> by calling*ust_consumer_metadata_request():491 ->
>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
>> *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>
>>
>>
>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
>> *thread_manage_consumer():1353* at which point *thread_manage_consumer()=
* decides
>> to exit causing health_check() to fail.
>>
>>
>>
>>
>>
>> So it looks like under some scenario, an application crash could cause
>> the lttng some problems.
>>
>>
>>
>> I think a possible fix for this scenario, is to instead of 4, send an
>> *ERROR* message back to *consumerd()* . This could be done from
>> *ust_consumer_metadata_request()* call. Can someone please let me know
>> if this is correct and shed more light on the issue ?
>>
>>
>>
>>
>>
>> Please forgive if there are any guideline omissions for posting here fro=
m
>> my part. This is my first post.
>>
>>
>> Regards,
>>
>> Aravind.
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bdca8767359f9051a367d85
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>What do you observe when this happe=
ns? Does the session daemon become unresponsive?</div><div><br></div><div>J=
=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Wed, May 27, 2015 at 6:19 AM, Aravind HT <span dir=3D"ltr">&l=
t;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmai=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"l=
tr">Request someone to kindly help with this. Blocked at this point, unable=
 to continue as any application crash leads to lttng not working.<div><br><=
/div><div>Thanks,</div><div>Aravind.</div></div><div class=3D"HOEnZb"><div =
class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On T=
hu, May 21, 2015 at 12:18 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Hi,</p><p class=3D"Ms=
oNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">I have recently started trying=
 lttng 2.6 for a few applications on my Ubuntu 12.04 and I noticed that the=
 health check on sessiond and consumerd failed soon after starting the sess=
ion.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br><=
/p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">On investi=
gating, I found that thread_manage_consumer() had exited causing an overall=
 health check failure.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000=
001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:12.800000190=
7349px">Here are the sequence of steps that I found contributed to=C2=A0<b>=
thread_manage_consumer()</b>=C2=A0exiting.</p><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px"></p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px"><br></p><p style=3D"font-size:12.8000001907349px">=
1.<span style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times N=
ew Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>=
thread_manage_apps() : 1558 , ust_app_unregister(pollfd)</b>=C2=A0is being =
called. This happens when there is an error detected by=C2=A0<b>revents =3D=
 LTTNG_POLL_GETEV(&amp;events, i)</b></p><p style=3D"font-size:12.800000190=
7349px">My initial guess here is that as one of my apps has crashed, produc=
ing a=C2=A0<b>LPOLLERR | LPOLLHUP | LPOLLRDHUP=C2=A0</b>to be generated for=
=C2=A0<b>epoll()</b>=C2=A0causing=C2=A0<b>ust_app_unregister()</b>=C2=A0to =
be called for that app.</p><p style=3D"font-size:12.8000001907349px">=C2=A0=
</p><p style=3D"font-size:12.8000001907349px">2.<span style=3D"font-stretch=
:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>ust_app_unregister():3154 ,=
 close_metadata(registry, ua_sess-&gt;consumer)=C2=A0=C2=A0</b>in which<b>=
=C2=A0registry-&gt;metadata_closed =3D 1=C2=A0</b>is set<b>.</b></p><p styl=
e=3D"font-size:12.8000001907349px;text-indent:0.5in">=C2=A0</p><p style=3D"=
font-size:12.8000001907349px;text-indent:0.5in">(2.a) Note:<b>=C2=A0close_m=
etadata()=C2=A0</b>also calls<b>=C2=A0consumer_close_metadata()=C2=A0</b>wh=
ich sends<b>=C2=A0LTTNG_CONSUMER_CLOSE_METADATA=C2=A0</b>and<b>=C2=A0metada=
ta_key=C2=A0</b>to the consumerd to stop it from further dealing with the c=
oncerned app. Somehow this doesn=E2=80=99t seem to help<b>.</b></p><p style=
=3D"font-size:12.8000001907349px"><b>=C2=A0</b></p><p style=3D"font-size:12=
.8000001907349px">3.<span style=3D"font-stretch:normal;font-size:7pt;font-f=
amily:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
</span>Next, I see that the=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0=
for some reason has ignored the above 2.a and gets to do request/reply for =
that app by calling<b>ust_consumer_metadata_request():491 -&gt; ust_app_pus=
h_metadat(ust_reg, socket,1)=C2=A0</b>which at line 460 checks for=C2=A0<b>=
registry-&gt;metadata_closed</b>=C2=A0and returns an=C2=A0<b>=E2=80=93EPIPE=
</b></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=
=A0</p><p style=3D"font-size:12.8000001907349px">4.<span style=3D"font-stre=
tch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=
=A0error cascades all the way back up to=C2=A0<b>thread_manage_consumer():1=
353</b>=C2=A0at which point=C2=A0<b>thread_manage_consumer()</b>=C2=A0decid=
es to exit causing health_check() to fail.</p><p style=3D"font-size:12.8000=
001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001=
907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907=
349px">So it looks like under some scenario, an application crash could cau=
se the lttng some problems.</p><p class=3D"MsoNormal" style=3D"font-size:12=
.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.80=
00001907349px">I think a possible fix for this scenario, is to instead of 4=
, send an=C2=A0<b>ERROR</b>=C2=A0message back to=C2=A0<b>consumerd()</b>=C2=
=A0. This could be done from=C2=A0<b>ust_consumer_metadata_request()</b>=C2=
=A0call. Can someone please let me know if this is correct and shed more li=
ght on the issue ?</p><p class=3D"MsoNormal" style=3D"font-size:12.80000019=
07349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.80000019073=
49px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349p=
x">Please forgive if there are any guideline omissions for posting here fro=
m my part. This is my first post.</p><p class=3D"MsoNormal" style=3D"font-s=
ize:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:1=
2.8000001907349px">Regards,</p><p class=3D"MsoNormal" style=3D"font-size:12=
.8000001907349px">Aravind.</p></div>
</blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--047d7bdca8767359f9051a367d85--


--===============1809540864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1809540864==--
