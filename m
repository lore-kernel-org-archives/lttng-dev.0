From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Sat, 11 Jul 2015 12:56:51 +0530
Message-ID: <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA__726.427060044621$1436599673$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
 <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1506431252=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZDpBZ-0008Kg-RX
 for lttng-dev@lists.lttng.org; Sat, 11 Jul 2015 03:27:02 -0400
Received: by lbbyj8 with SMTP id yj8so17915278lbb.0
 for <lttng-dev@lists.lttng.org>; Sat, 11 Jul 2015 00:26:51 -0700 (PDT)
In-Reply-To: <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1506431252==
Content-Type: multipart/alternative; boundary=047d7b3a81fe895b84051a94693e

--047d7b3a81fe895b84051a94693e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

To try this fix, I also needed the changes talked about in
http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html ,
otherwise, I would see relayd coring.
Once I took them I could see that the soft hang issue was no longer
reproducible.

Thanks for helping.

On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> Sure, I will try the fix and update.
>
> On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> Would you mind testing Mathieu's patch?
>>
>> I have rebased it on stable-2.6:
>> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>>
>> Thanks,
>> J=C3=A9r=C3=A9mie=EF=BF=BC
>>
>>
>> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> Hi,
>>>
>>> What do you observe when this happens? Does the session daemon become
>>> unresponsive?
>>>
>>> J=C3=A9r=C3=A9mie
>>>
>>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>>
>>>> Request someone to kindly help with this. Blocked at this point, unabl=
e
>>>> to continue as any application crash leads to lttng not working.
>>>>
>>>> Thanks,
>>>> Aravind.
>>>>
>>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>>>> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>>
>>>>> I have recently started trying lttng 2.6 for a few applications on my
>>>>> Ubuntu 12.04 and I noticed that the health check on sessiond and cons=
umerd
>>>>> failed soon after starting the session.
>>>>>
>>>>>
>>>>> On investigating, I found that thread_manage_consumer() had exited
>>>>> causing an overall health check failure.
>>>>>
>>>>>
>>>>> Here are the sequence of steps that I found contributed to
>>>>> *thread_manage_consumer()* exiting.
>>>>>
>>>>>
>>>>> 1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)=
* is
>>>>> being called. This happens when there is an error detected by *revent=
s
>>>>> =3D LTTNG_POLL_GETEV(&events, i)*
>>>>>
>>>>> My initial guess here is that as one of my apps has crashed, producin=
g
>>>>> a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()*
>>>>>  causing *ust_app_unregister()* to be called for that app.
>>>>>
>>>>>
>>>>>
>>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is se=
t
>>>>> *.*
>>>>>
>>>>>
>>>>>
>>>>> (2.a) Note:* close_metadata() *also calls* consumer_close_metadata() =
*which
>>>>> sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>>>> consumerd to stop it from further dealing with the concerned app. Som=
ehow
>>>>> this doesn=E2=80=99t seem to help*.*
>>>>>
>>>>>
>>>>>
>>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for
>>>>> some reason has ignored the above 2.a and gets to do request/reply fo=
r that
>>>>> app by calling*ust_consumer_metadata_request():491 ->
>>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
>>>>> *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>>
>>>>>
>>>>>
>>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
>>>>> *thread_manage_consumer():1353* at which point
>>>>> *thread_manage_consumer()* decides to exit causing health_check() to
>>>>> fail.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> So it looks like under some scenario, an application crash could caus=
e
>>>>> the lttng some problems.
>>>>>
>>>>>
>>>>>
>>>>> I think a possible fix for this scenario, is to instead of 4, send an
>>>>> *ERROR* message back to *consumerd()* . This could be done from
>>>>> *ust_consumer_metadata_request()* call. Can someone please let me
>>>>> know if this is correct and shed more light on the issue ?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Please forgive if there are any guideline omissions for posting here
>>>>> from my part. This is my first post.
>>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Aravind.
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--047d7b3a81fe895b84051a94693e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To try this fix, I also needed the changes talked about in=
=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-July/02468=
9.html">http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html</a=
> , otherwise, I would see relayd coring.<div>Once I took them I could see =
that the soft hang issue was no longer reproducible.=C2=A0</div><div><br></=
div><div>Thanks for helping.</div></div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <span dir=
=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"ltr">Sure, I will try the fix and update.</div><div class=3D"HOEn=
Zb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_b=
lank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr">Would you mind testing Mathieu&#39;s pat=
ch?<div><br></div><div>I have rebased it on stable-2.6:</div><div><div>git =
clone <a href=3D"https://github.com/jgalar/lttng-tools.git" target=3D"_blan=
k">https://github.com/jgalar/lttng-tools.git</a> -b hang-fix<br></div></div=
><div><br></div><div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div=
></div><div><br></div></div><div><div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Gal=
arneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.c=
om" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>W=
hat do you observe when this happens? Does the session daemon become unresp=
onsive?</div><div><br></div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote"><div><div>On Wed, May 27, 2015=
 at 6:19 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@=
gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br>=
</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr">Reque=
st someone to kindly help with this. Blocked at this point, unable to conti=
nue as any application crash leads to lttng not working.<div><br></div><div=
>Thanks,</div><div>Aravind.</div></div><div><div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Thu, May 21, 2015 at 12:18 AM, Aravind H=
T <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_=
blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-size:12.8000=
001907349px">Hi,</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907=
349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349=
px">I have recently started trying lttng 2.6 for a few applications on my U=
buntu 12.04 and I noticed that the health check on sessiond and consumerd f=
ailed soon after starting the session.</p><p class=3D"MsoNormal" style=3D"f=
ont-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-s=
ize:12.8000001907349px">On investigating, I found that thread_manage_consum=
er() had exited causing an overall health check failure.</p><p class=3D"Mso=
Normal" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNorma=
l" style=3D"font-size:12.8000001907349px">Here are the sequence of steps th=
at I found contributed to=C2=A0<b>thread_manage_consumer()</b>=C2=A0exiting=
.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"></p><p c=
lass=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p style=
=3D"font-size:12.8000001907349px">1.<span style=3D"font-stretch:normal;font=
-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() : 1558 , ust_app_u=
nregister(pollfd)</b>=C2=A0is being called. This happens when there is an e=
rror detected by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&amp;events, i)</b></=
p><p style=3D"font-size:12.8000001907349px">My initial guess here is that a=
s one of my apps has crashed, producing a=C2=A0<b>LPOLLERR | LPOLLHUP | LPO=
LLRDHUP=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=C2=A0causing=C2=A0=
<b>ust_app_unregister()</b>=C2=A0to be called for that app.</p><p style=3D"=
font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8000001907=
349px">2.<span style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;=
Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=
=C2=A0<b>ust_app_unregister():3154 , close_metadata(registry, ua_sess-&gt;c=
onsumer)=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;metadata_closed =3D 1=
=C2=A0</b>is set<b>.</b></p><p style=3D"font-size:12.8000001907349px;text-i=
ndent:0.5in">=C2=A0</p><p style=3D"font-size:12.8000001907349px;text-indent=
:0.5in">(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>also calls<b>=C2=A0co=
nsumer_close_metadata()=C2=A0</b>which sends<b>=C2=A0LTTNG_CONSUMER_CLOSE_M=
ETADATA=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the consumerd to stop=
 it from further dealing with the concerned app. Somehow this doesn=E2=80=
=99t seem to help<b>.</b></p><p style=3D"font-size:12.8000001907349px"><b>=
=C2=A0</b></p><p style=3D"font-size:12.8000001907349px">3.<span style=3D"fo=
nt-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see that the=C2=A0<b>=
thread_manage_consumer():1353</b>=C2=A0for some reason has ignored the abov=
e 2.a and gets to do request/reply for that app by calling<b>ust_consumer_m=
etadata_request():491 -&gt; ust_app_push_metadat(ust_reg, socket,1)=C2=A0</=
b>which at line 460 checks for=C2=A0<b>registry-&gt;metadata_closed</b>=C2=
=A0and returns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"MsoNormal" styl=
e=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.80000=
01907349px">4.<span style=3D"font-stretch:normal;font-size:7pt;font-family:=
&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span=
>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the way back up to=
=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0at which point=C2=A0<b>thre=
ad_manage_consumer()</b>=C2=A0decides to exit causing health_check() to fai=
l.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNorma=
l" style=3D"font-size:12.8000001907349px">So it looks like under some scena=
rio, an application crash could cause the lttng some problems.</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D=
"MsoNormal" style=3D"font-size:12.8000001907349px">I think a possible fix f=
or this scenario, is to instead of 4, send an=C2=A0<b>ERROR</b>=C2=A0messag=
e back to=C2=A0<b>consumerd()</b>=C2=A0. This could be done from=C2=A0<b>us=
t_consumer_metadata_request()</b>=C2=A0call. Can someone please let me know=
 if this is correct and shed more light on the issue ?</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNorma=
l" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" =
style=3D"font-size:12.8000001907349px">Please forgive if there are any guid=
eline omissions for posting here from my part. This is my first post.</p><p=
 class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p clas=
s=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Regards,</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Aravind.</p></div>
</blockquote></div><br></div>
</div></div><br></div></div>_______________________________________________=
<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9=
r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a></div>
</div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--047d7b3a81fe895b84051a94693e--


--===============1506431252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1506431252==--
