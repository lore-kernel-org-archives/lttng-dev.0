From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Mon, 23 Mar 2015 17:17:55 +0530
Message-ID: <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA__20978.3333623365$1427111355$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1978360007=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Ya0pt-00071s-1Z
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 07:48:04 -0400
Received: by wibg7 with SMTP id g7so33235293wib.1
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2015 04:47:55 -0700 (PDT)
In-Reply-To: <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chidhu R <chid1989@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1978360007==
Content-Type: multipart/alternative; boundary=f46d043c7db0a087f40511f33c14

--f46d043c7db0a087f40511f33c14
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm sorry to bump on this thread again.

Is there any way to overcome this issue?

Thanks,
Anand Neeli

On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <chid1989@gmail.com> wrote:

> I too am getting the same errors. Inspite of setting LTTNG_HOME in my
> program.
>
> On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com>
> wrote:
>
>> Hi All,
>>
>> any idea when do we get this error?
>>
>> app: libust[4745/4745]: Warning: HOME environment variable not set.
>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>> lttng-ust-comm.c:385)
>> app: libust[4751/4751]: Warning: HOME environment variable not set.
>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>> lttng-ust-comm.c:385)
>> app: libust[4760/4760]: Warning: HOME environment variable not set.
>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>> lttng-ust-comm.c:385)
>> app: libust[4780/4780]: Warning: HOME environment variable not set.
>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>> lttng-ust-comm.c:385)
>>
>> i have set LTTNG_HOME=HOME=/home/root
>> using 2.6
>>
>> Thanks,
>> Anand Neeli
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>

--f46d043c7db0a087f40511f33c14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m sorry to bump on this thread again.</d=
iv><div><br></div><div>Is there any way to overcome this issue?</div><div><=
br></div><div>Thanks,</div><div>Anand Neeli</div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Wed, Mar 18, 2015 at 10:01 PM, Chi=
dhu R <span dir=3D"ltr">&lt;<a href=3D"mailto:chid1989@gmail.com" target=3D=
"_blank">chid1989@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr">I too am getting the same errors. Inspite of sett=
ing LTTNG_HOME in my program.=C2=A0</div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote"><div><div class=3D"h5">On Tue, Mar 17, 2015 at 2:18=
 PM, Anand Neeli <span dir=3D"ltr">&lt;<a href=3D"mailto:anand.neeli@gmail.=
com" target=3D"_blank">anand.neeli@gmail.com</a>&gt;</span> wrote:<br></div=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div dir=3D"lt=
r">Hi All,<div><br></div><div>any idea when do we get this error?</div><div=
><br></div><div><div>app: libust[4745/4745]: Warning: HOME environment vari=
able not set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() =
at lttng-ust-comm.c:385)</div><div>app: libust[4751/4751]: Warning: HOME en=
vironment variable not set. Disabling LTTng-UST per-user tracing. (in setup=
_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4760/4760]: Wa=
rning: HOME environment variable not set. Disabling LTTng-UST per-user trac=
ing. (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[=
4780/4780]: Warning: HOME environment variable not set. Disabling LTTng-UST=
 per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385)</div></d=
iv><div><br></div><div>i have set LTTNG_HOME=3DHOME=3D/home/root</div><div>=
using 2.6</div><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div>=
<br></div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>

--f46d043c7db0a087f40511f33c14--


--===============1978360007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1978360007==--
