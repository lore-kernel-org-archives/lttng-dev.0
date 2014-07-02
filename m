From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: LTTng on Android
Date: Wed, 2 Jul 2014 17:18:36 +0200
Message-ID: <CAEiAFz0E6S=bF8MHzZ6=hCAmsNXykRXFVcjGCsTLyFAPSvvNhQ__30555.4045866758$1404314383$gmane$org@mail.gmail.com>
References: <CAEiAFz0ZvV6zk5X_jpH=hGToXQXb9q1AgR-uS2KCXk3fO++JNA@mail.gmail.com>
 <CACnpWGS9-69gzKg_ct-e4ToqnVB4WVWBnkFFWQSSBm9djwqf6g@mail.gmail.com>
 <CAEiAFz3=1mNiJeQSSJOafrEPM1UUdB-y_wbcw04HWRkZ9j6PKQ@mail.gmail.com>
 <CACnpWGToZuw95X_EhohmwD0niHbY7hhkWjKd7neZqgrkj1mCHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0537425203=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1X2MIz-0006H6-MX
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 11:18:47 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so9097564qab.3
 for <lttng-dev@lists.lttng.org>; Wed, 02 Jul 2014 08:18:36 -0700 (PDT)
In-Reply-To: <CACnpWGToZuw95X_EhohmwD0niHbY7hhkWjKd7neZqgrkj1mCHw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Charles_Bri=C3=A8re?= <charles.briere@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0537425203==
Content-Type: multipart/alternative; boundary=047d7b5d25a8f7ab0404fd376784

--047d7b5d25a8f7ab0404fd376784
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

For long term I think it is the right thing to port LTTng to
bionic/android. What I mean is to get a running version without going
through this hassle,
e.g. taking a non-android buildroot and compile LTTng static with matching
flags for the android target. This should be possible, I just wanted
to ask if anyone had success going this way or if there is something I'm
missing.

thx,
Jan


2014-07-01 19:35 GMT+02:00 Charles Bri=C3=A8re <charles.briere@polymtl.ca>:

> Hi Jan,
>
> Even when disabling ust while configuring, there is still some "shm_open"
> (need to be replaced by ashmem) and "pthread_cancel" calls within the too=
ls
> code. But I don't understand what you mean by using static linking. How
> would that help in the case where you are missing headers?
>
> Cheers,
> Charles
>
>
> On Tue, Jul 1, 2014 at 2:55 AM, Jan Glauber <jan.glauber@gmail.com> wrote=
:
>
>> Hi Charles,
>>
>> thanks for your answer. So the main problem seems to be bionic and
>> missing headers of the NDK. How about compiling LTTng user-space as stat=
ic
>> to avoid these issues?
>>
>> Cheers,
>> Jan
>>
>>
>> 2014-06-30 19:47 GMT+02:00 Charles Bri=C3=A8re <charles.briere@polymtl.c=
a>:
>>
>> Hi Jan,
>>>
>>> I was part of the students working on it a year ago. We had kernel
>>> tracing working at the time, though we had some trouble as bionic doesn=
't
>>> have pthread_cancel. I think we had replaced that by a dummy pthread_ki=
ll
>>> at the time and that is part of the reason our patches were not accepte=
d.
>>>
>>> I recently resent some patches for libURCU so this should not be a
>>> problem to compile for android out of master branch, even with NDK.
>>>
>>> I have been trying lately to get lttng-tools compiling out of NDK
>>> (faster than checking out the whole Android tree) but there is a lot of
>>> headers missing, most important are related to shared memory. I was abo=
ut
>>> to continue working on it, this time with the whole Android tree, but r=
an
>>> out of disk space so had to postpone until I receive some more storage.=
 I
