From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Lttng Soft Hang issue
Date: Mon, 6 Jul 2015 12:42:54 -0400
Message-ID: <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA__6457.28324675492$1436201204$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589405757=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZC9Tw-0008W5-D5
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 12:43:10 -0400
Received: by pdbdz6 with SMTP id dz6so13641517pdb.0
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jul 2015 09:42:54 -0700 (PDT)
In-Reply-To: <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
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

--===============0589405757==
Content-Type: multipart/alternative; boundary=001a11c326e2ecb9cb051a3798da

--001a11c326e2ecb9cb051a3798da
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Would you mind testing Mathieu's patch?

I have rebased it on stable-2.6:
git clone https://github.com/jgalar/lttng-tools.git -b hang-fix

Thanks,
J=C3=A9r=C3=A9mie=EF=BF=BC


On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi,
>
> What do you observe when this happens? Does the session daemon become
> unresponsive?
>
> J=C3=A9r=C3=A9mie
>
> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com> wrote:
>
>> Request someone to kindly help with this. Blocked at this point, unable
>> to continue as any application crash leads to lttng not working.
>>
>> Thanks,
>> Aravind.
>>
>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>> wrote:
>>
>>> Hi,
>>>
>>>
>>>
>>> I have recently started trying lttng 2.6 for a few applications on my
>>> Ubuntu 12.04 and I noticed that the health check on sessiond and consum=
erd
>>> failed soon after starting the session.
>>>
>>>
>>> On investigating, I found that thread_manage_consumer() had exited
>>> causing an overall health check failure.
>>>
>>>
>>> Here are the sequence of steps that I found contributed to
>>> *thread_manage_consumer()* exiting.
>>>
>>>
>>> 1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)* =
is
>>> being called. This happens when there is an error detected by *revents
>>> =3D LTTNG_POLL_GETEV(&events, i)*
>>>
>>> My initial guess here is that as one of my apps has crashed, producing =
a *LPOLLERR
>>> | LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()* causing
>>> *ust_app_unregister()* to be called for that app.
>>>
>>>
>>>
>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is set*=
.*
>>>
>>>
>>>
>>> (2.a) Note:* close_metadata() *also calls* consumer_close_metadata() *w=
hich
>>> sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>> consumerd to stop it from further dealing with the concerned app. Someh=
ow
>>> this doesn=E2=80=99t seem to help*.*
>>>
>>>
>>>
>>> 3.       Next, I see that the *thread_manage_consumer():1353* for some
>>> reason has ignored the above 2.a and gets to do request/reply for that =
app
>>> by calling*ust_consumer_metadata_request():491 ->
>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
>>> *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>
>>>
>>>
>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
>>> *thread_manage_consumer():1353* at which point
>>> *thread_manage_consumer()* decides to exit causing health_check() to
>>> fail.
>>>
>>>
>>>
>>>
>>>
>>> So it looks like under some scenario, an application crash could cause
>>> the lttng some problems.
>>>
>>>
>>>
>>> I think a possible fix for this scenario, is to instead of 4, send an
>>> *ERROR* message back to *consumerd()* . This could be done from
>>> *ust_consumer_metadata_request()* call. Can someone please let me know
>>> if this is correct and shed more light on the issue ?
>>>
>>>
>>>
>>>
>>>
>>> Please forgive if there are any guideline omissions for posting here
>>> from my part. This is my first post.
>>>
>>>
>>> Regards,
>>>
>>> Aravind.
>>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c326e2ecb9cb051a3798da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Would you mind testing Mathieu&#39;s patch?<div><br></div>=
<div>I have rebased it on stable-2.6:</div><div><div>git clone <a href=3D"h=
ttps://github.com/jgalar/lttng-tools.git">https://github.com/jgalar/lttng-t=
ools.git</a> -b hang-fix<br></div></div><div><br></div><div><div>Thanks,</d=
iv><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div></div><div><br></div></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 11=
:23 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto=
:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@effici=
os.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr">Hi,<div><br></div><div>What do you observe when this happens? Does the=
 session daemon become unresponsive?</div><div><br></div><div>J=C3=A9r=C3=
=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
><div><div class=3D"h5">On Wed, May 27, 2015 at 6:19 AM, Aravind HT <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">ar=
avind.ht@gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div><div class=3D"h5"><div dir=3D"ltr">Request someone to ki=
ndly help with this. Blocked at this point, unable to continue as any appli=
cation crash leads to lttng not working.<div><br></div><div>Thanks,</div><d=
iv>Aravind.</div></div><div><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, May 21, 2015 at 12:18 AM, Aravind HT <span dir=3D"=
ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.=
ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div d=
ir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Hi=
,</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</=
p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I have rece=
ntly started trying lttng 2.6 for a few applications on my Ubuntu 12.04 and=
 I noticed that the health check on sessiond and consumerd failed soon afte=
