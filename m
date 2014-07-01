From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: LTTng on Android
Date: Tue, 1 Jul 2014 11:55:22 +0200
Message-ID: <CAEiAFz3=1mNiJeQSSJOafrEPM1UUdB-y_wbcw04HWRkZ9j6PKQ__17708.0992762514$1404208570$gmane$org@mail.gmail.com>
References: <CAEiAFz0ZvV6zk5X_jpH=hGToXQXb9q1AgR-uS2KCXk3fO++JNA@mail.gmail.com>
 <CACnpWGS9-69gzKg_ct-e4ToqnVB4WVWBnkFFWQSSBm9djwqf6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1124086054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1X1ume-0003u4-BG
 for lttng-dev@lists.lttng.org; Tue, 01 Jul 2014 05:55:29 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so8318377qcy.15
 for <lttng-dev@lists.lttng.org>; Tue, 01 Jul 2014 02:55:22 -0700 (PDT)
In-Reply-To: <CACnpWGS9-69gzKg_ct-e4ToqnVB4WVWBnkFFWQSSBm9djwqf6g@mail.gmail.com>
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

--===============1124086054==
Content-Type: multipart/alternative; boundary=001a11c3061032d5c804fd1ec678

--001a11c3061032d5c804fd1ec678
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Charles,

thanks for your answer. So the main problem seems to be bionic and missing
headers of the NDK. How about compiling LTTng user-space as static to avoid
these issues?

Cheers,
Jan


2014-06-30 19:47 GMT+02:00 Charles Bri=C3=A8re <charles.briere@polymtl.ca>:

> Hi Jan,
>
> I was part of the students working on it a year ago. We had kernel tracin=
g
> working at the time, though we had some trouble as bionic doesn't have
> pthread_cancel. I think we had replaced that by a dummy pthread_kill at t=
he
> time and that is part of the reason our patches were not accepted.
>
> I recently resent some patches for libURCU so this should not be a proble=
m
> to compile for android out of master branch, even with NDK.
>
> I have been trying lately to get lttng-tools compiling out of NDK (faster
> than checking out the whole Android tree) but there is a lot of headers
> missing, most important are related to shared memory. I was about to
> continue working on it, this time with the whole Android tree, but ran ou=
t
> of disk space so had to postpone until I receive some more storage. I hop=
e
> I'll be able to release patches within the next month.
>
> Cheers,
> Charles
>
>
> On Mon, Jun 30, 2014 at 7:03 AM, Jan Glauber <jan.glauber@gmail.com>
> wrote:
>
>> Hi LTTngers,
>>
>> I want to ask about the status of LTTng on Android. Is anyone using it
>> already? I remember there was some student project to get LTTng running
>> with bionic but I don't know how far they got.
>>
>> thanks, Jan
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>

--001a11c3061032d5c804fd1ec678
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Charles,<br><br>thanks for your answer. So the mai=
n problem seems to be bionic and missing headers of the NDK. How about comp=
iling LTTng user-space as static to avoid these issues?<br><br></div>Cheers=
,<br>
Jan<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">=
2014-06-30 19:47 GMT+02:00 Charles Bri=C3=A8re <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:charles.briere@polymtl.ca" target=3D"_blank">charles.briere@pol=
ymtl.ca</a>&gt;</span>:<br>
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
l_extra"><br><br><div class=3D"gmail_quote"><div><div class=3D"h5">On Mon, =
Jun 30, 2014 at 7:03 AM, Jan Glauber <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:jan.glauber@gmail.com" target=3D"_blank">jan.glauber@gmail.com</a>&gt;</s=
pan> wrote:<br>

</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div dir=
=3D"ltr"><div><div>Hi LTTngers,<br><br></div>I want to ask about the status=
 of LTTng on Android. Is anyone using it already? I remember there was some=
 student project to get LTTng running with bionic but I don&#39;t know how =
far they got.<br>


<br></div>thanks, Jan<br></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>

--001a11c3061032d5c804fd1ec678--


--===============1124086054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1124086054==--