>>> hope I'll be able to release patches within the next month.
>>>
>>> Cheers,
>>> Charles
>>>
>>>
>>> On Mon, Jun 30, 2014 at 7:03 AM, Jan Glauber <jan.glauber@gmail.com>
>>> wrote:
>>>
>>>> Hi LTTngers,
>>>>
>>>> I want to ask about the status of LTTng on Android. Is anyone using it
>>>> already? I remember there was some student project to get LTTng runnin=
g
>>>> with bionic but I don't know how far they got.
>>>>
>>>> thanks, Jan
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>
>>
>

--047d7b5d25a8f7ab0404fd376784
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>For long term I think it is the right thing to p=
ort LTTng to bionic/android. What I mean is to get a running version withou=
t going through this hassle,<br>e.g. taking a non-android buildroot and com=
pile LTTng static with matching flags for the android target. This should b=
e possible, I just wanted<br>
</div>to ask if anyone had success going this way or if there is something =
I&#39;m missing.<br><br></div>thx,<br>Jan<br></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">2014-07-01 19:35 GMT+02:00 Charles Br=
i=C3=A8re <span dir=3D"ltr">&lt;<a href=3D"mailto:charles.briere@polymtl.ca=
" target=3D"_blank">charles.briere@polymtl.ca</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Jan,<div><br></div><div>=
Even when disabling ust while configuring, there is still some &quot;shm_op=
en&quot; (need to be replaced by ashmem) and &quot;pthread_cancel&quot; cal=
ls within the tools code. But I don&#39;t understand what you mean by using=
 static linking. How would that help in the case where you are missing head=
ers?</div>

<div><br></div><div>Cheers,</div><div>Charles</div></div><div class=3D"HOEn=
Zb"><div class=3D"h5"><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">On Tue, Jul 1, 2014 at 2:55 AM, Jan Glauber <span dir=3D"ltr">&lt;=
<a href=3D"mailto:jan.glauber@gmail.com" target=3D"_blank">jan.glauber@gmai=
l.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi Charles,<br><br>tha=
nks for your answer. So the main problem seems to be bionic and missing hea=
ders of the NDK. How about compiling LTTng user-space as static to avoid th=
ese issues?<br>

<br></div>Cheers,<br>
Jan<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">=
2014-06-30 19:47 GMT+02:00 Charles Bri=C3=A8re <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:charles.briere@polymtl.ca" target=3D"_blank">charles.briere@pol=
ymtl.ca</a>&gt;</span>:<div>

<div><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Jan,<div><br></div><div>=
I was part of the students working on it a year ago. We had kernel tracing =
working at the time, though we had some trouble as bionic doesn&#39;t have =
pthread_cancel. I think we had replaced that by a dummy pthread_kill at the=
 time and that is part of the reason our patches were not accepted.</div>



<div><br></div><div>I recently resent some patches for libURCU so this shou=
ld not be a problem to compile for android out of master branch, even with =
NDK.</div><div><br></div><div>I have been trying lately to get lttng-tools =
compiling out of NDK (faster than checking out the whole Android tree) but =
there is a lot of headers missing, most important are related to shared mem=
ory. I was about to continue working on it, this time with the whole Androi=
d tree, but ran out of disk space so had to postpone until I receive some m=
ore storage. I hope I&#39;ll be able to release patches within the next mon=
th.=C2=A0</div>



<div><br></div><div>Cheers,</div><div>Charles</div></div><div class=3D"gmai=
l_extra"><br><br><div class=3D"gmail_quote"><div><div>On Mon, Jun 30, 2014 =
at 7:03 AM, Jan Glauber <span dir=3D"ltr">&lt;<a href=3D"mailto:jan.glauber=
@gmail.com" target=3D"_blank">jan.glauber@gmail.com</a>&gt;</span> wrote:<b=
r>



</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr"><div>=
<div>Hi LTTngers,<br><br></div>I want to ask about the status of LTTng on A=
ndroid. Is anyone using it already? I remember there was some student proje=
ct to get LTTng running with bionic but I don&#39;t know how far they got.<=
br>




<br></div>thanks, Jan<br></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div></div></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--047d7b5d25a8f7ab0404fd376784--


--===============0537425203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0537425203==--