r starting the session.</p><p class=3D"MsoNormal" style=3D"font-size:12.800=
0001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:12.80000019=
07349px">On investigating, I found that thread_manage_consumer() had exited=
 causing an overall health check failure.</p><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"f=
ont-size:12.8000001907349px">Here are the sequence of steps that I found co=
ntributed to=C2=A0<b>thread_manage_consumer()</b>=C2=A0exiting.</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px"></p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px"><br></p><p style=3D"font-size:=
12.8000001907349px">1.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0</span>In=C2=A0<b>thread_manage_apps() : 1558 , ust_app_unregister(pollf=
d)</b>=C2=A0is being called. This happens when there is an error detected b=
y=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&amp;events, i)</b></p><p style=3D"f=
ont-size:12.8000001907349px">My initial guess here is that as one of my app=
s has crashed, producing a=C2=A0<b>LPOLLERR | LPOLLHUP | LPOLLRDHUP=C2=A0</=
b>to be generated for=C2=A0<b>epoll()</b>=C2=A0causing=C2=A0<b>ust_app_unre=
gister()</b>=C2=A0to be called for that app.</p><p style=3D"font-size:12.80=
00001907349px">=C2=A0</p><p style=3D"font-size:12.8000001907349px">2.<span =
style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman=
&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>ust_app_=
unregister():3154 , close_metadata(registry, ua_sess-&gt;consumer)=C2=A0=C2=
=A0</b>in which<b>=C2=A0registry-&gt;metadata_closed =3D 1=C2=A0</b>is set<=
b>.</b></p><p style=3D"font-size:12.8000001907349px;text-indent:0.5in">=C2=
=A0</p><p style=3D"font-size:12.8000001907349px;text-indent:0.5in">(2.a) No=
te:<b>=C2=A0close_metadata()=C2=A0</b>also calls<b>=C2=A0consumer_close_met=
adata()=C2=A0</b>which sends<b>=C2=A0LTTNG_CONSUMER_CLOSE_METADATA=C2=A0</b=
>and<b>=C2=A0metadata_key=C2=A0</b>to the consumerd to stop it from further=
 dealing with the concerned app. Somehow this doesn=E2=80=99t seem to help<=
b>.</b></p><p style=3D"font-size:12.8000001907349px"><b>=C2=A0</b></p><p st=
yle=3D"font-size:12.8000001907349px">3.<span style=3D"font-stretch:normal;f=
ont-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0</span>Next, I see that the=C2=A0<b>thread_manage_cons=
umer():1353</b>=C2=A0for some reason has ignored the above 2.a and gets to =
do request/reply for that app by calling<b>ust_consumer_metadata_request():=
491 -&gt; ust_app_push_metadat(ust_reg, socket,1)=C2=A0</b>which at line 46=
0 checks for=C2=A0<b>registry-&gt;metadata_closed</b>=C2=A0and returns an=
=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"MsoNormal" style=3D"font-size:12=
.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8000001907349px">4.<sp=
an style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New Ro=
man&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>This=C2=A0<b>=E2=
=80=93EPIPE</b>=C2=A0error cascades all the way back up to=C2=A0<b>thread_m=
anage_consumer():1353</b>=C2=A0at which point=C2=A0<b>thread_manage_consume=
r()</b>=C2=A0decides to exit causing health_check() to fail.</p><p style=3D=
"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"fo=
nt-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">So it looks like under some scenario, an applicati=
on crash could cause the lttng some problems.</p><p class=3D"MsoNormal" sty=
le=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px">I think a possible fix for this scenario,=
 is to instead of 4, send an=C2=A0<b>ERROR</b>=C2=A0message back to=C2=A0<b=
>consumerd()</b>=C2=A0. This could be done from=C2=A0<b>ust_consumer_metada=
ta_request()</b>=C2=A0call. Can someone please let me know if this is corre=
ct and shed more light on the issue ?</p><p class=3D"MsoNormal" style=3D"fo=
nt-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-siz=
e:12.8000001907349px">Please forgive if there are any guideline omissions f=
or posting here from my part. This is my first post.</p><p class=3D"MsoNorm=
al" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" s=
tyle=3D"font-size:12.8000001907349px">Regards,</p><p class=3D"MsoNormal" st=
yle=3D"font-size:12.8000001907349px">Aravind.</p></div>
</blockquote></div><br></div>
</div></div><br></div></div>_______________________________________________=
<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>=
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div>

--001a11c326e2ecb9cb051a3798da--


--===============0589405757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0589405757==--
